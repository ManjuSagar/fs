# == Schema Information
#
# Table name: electronic_routesheets
#
#  id                     :integer          not null, primary key
#  visit_id               :integer          not null
#  location_latitude      :string(255)
#  location_longitude     :string(255)
#  signature_file_name    :string(255)      not null
#  signature_content_type :string(255)      not null
#  signature_file_size    :integer          not null
#  signature_updated_at   :datetime         not null
#  generated_status       :string(2)        not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'jasper-rails'
class ElectronicRoutesheet < ActiveRecord::Base
  include JasperRails
  has_attached_file :signature, :styles => {:thumb => "200x200"}
  belongs_to :treatment_visit, :foreign_key => :visit_id
  before_create :create_visit, :save_signatures
  after_initialize :set_defaults, :if => :new_record?
  after_save :save_attachments, :unless =>  :route_sheet_exists?

  audited :associated_with => :treatment_visit, :allow_mass_assignment => true

  netzke_attribute :patient_signature_data
 attr_accessor :patient_signature_data
 netzke_attribute :treatment_episode
 attr_accessor :supervised_user_id, :treatment_episode, :visit_start_time, :visit_end_time, :visited_staff_type, :visit_type_id, :treatment_id,
               :vitals_validate, :visit_date, :visit_end_date, :systolic_bp, :diastolic_bp, :bp_read_position, :heart_rate, :respiration_rate,
               :temperature_in_fht, :blood_sugar, :sugar_read_period,  :weight_in_lbs, :oxygen_saturation, 
                :bp_read_location, :pain, :start_time_hour, :start_time_min, :end_time_hour, :end_time_min
  netzke_attribute :supervised_user_id
 netzke_attribute :visited_user_id
 netzke_attribute :visit_start_time
 netzke_attribute :visit_end_time
 netzke_attribute :visit_type_id
 netzke_attribute :treatment_id
 netzke_attribute :visited_staff_type
 netzke_attribute :visited_staff_id
 netzke_attribute :visit_date, :type => :date
 netzke_attribute :visit_end_date, :type => :date
 netzke_attribute :start_time_hour
 netzke_attribute :start_time_min
 netzke_attribute :end_time_hour
 netzke_attribute :end_time_min

  validates :treatment_episode, :presence => true
  validates :start_time_hour, :presence => true
  validates :start_time_min, :presence => true
  validates :end_time_hour, :presence => true
  validates :end_time_min, :presence => true
  validates :visit_type_id, :presence => true
  validates :patient_signature_data, :presence => true
  validates :supervised_user_id, :presence => true, :if => :dependent_fs?

  validate :systolic_bp_check
  validate :check_visit_timing

  netzke_attribute :systolic_bp
  netzke_attribute :diastolic_bp
  netzke_attribute :bp_read_position
  netzke_attribute :heart_rate
  netzke_attribute :respiration_rate
  netzke_attribute :temperature_in_fht
  netzke_attribute :blood_sugar
  netzke_attribute :sugar_read_period
  netzke_attribute :weight_in_lbs
  netzke_attribute :oxygen_saturation
  netzke_attribute :bp_read_location
  netzke_attribute :pain

  def dependent_fs?
    not User.current.independent_fs?
  end

  def systolic_bp_check
    unless ((systolic_bp.present? and diastolic_bp.present? and bp_read_position.present? and bp_read_location.present?) ||
        (systolic_bp.present? == false and diastolic_bp.present? ==false and bp_read_position.present? == false and bp_read_location.present? == false))
      self.errors.add(:systolic_bp, " is required.") unless systolic_bp.present?
      self.errors.add(:diastolic_bp, " is required.") unless diastolic_bp.present?
      self.errors.add(:bp_read_position, " is required." ) unless bp_read_position.present?
      self.errors.add(:bp_read_location, " is required." ) unless bp_read_location.present?
    end
  end

  def route_sheet_exists?
    self.treatment_visit.attachments.any?{|x| x.attachment_type == AttachmentType.route_sheet(self.treatment_visit.treatment.patient.org.id)}
  end

  def patient_location_path
    return unless location_latitude or location_longitude
    map_image = map_for_location(location_latitude, location_longitude)
    file = Tempfile.new(["map", ".png"])
    file.binmode
    require 'base64'
    file.write(map_image)
    file.close
    file.path
  end

  def self.supervised_users_list(treatment_id)
    list = [[nil, "---"]]
    treatment = PatientTreatment.find(treatment_id)
    #treatment_staffs = treatment.treatment_staffs.staffed.where({:staff_type => "User", :staff_id => User.current.id})
    independent_staffs =  treatment.treatment_staffs.staffed.select{|s| s.staff_type == "User" and s.staff.license_type.independent_flag}
    list += independent_staffs.collect{|is| [is.staff.id, is.staff.full_name]}.uniq
    list
  end

  def self.treatment_episodes_list(treatment_id)
		list = [[nil, "---"]]
    PatientTreatment.find(treatment_id).treatment_episodes.each {|x| list << [x.id, x.certification_period]}
    list
  end

  def self.visit_types_list(treatment_id, episode_id)
    return [[]] if episode_id.nil? or episode_id == 0
    treatment = PatientTreatment.find(treatment_id)
    episode = treatment.treatment_episodes.find(episode_id)
    treatment_staffs = treatment.treatment_staffs.staffed.where({:staff_type => "User", :staff_id => User.current.id})
    org = treatment.patient.org
    list = [[nil, "---"]]
    treatment_staffs.each do |ts|
			if ts.visit_type.present? and ts.discipline.present?
				list << ["#{ts.discipline.id}__#{ts.visit_type_id}",
                 "#{ts.discipline.discipline_description} - #{ts.visit_type.visit_type_description}"] if visit_type_allowed?(treatment, episode, ts.visit_type, ts.discipline)
      elsif ts.discipline.present?
        ts.discipline.visit_types.where(["org_id = ?", org.id ]).each{|vt|
          unless treatment_staffs.any?{|x| x.discipline == ts.discipline and x.visit_type == vt}
            list << ["#{ts.discipline.id}__#{vt.id}",
                     "#{ts.discipline.discipline_description} - #{vt.visit_type_description}"] if visit_type_allowed?(treatment, episode, vt, ts.discipline)
          end
        }
			else
        list << ["__#{ts.visit_type.id}", "#{ts.visit_type.visit_type_description}"] if visit_type_allowed?(treatment, episode, ts.visit_type)
			end
    end
    list.uniq
  end

  def self.visit_type_allowed?(treatment, episode, visit_type, discipline = nil)
    context =  discipline.present? ? episode.treatment_disciplines.find_by_discipline_id(discipline.id) : treatment
    visit_type.allowed_for?(context) and visit_type.license_types.include?(User.current.license_type)
  end

  def patient_name
		treatment_visit.treatment.patient.full_name
  end

  def signature_image_url
   self.signature.path(:thumb)
  end

  def episode
    self.treatment_visit.treatment_episode.certification_period
  end

  def visited_date
    treatment_visit.visit_start_time.strftime("%m-%d-%Y")
  end

  def start_time
    self.treatment_visit.visit_start_time.strftime("%I:%M %p")
  end

  def end_time
    self.treatment_visit.visit_end_time.strftime("%I:%M %p")
  end

  def field_staff_name
    self.treatment_visit.visited_user.to_s
  end

  def field_staff_signature_path
    (self.treatment_visit.visited_user.signature?) ? self.treatment_visit.visited_user.signature.path(:thumb) : nil
  end

  def visit_type_display
    visit_type = treatment_visit.visit_type
    discipline = treatment_visit.discipline
    if discipline.present? and visit_type.present?
      discipline.discipline_description + " - " + visit_type.visit_type_description
    elsif discipline.present?
      discipline.discipline_description
    else
      visit_type.visit_type_description
    end
  end

  def patient_address
    patient = treatment_visit.treatment.patient
    address = []
    address << patient.suite_number unless patient.suite_number.blank?
    address << patient.street_address unless patient.street_address.blank?
    address << patient.city unless patient.city.blank?
    address << patient.state unless patient.state.blank?
    address << patient.zip_code unless patient.zip_code.blank?
    address.join(", ")
  end

  def to_xml(options = {})
    super :methods => [:signature_image_url, :patient_location_path, :patient_name, :episode, :start_time, :end_time,
    :field_staff_name, :field_staff_signature_path, :visited_date,
    :visit_type_display, :patient_address]
  end

  def check_visit_timing
    res = "Selected visit timing is invalid, either change the end time or the end date"
    if start_time_hour && start_time_min && end_time_hour && end_time_min && visit_date && visit_end_date
      start_time = (start_time_hour+start_time_min).to_i
      end_time = (end_time_hour+end_time_min).to_i
      errors.add(:base, "Visit timing cannot be same") if (visit_date == visit_end_date && start_time == end_time)
      errors.add(:base, res) if ((visit_date == visit_end_date) && (start_time > end_time))
      errors.add(:base, "Visit dates are invalid") if visit_date > visit_end_date
    end
  end

  private

  def create_visit
    discipline_id, vt_id = visit_type_id.split("__")
    visit = TreatmentVisit.new({:treatment_episode_id => treatment_episode, :discipline_id => discipline_id,
                                :visit_type_id => vt_id, :treatment_id => treatment_id, :visited_user => User.current, :visited_staff => User.current})
    visit.from_electronic_routesheet = true
    self.visit_date = self.visit_date.to_date
    self.visit_end_date = self.visit_end_date.to_date
    visit.visit_date = self.visit_date
    visit.visit_end_date = self.visit_end_date
    visit.start_time_hour = self.start_time_hour
    visit.start_time_min = self.start_time_min
    visit.end_time_hour = self.end_time_hour
    visit.end_time_min = self.end_time_min
    visit.systolic_bp = systolic_bp
    visit.diastolic_bp = diastolic_bp
    visit.supervised_user_id = supervised_user_id
    visit.bp_read_position = bp_read_position
    visit.heart_rate = heart_rate
    visit.respiration_rate = respiration_rate
    visit.temperature_in_fht = temperature_in_fht
    visit.blood_sugar = blood_sugar
    visit.sugar_read_period = sugar_read_period
    visit.weight_in_lbs = weight_in_lbs
    visit.oxygen_saturation = oxygen_saturation
    visit.bp_read_location = bp_read_location
    visit.pain = pain

    unless visit.valid?
      visit.errors.each{|field, msg|
        errors.add(field, msg)
      }
    end

    visit.save!
    self.treatment_visit = visit
  end

  def set_defaults
    self.visit_date = Date.current
    self.visit_end_date = Date.current
    self.generated_status = 'N'
  end

  def save_signatures
    if patient_signature_data
      file = Tempfile.new(["signature", ".png"])
      file.binmode
      require 'base64'
      file.write(Base64.decode64(patient_signature_data))
      file.close
      file = File.open(file.path)
      self.signature = file
    end
  end

  def save_attachments
    spawn_block do
      file_content =  Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/electronic_route_sheet/electronic_route_sheet.jasper", self, {}, {})
      file = Tempfile.new(["route_sheet", ".pdf"])
      file.binmode
      file.write(file_content)
      file.close
      file = File.open(file.path)
      attachment = treatment_visit.attachments.build(:attachment => file, :attachment_type => AttachmentType.route_sheet(treatment_visit.treatment.patient.org.id), :attachment_date => self.visit_date)
      result = attachment.save!
      self.generated_status = 'C'
      self.save!
    end
  end

  def map_for_location(latitude, longitude)
    url = "http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=14&size=400x300&sensor=false&markers=color:blue|label:P|#{latitude},#{longitude}"
    require 'net/http'
    img = Net::HTTP.get(URI.parse(URI.encode(url)))
  end
end
