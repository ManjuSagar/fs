# == Schema Information
#
# Table name: communication_notes
#
#  id                             :integer          not null, primary key
#  treatment_id                   :integer          not null
#  treatment_episode_id           :integer          not null
#  physician_id                   :integer          not null
#  note_date_time                 :datetime         not null
#  note_content                   :text
#  note_status                    :string(1)        not null
#  created_user_id                :integer          not null
#  lock_version                   :integer          default(0)
#  printable_content_file_name    :string(255)
#  printable_content_content_type :string(255)
#  printable_content_file_size    :integer
#  printable_content_updated_at   :datetime
#  medical_order_id               :integer
#  field_staff_id                 :integer
#  note_type_id                   :integer          not null
#  created_user_sign_date         :date
#

require 'jasper-rails'
class CommunicationNote < ActiveRecord::Base
  include JasperRails
  include SignDocument
  has_attached_file :printable_content
  belongs_to :treatment, :class_name => "PatientTreatment"
  belongs_to :treatment_episode
  belongs_to :physician
  belongs_to :medical_order
  belongs_to :field_staff
  belongs_to :created_user, :class_name => "User"
  belongs_to :note_type, :class_name => "OrderType"
  has_many :all_documents, :as => :documentable, :dependent => :destroy
  
  validates :treatment_episode, :presence => true
  validates :physician, :presence => true
  validates :treatment, :presence => true
  validates :note_type, :presence => true
  validates :note_date_time, :presence => true
  validates :note_status, :presence => true

  validate :communication_note_period
  
  scope :org_scope, lambda { |org = Org.current| includes(:treatment => {:patient => :patient_detail}).where({:patient_details => {:org_id => org.id}}) if org}
  default_scope lambda {order('note_date_time DESC') if self.column_names.include?(:note_date_time)}

  audited :associated_with => :treatment_episode, :allow_mass_assignment => true

  after_initialize :set_defaults, :if => :new_record?
  before_create :create_all_document
  after_save :update_all_documents_if_required, :unless => :new_record?
  after_save :sign_the_communication_note_if_required

  STATE_MAP = {:draft => 'D', :completed => 'C'}
                
  include AASM
  
  aasm :column => :note_status do
    state :draft, :initial => true 
    state :completed
    
    event :sign, :before => :set_comment_for_fs_signed do
      transitions :from => :draft, :to => :completed, :guard => :current_user_is_created_user?
    end

    event :undo, :before => :reset_sign_date do
      transitions :from => :completed, :to => :draft, :guard => :can_undo?
    end

    event :delete, :hidden => true do
      transitions :from => :draft, :to => :draft, :guard => :can_delete?
    end
  end

  def can_delete?
    current_user_is_created_user? or current_user_is_office_staff?
  end

  def can_undo?
    current_user_is_created_user? or current_user_is_office_staff?
  end

  def current_user_is_office_staff?
    User.current.office_staff?
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :note_status
    write_attribute_without_mapping(attr, v)
  end   
  
  def note_status
    STATE_MAP.invert[read_attribute(:note_status)]
  end

  attr_accessor :note_date
  netzke_attribute :note_date

  attr_accessible :treatment_episode_id

  def note_date
    self.note_date_time.to_date.strftime("%m/%d/%Y")
  end
  
  def current_user_is_created_user?
    self.created_user == User.current
  end
  
  def patient_name
    treatment.patient.full_name
  end

  def patient_mr_number
    treatment.patient.patient_reference
  end
  
  def physician_name
    physician.full_name
  end
  
  def field_staff_name
   field_staff.present? ? field_staff.full_name : nil
  end
  
  def created_user_name
    created_user.full_name
  end
  
  def episode_display
    treatment_episode.certification_period
  end
  
  def created_user_signature_path
    created_user.signature? ? created_user.signature.path : nil
  end
  
  def note_date_display
    self.note_date_time.strftime("%m/%d/%Y")
  end
  
  def note_type_display
    note_type.type_description
  end

  def insurance
    treatment.insurance_company
  end

  def org
    treatment.agency
  end

  def agency_name
    if ins_flag
      insurance.to_s
    else
      treatment.health_agency_name
    end
  end

  def agency_address
    agency_address1 + " " + agency_address2
  end

  def agency_address1
    street = []
    if ins_flag
      street << insurance.claim_street_address unless insurance.claim_street_address.blank?
      street << "Suite " + insurance.claim_suite_number unless insurance.claim_suite_number.blank?
    else
      street << org.street_address unless org.street_address.blank?
      street << "Suite " + org.suite_number unless org.suite_number.blank?
    end
    street.join(", ")
  end

  def agency_address2
    street = []
    if ins_flag
      street << insurance.claim_city unless insurance.claim_city.blank?
      street << ["#{insurance.claim_state} #{insurance.claim_zip_code}"].reject{|x| x.blank?}
    else
      street << org.city unless org.city.blank?
      street << ["#{org.state} #{org.zip_code}"].reject{|x| x.blank?}
    end
    street.join(", ")
  end

  def agency_phone_number
    phone = []
    if ins_flag
    phone << "Phone: " + insurance.claim_phone_number unless insurance.claim_phone_number.blank?
    else
    phone << "Phone: " + org.phone_number unless org.phone_number.blank?
    phone << "Fax: " + org.fax_number unless ins_flag
    end
    phone.join("   ")
  end
  
  def ins_flag
    treatment.print_insurance_company_contact?
  end

  def os_sign_date_display
    created_user_sign_date.strftime("%m/%d/%Y") if created_user_sign_date
  end

  def reset_sign_date
    self.created_user_sign_date = nil
  end

  def can_sign_comm_note?
    (created_user == User.current and self.draft?)
  end

  def to_xml(options = {})
      super :methods => [:patient_name,
                         :physician_name,
                         :episode_display,
                         :created_user_name,
                         :created_user_signature_path,
                         :field_staff_name,
                         :note_date_display,
                         :note_type_display,
                         :agency_name,
                         :agency_address,
                         :agency_phone_number,
                         :patient_mr_number,
                         :os_sign_date_display,
                         :ins_flag
      ]
  end
  
  def to_pdf
    file_content = Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/comm_note/comm_note.jasper", self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end
  
  def create_medical_order 
    order = treatment.medical_orders.build
    order.treatment_episode = treatment_episode
    order.physician = physician
    order.field_staff = field_staff
    order.created_user = User.current
    order.order_content = order_content
    order.order_type = self.note_type
    order.order_date = Date.current
    order.save!
    self.medical_order = order
    self.save!
  end
  
  def order_content
    content = []
    content << self.note_content
    content.join("\n")
  end

  def communication_note_period
    errors.add(:note_date_time, "should be with in the Episode.") if self.note_date_time.present? and note_date_with_in_episode? == false
  end

  def note_date_with_in_episode?
    self.note_date_time >= self.treatment_episode.start_date and self.note_date_time <= self.treatment_episode.end_date
  end

  def set_sign_date(date)
    self.created_user_sign_date = date
    self.save
  end

  def sign_the_communication_note_if_required
    if(sign_password and signature_date)
      self.created_user_sign_date = signature_date
      self.sign! if may_sign?
    end
  end

  def deletable?
    res = false
    res = self.may_delete?
    res == true
  end

  private
  
  def set_defaults
    self.note_date_time = Time.current
    self.created_user_id = User.current.id
    self.field_staff = User.current if User.current.is_a? FieldStaff
    self.physician = self.treatment.primary_physician if treatment.present?
  end

  def create_all_document
    staff = field_staff.full_name if field_staff
    description = note_type.type_description
    status = note_status.to_s.titleize
    document = self.all_documents.build(treatment_episode: treatment_episode, category: "Communication", staff: staff, description: description,
                             status: status)
    document.document_date = note_date_time.to_date
  end

  def update_all_documents_if_required
    staff = field_staff.full_name if field_staff
    description = note_type.type_description
    status = note_status.to_s.titleize
    self.all_documents.each{|d|
      d.update_attributes(staff: staff, description: description, status: status) if (staff != d.staff or description != d.description or status != d.status)
      d.update_column(:document_date, note_date_time.to_date)
    }
  end

end
