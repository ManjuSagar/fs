# == Schema Information
#
# Table name: treatment_disciplines
#
#  id               :integer          not null, primary key
#  treatment_id     :integer          not null
#  discipline_id    :integer          not null
#  treatment_status :string(1)        default("N"), not null
#  lock_version     :integer          default(0)
#

class TreatmentDiscipline < ActiveRecord::Base
  belongs_to :treatment, :class_name => "PatientTreatment", :foreign_key => :treatment_id
  belongs_to :discipline
  belongs_to :treatment_episode

  validates_presence_of :discipline

  audited :associated_with => :treatment, :allow_mass_assignment => true

  scope :episode_scope, lambda {|episode| where(:treatment_episode_id => episode) if episode}

  after_create :activate_if_required
  after_save :update_denormalized_patient_list

  include AASM
  STATE_MAP = {:pending_evaluation => 'P', :active => 'A', :on_hold => 'O', :discharged => 'D'}
  aasm :column => :treatment_status do
    state :pending_evaluation, :initial => true
    state :active, :after_enter => :activate_patient_treatment_if_required
    state :on_hold
    state :discharged, :after_enter => :discharge_patient_treatment_if_required

    event :activate do
      transitions :to => :active, :from => :pending_evaluation, :guard => :system_driven_event?
    end

    event :deactivate, :after => :deactivate_treatment_if_required do
      transitions :to => :pending_evaluation, :from => :active, :guard => :system_driven_event?
    end

    event :hold do
      transitions :to => :on_hold, :from => [:pending_evaluation, :active], :guard => :current_user_is_office_staff?
    end

    event :unhold do
      transitions :to => :active, :from => :on_hold, :guard => :current_user_is_office_staff?
    end

    event :discharge do
      transitions :to => :discharged, :from => [:pending_evaluation, :active, :on_hold], :guard => :current_user_is_office_staff?
    end

    TreatmentDiscipline.aasm_states.map(&:name).each {|state|
      event "transition_to_#{state}".to_sym do
        transitions :from => TreatmentDiscipline.aasm_states.map(&:name), :to => state , :guard => :system_driven_event?
      end
    }

  end

  attr_accessor :system_driven_event

  def update_denormalized_patient_list
    patient = treatment_episode.treatment.patient

    d = DenormalizedPatientList.where(:patient_id => patient.id, :org_id => Org.current.id)

    if d.present?
      DenormalizedPatientList.update_with(patient)
    end
  end

  def system_driven_event?
    self.system_driven_event == true
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr == :treatment_status
    write_attribute_without_mapping(attr, v)
  end

  def treatment_status
    STATE_MAP.invert[read_attribute(:treatment_status)]
  end

  def current_user_is_office_staff?
    User.current.office_staff?
  end

  def activate_patient_treatment_if_required
    treatment.system_driven_event = true
    treatment.activate! if treatment.may_activate?
    treatment.system_driven_event = false
  end

  def deactivate_treatment_if_required
    treatment.system_driven_event = true
    treatment.deactivate! if treatment.may_deactivate?
    treatment.system_driven_event = false
  end

  def discharge_patient_treatment_if_required
    if treatment.all_disciplines_are_discharged?
      treatment.discharge! if treatment.may_discharge?
    end
  end

  def to_s
    discipline.discipline_description
  end

  def self.get_disciplines_for_store(treatment_id, episode_id)
    treatment = PatientTreatment.find(treatment_id)
    episode = treatment.treatment_episodes.find(episode_id)

    episode_disciplines = episode.disciplines
    remaining_disciplines = Discipline.all - episode_disciplines
    values = remaining_disciplines.collect{|d| [d.id, d.discipline_description]}
    {:data => values}
  end
  private

  def activate_if_required
    previous_episode = treatment.previous_episode(treatment_episode)
    self.system_driven_event = true
    self.activate! if previous_episode and self.may_activate?
    self.system_driven_event = false
    nil
  end

end
