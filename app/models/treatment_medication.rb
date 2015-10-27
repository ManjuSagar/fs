# == Schema Information
#
# Table name: treatment_medications
#
#  id                     :integer          not null, primary key
#  treatment_id           :integer          not null
#  treatment_episode_id   :integer          not null
#  medication_name        :string(255)      not null
#  medication_code        :string(1)        not null
#  dosage                 :string(255)
#  frequency              :string(255)
#  purpose                :string(255)
#  potential_side_effects :string(255)
#  start_date             :date             not null
#  discontinued_date      :date
#  medication_status      :string(1)        not null
#  end_date               :date
#  visit_id               :integer
#  assessment_date        :date             not null
#

class TreatmentMedication < ActiveRecord::Base
  belongs_to :treatment, :class_name => 'PatientTreatment', :foreign_key => :treatment_id
  belongs_to :treatment_visit, :class_name => 'TreatmentVisit', :foreign_key => :visit_id
  belongs_to :episode, :class_name => 'TreatmentEpisode', :foreign_key => :treatment_episode_id
  belongs_to :fda_drug_library
  belongs_to :created_user, :class_name => "User"

  after_initialize :set_defaults, :if => :new_record?
  before_validation :assign_treatment

  scope :org_scope, lambda { includes({:treatment => {:patient => :patient_detail}}).where({:patient_details => {:org_id => Org.current.id}}) if Org.current}

  MEDICATION_CODES = [[' ', '---'], ['N', 'N'], ['C', 'C'], ['L', 'L']]
  audited :associated_with => :treatment, :allow_mass_assignment => true

  #validates :medication_name, :presence => true
  validates :medication_code, :length => {:maximum => 1}
  validates :start_date, :presence => true
  validates :episode, :presence => true
  validates :medication_name, :presence => true
  validate :treatment_medication_period

  include AASM
  STATE_MAP = {:active => 'A', :draft => 'D', :discontinued => 'F'}
  aasm :column => :medication_status do
    state :draft, :initial => true
    state :active
    state :discontinued

    event :verify do
      transitions :to => :active, :from => :draft
    end

    event :mark_as_not_verified do
      transitions :to => :draft, :from => :active
    end

    event :continue, :after => :remove_discontinued_date do
      transitions :to => :active, :from => :discontinued
    end

    event :discontinue do
      transitions :to => :discontinued, :from => :active, guard: :system_driven_event?
    end

  end

  attr_accessor :medication_list_date
  
  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :medication_status
    write_attribute_without_mapping(attr, v)
  end

  def medication_status
    STATE_MAP.invert[read_attribute(:medication_status)]
  end
  
  attr_accessor :system_driven_event

  def system_driven_event?
    self.system_driven_event == true
  end

  def remove_discontinued_date
    self.update_attributes({:discontinued_date => nil})
  end

  def active_as_on_date?(date)
    result = false
    if self.active? or self.discontinued?
      result = end_date.present? ? (start_date <= date and end_date >= date) : start_date <= date
      result = (result && self.discontinued_date >= date) if self.discontinued?
    end
    result
  end

  def create_pdf
    file_content = Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/medication/medication.jasper", self, {}, {})
    file = File.open("/home/msuser1/Desktop/test.pdf", "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end

  def assessment_date_format
    self.assessment_date.strftime("%m/%d/%Y")
  end

  def medications
    medication_tags = []
    medication_attrs_for_display = ["assessment_date", "medication_description", "purpose", "potential_side_effects"]
    active_medications = treatment.active_medications_as_on_date(medication_list_date)
    active_medications.each do |medi|
      medication_row = {}
      medication_attrs_for_display.each do |attr|
        attr_value = medi.send(attr)
        medication_row[attr] = (attr_value.is_a? Date)? attr_value.strftime("%m/%d/%y") : attr_value
      end
      medication_tags << medication_row
    end
    5.times.each do |i|
      medication_row = {}
      medication_attrs_for_display.each do |attr|
        medication_row[attr] = nil
      end
      medication_tags << medication_row
    end
    medication_tags
  end

  def medication_description
    content = ""
    content = "#{medication_name}"
    content += " - #{dosage_form}" if dosage_form.present?
    content += " - #{frequency}" if frequency.present?
    content += " - (#{medication_code})" if medication_code.present?
    content
  end

  def patient_name
    treatment.to_s
  end

  def patient_address
    treatment.patient.location
  end

  def patient_contact
    "Tel #{treatment.patient.phone_number}" if treatment.patient.phone_number.present?
  end

  def agency_name
    treatment.health_agency_name
  end

  def agency_address
    treatment.patient.agency_address
  end

  def agency_contact
    "Tel #{treatment.patient.agency_phone_number} | Fax #{treatment.patient.agency_fax_number}"
  end

  def allergies
    plan_of_care = treatment.documents.order("id DESC").detect{ |d| d.respond_to?("is_poc?")}
    plan_of_care.present?? plan_of_care.allergies : nil
  end

  def patient_mr_number
    "MR # : #{treatment.patient.patient_reference}"
  end

  def to_xml(options = {})
    super :methods => [:medications,
                       :agency_name,
                       :agency_address,
                       :agency_contact,
                       :patient_name,
                       :patient_address,
                       :patient_contact,
                       :allergies,
                       :patient_mr_number
    ]
  end

  private
  
   def assign_treatment
     self.treatment = self.treatment_visit.treatment if self.treatment.nil? and treatment_visit.present?
   end
   
   def set_defaults
     self.assessment_date = Date.current
     self.start_date = self.treatment_visit.present? ? self.treatment_visit.visit_start_time.to_date : Date.current
     self.created_user = User.current
   end
   
   def treatment_medication_period
     return unless episode
     return if (['C', 'L'].include? self.medication_code or self.medication_code == nil)
        errors.add(:start_date, "Start date should be with in the Episode.") if self.start_date.present? and start_date_with_in_episode? == false
        errors.add(:end_date, "End date should be with in the Episode.") if self.end_date.present? and end_date_with_in_episode? == false
		if (self.start_date.present? and self.end_date.present?) 			
			errors.add(:start_date, "Start date should be earlier than or equal to End date.") if self.start_date > self.end_date
			errors.add(:end_date, "End date should be later than or equal to Start date.") if self.end_date < self.start_date
		end
   end
  
   def start_date_with_in_episode?
     self.start_date >= self.episode.start_date and self.start_date <= self.episode.end_date
   end 
  
   def end_date_with_in_episode?
     self.episode.end_date >= self.end_date and self.end_date >= self.episode.start_date
   end 
  
end
