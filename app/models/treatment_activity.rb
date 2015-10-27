# == Schema Information
#
# Table name: treatment_activities
#
#  id                   :integer          not null, primary key
#  treatment_id         :integer          not null
#  discipline_id        :integer
#  activity_date        :datetime         not null
#  created_user_id      :integer          not null
#  activity_reason_code :string(255)
#  activity_details     :text
#  lock_version         :integer
#  activity_type        :string(255)      not null
#

class TreatmentActivity < ActiveRecord::Base
  belongs_to :treatment, :class_name => "PatientTreatment" ,:foreign_key => :treatment_id
  belongs_to :discipline
  belongs_to :created_user, :class_name => "User", :foreign_key => :created_user_id
  after_save :create_medical_order, :if => :medical_order_required
  before_create :set_defaults
  after_create :perform_activity
  after_create :create_hold_and_unhold_activity_details
  audited :associated_with => :treatment, :allow_mass_assignment => true
  has_many :all_documents, :as => :documentable, :dependent => :destroy

  scope :org_scope, lambda { includes(:treatment => {:patient => :patient_detail}).where({:patient_details => {:org_id => Org.current.id}}) if Org.current}
  attr_accessor :medical_order_required, :episode
  netzke_attribute :medical_order_required, type: :boolean
  netzke_attribute :episode


  validates :activity_date, :presence => true
  validate :activity_date_range
  validate :can_unhold_treatment

  DISCHARGE = 'D'
  HOLD = 'H'
  UNHOLD = 'U'

  TRANSFER_REASON_CODES = ['02', '03', '04', '05', '06']
  DEATH_REASON_CODES = ['40', '41', '42']
  DISCHARGE_REASON_CODES = PatientTreatment::DISCHARGE_REASONS.collect{|r| r[0]}
  HOLD_REASON_CODES = ['1', '2', '3']

  ACTIVITIES = {'D' => 'Discharge', 'H' => 'Hold', 'U' => 'Unhold'}

  def activity_date_range
    treatment_episode = TreatmentEpisode.find(episode)
    if (treatment_episode and activity_date and activity_type != 'U')
      errors.add(:activity_date, "should be within the Episode") unless (treatment_episode.start_date .. treatment_episode.end_date).include? activity_date.to_date
    end
  end

  def can_unhold_treatment
    treatment_episode = TreatmentEpisode.find(episode)
    if (treatment_episode and activity_date and activity_type=="U")
      #prev_episode = treatment(treatment_episode)
      #last_hold_date = treatment.treatment_activities.where(activity_type: 'H').order('id DESC').first.activity_date
      #res = prev_episode.present? and (activity_date >= treatment_episode.start_date + 1) and
         #(prev_episode.start_date..prev_episode.end_date).include? last_hold_date
      if (activity_date >= treatment_episode.end_date + 2)
        errors.add(:activity_date, "You can't resume, please create new treatment")
      end
    end
  end

  private

  def set_defaults
    self.created_user = User.current
  end
  
  def create_medical_order
    order = treatment.medical_orders.build
    order.treatment_episode = treatment.treatment_episodes.last
    order.physician = treatment.primary_physician
    order.created_user = User.current
    order.order_status = :draft
    order.order_content = order_content
    order.order_type = order_type
    order.order_date = self.activity_date
    order.save!
  end
  
  def order_content
		content = []
		content << "Discipline: #{TreatmentDiscipline.find(discipline_id).discipline.discipline_description}" if discipline_id.present?
    content << self.activity_details
    content.join("\n")
  end
  
  def order_type
    org = treatment.patient.org
    if activity_type == HOLD
      OrderType.hold(org)
    elsif activity_type == UNHOLD
      OrderType.unhold(org)
    else
      OrderType.discharge(org)
    end
  end

  def perform_activity
    event = ACTIVITIES[activity_type]
    event_name = event.downcase
    if discipline_id
      treatment_discipline = TreatmentDiscipline.find(discipline_id)
      treatment_discipline.send("#{event_name}!")
    else
      treatment.send("#{event_name}!")
      treatment.update_column(:treatment_end_date, activity_date) if activity_type == "D"
    end
  end

   public

  def create_hold_and_unhold_activity_details
    event = ACTIVITIES[activity_type]
    if (event == 'Hold'|| event =='Unhold')

      description = (event == 'Hold') ?  PatientTreatment::HOLD_REASONS[activity_reason_code.to_i - 1].last : PatientTreatment::UNHOLD_REASONS[activity_reason_code.to_i - 1].last

    treatment_episode = TreatmentEpisode.find(episode)
    status = (event == 'Hold') ? 'HOLD-ON': 'HOLD-OFF'
      treatment_discipline = TreatmentDiscipline.where(id: self.discipline_id).first
      discipline = treatment_discipline.present? ? treatment_discipline.to_s :  "All Disciplines"
      document = self.all_documents.build(:treatment_episode => treatment_episode, :category=> discipline,
                                          :description => description, :status => status)
      document.document_date = activity_date

    end
  end
end
