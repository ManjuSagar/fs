# == Schema Information
#
# Table name: medical_orders
#
#  id                           :integer          not null, primary key
#  order_date                   :date             not null
#  order_content                :text
#  treatment_id                 :integer          not null
#  order_type_id                :integer          not null
#  treatment_episode_id         :integer          not null
#  physician_id                 :integer          not null
#  created_user_id              :integer          not null
#  signed_user_id               :integer
#  order_status                 :string(2)        not null
#  lock_version                 :integer          default(0)
#  printable_order_file_name    :string(255)
#  printable_order_content_type :string(255)
#  printable_order_file_size    :integer
#  printable_order_updated_at   :datetime
#  signed_order_file_name       :string(255)
#  signed_order_content_type    :string(255)
#  signed_order_file_size       :integer
#  signed_order_updated_at      :datetime
#  order_reference              :string(20)
#  attachment_type_id           :integer
#  field_staff_id               :integer
#  os_sign_date                 :date
#

  require 'jasper-rails'
  class MedicalOrder < ActiveRecord::Base
    include JasperRails
    include SignDocument
    include ReportHeaderInfo
    has_attached_file :printable_order
    has_attached_file :signed_order
    belongs_to :treatment, :class_name => "PatientTreatment"
    belongs_to :treatment_visit
    belongs_to :order_type
    belongs_to :treatment_episode
    belongs_to :physician
    belongs_to :field_staff
    belongs_to :created_user, :class_name => "User"
    belongs_to :signed_user, :class_name => "User"
    belongs_to :attachment_type
    has_many :all_documents, :as => :documentable, :dependent => :delete_all
    has_many :attached_docs, :class_name => "MedicalOrderDocumentAttachment", :dependent => :destroy
    scope :org_scope, lambda { |org = Org.current| includes(:treatment => {:patient => :patient_detail}).where({:patient_details => {:org_id => org.id}}) if org}
    after_initialize :set_defaults, :if => :new_record?
    before_validation :set_created_user_id, on: :create
    before_create :generate_reference
    before_create :create_all_document
    after_save :update_all_documents_if_required, :unless => :new_record?
    after_save :update_denormalized_patient_list
    after_create :sign_the_medical_order_if_required

    scope :not_draft, lambda{|list_of_orders| org_scope.where("medical_orders.id in (?) and medical_orders.order_status not in (?)", list_of_orders, ['D'])}

    validates :order_type, :presence => true
    validates :physician, :presence => true
    validates :order_date, :presence => true
    validates :treatment_episode, :presence => true

    attr_accessor :package_count, :batch_orders_send

    audited :associated_with => :treatment

    ORDER_REFERENCE_PATTERN = "FN-yyyymmdd-nnnnn"

    default_scope lambda { order("medical_orders.id DESC")}

    scope :not_complete, lambda{org_scope.where(["order_status NOT IN (?)", ['C', 'O']])}

    STATE_MAP = {:draft => 'D', :ready_to_send => 'R', :pending_physician_signature => 'P',
                 :order_received => 'O', :completed => 'C'}
    STATUS_DISPLAY = {'D' => 'Draft', 'R' => 'Ready', 'P' => 'Sent',
                      'O' => 'Order Received', 'C' => 'Completed'}
    ORDER_TRACKING_STATUS_STORE = [["", "---"], ['D', "Draft"], ['R', "Ready"], ['P', "Sent"]]

    STATUS_STORE = ORDER_TRACKING_STATUS_STORE + [['O', "Order Received"], ['C', "Completed"]]

    include AASM

    aasm :column => :order_status do
      state :draft, :initial => true
      state :ready_to_send
      state :pending_physician_signature
      state :order_received
      state :completed, :after_enter => :send_email_to_cc_physicians_if_required

      event :sign, :before => :set_signed_user, :after => [:attach_printable_order , :set_comment_for_fs_signed] do
        transitions :to => :ready_to_send, :from => :draft, :guard => :current_user_can_sign?
      end

      event :send_to_physician, :after => :send_email_to_primary_physician do
        transitions :to => :pending_physician_signature, :from => :ready_to_send, :guard => :current_user_is_office_staff?
      end

      event :mark_as_not_signed, :after => :remove_printable_order_if_required do
        transitions :to => :draft, :from => :ready_to_send, :guard => :current_user_is_office_staff?
      end

      event :unsend do
        transitions :to => :ready_to_send, :from => :pending_physician_signature, :guard => :current_user_is_office_staff?
      end

      event :mark_as_order_not_received, :after => :remove_order_received_from_physician do
        transitions :to => :pending_physician_signature, :from => [:order_received, :completed], :guard => :current_user_is_office_staff?
      end

      event :mark_order_received do
        transitions :to => :order_received, :from => :pending_physician_signature, :guard => :at_least_one_cc_recipient_and_current_user_is_office_staff?
        transitions :to => :completed, :from => :pending_physician_signature, :guard => :no_cc_recipient_and_current_user_is_office_staff?
      end

      event :send_cc do
        transitions :to => :completed, :from => :order_received, :guard => :current_user_is_office_staff?
      end

    end

    alias_method :write_attribute_without_mapping, :write_attribute
    def write_attribute(attr, v)
      v = STATE_MAP[v.to_sym] if attr.to_sym == :order_status
      write_attribute_without_mapping(attr, v)
    end

    def order_status
      STATE_MAP.invert[read_attribute(:order_status)]
    end

    def current_user_is_office_staff?
      User.current.office_staff?
    end

    def current_user_can_sign?
      field_staff.present? ? User.current == field_staff : true
    end

    def remove_printable_order_if_required
      self.printable_order = nil
      self.save
    end

    def remove_order_received_from_physician
       self.signed_order = nil
       self.save
    end

    def set_signed_user
      self.signed_user = User.current
      self.save
    end

    def sign_the_medical_order_if_required
      if(sign_password and signature_date)
        self.os_sign_date = signature_date
        self.sign! if may_sign?
      end
    end

    attr_accessor :aging, :signed_order_uploading
    netzke_attribute :aging
    netzke_attribute :signed_order_uploading, type: :boolean
    attr_accessor :aged
    netzke_attribute :aged

    attr_accessible :treatment_episode_id

    AGING_LIMIT = 30

    def aged
      aging.to_i > AGING_LIMIT
    end

    def aging
      return nil if self.completed?
      (Date.current - order_date).to_s.split("/").first
    end

    def to_pdf(name = "medical_order")
      file_name = if (name=="medical_order" && order_type.type_code == 'FACE_TO_FACE')
                    'face_to_face.jasper'
                  else
                    "#{name}.jasper"
                  end
      file_content =  Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/medical_order/#{file_name}", self, {}, {})
      file = File.open(tempfile, "w")
      file.binmode
      file.write(file_content)
      file.close
      File.absolute_path(file)
    end

    def combine_order_and_attached_docs
      order_pdf = (mo_editable == true) ? [self.to_pdf] : []
      pdfs = order_pdf + attached_docs.collect{|d| d.to_pdf}
      combined_pdf_file = "#{tempfile}.pdf"
      require 'pdf_merger'
      PdfMerger.new.merge(pdfs, combined_pdf_file)
      combined_pdf_file
    end

    def attach_printable_order
      combined_order_pdf = combine_order_and_attached_docs
      self.printable_order = File.open(combined_order_pdf)
      self.save!
    end

    def staff_sign_date
      printable_order_updated_at.strftime("%m/%d/%Y") if printable_order_updated_at.present?
    end

    def at_least_one_cc_recipient_and_current_user_is_office_staff?
      at_least_one_cc_recipient? and current_user_is_office_staff?
    end

    def at_least_one_cc_recipient?
      treatment.treatment_physicians.select{|x| x.physician != physician}.any?{|p| p.is_cc?}
    end

    def no_cc_recipient_and_current_user_is_office_staff?
      no_cc_recipient? and current_user_is_office_staff?
    end

    def no_cc_recipient?
      not at_least_one_cc_recipient?
    end

    def send_email_to_cc_physicians_if_required
      os = User.current.full_name
      spawn_block do
        treatment.treatment_physicians.select{|x| x.physician != physician and x.is_cc? and x.physician.default_email? == false}.
            each{|x| x.send_medical_order_report(os, self)}
      end
    end

    def send_email_to_primary_physician
      return true if batch_orders_send
      return true if physician.default_email?
      os = User.current.full_name
      spawn_block do
        physician.send_medical_order(os, self)
      end
    end

    def patient_name
      treatment.patient.full_name
    end

    def mr
      treatment.patient.patient_reference
    end

    def patient_mr_number
      mr
    end

    def physician_full_address
      physician_address_line1 + ', ' + physician_address_line2
    end

    def physician_name
      physician.full_name
    end

    def physician_last_name
      physician.physcn_last_name
    end

    def episode_display
      treatment_episode.certification_period
    end

    def created_user_name
      signed_user.full_name
    end

    def order_type_display
      order_type.type_description.titleize
    end

    def created_user_signature_path
      signed_user.signature? ? signed_user.signature.path : nil
    end

    def field_staff_name
      field_staff.full_name if field_staff.present?
    end

    def order_date_display
      order_date.strftime("%m/%d/%Y")
    end

    def private_ins_print_flag
      treatment.print_insurance_company_contact?
    end

    def ins
      treatment.insurance_company
    end

    def org
      treatment.agency
    end

    def agency_name
      treatment.patient.org.to_s
    end

    def ins_agency_name
      private_ins_print_flag ? ins.to_s : agency_name
    end

    def agency_address
      agency_address_line1 + ", " + agency_address_line2
    end

    def agency_address_line1
      street = []
      street << org.street_address unless org.street_address.blank?
      street << "Suite " + org.suite_number unless org.suite_number.blank?
      street.join(", ")
    end

    def agency_address_line2
      street = []
      street << org.city unless org.city.blank?
      street << ["#{org.state} #{org.zip_code}"].reject{|x| x.blank?}
      street.join(", ")
    end

    def agency_phone_number
      (private_ins_print_flag)? "Phone: #{ins.claim_phone_number}" : "Phone: #{org.phone_number}"
    end

    def agency_fax_number
      (private_ins_print_flag)? '' : "Fax: #{org.fax_number}"
    end

    def ins_agency_address
      ins_agency_address_line1 + ", " + ins_agency_address_line2
    end

    def ins_agency_address_line1
      street = []
      if private_ins_print_flag
        street << ins.claim_street_address unless ins.claim_street_address.blank?
        street << "Suite " + ins.claim_suite_number unless ins.claim_suite_number.blank?
        street.join(", ")
      else
        agency_address_line1
      end
    end

    def ins_agency_address_line2
      street = []
      if private_ins_print_flag
        street << ins.claim_city unless ins.claim_city.blank?
        street << ["#{ins.claim_state} #{ins.claim_zip_code}"].reject { |x| x.blank? }
        street.join(", ")
      else
        agency_address_line2
      end
    end

    def agency_city_state_zip
      street = []
      street << org.city unless org.city.blank?
      street << org.state unless org.state.blank?
      street << org.zip_code unless org.zip_code.blank?
      street.join(", ")
    end

    def ins_agency_phone_fax_number
      phone = []
      if private_ins_print_flag
        phone << "Phone: " + ins.claim_phone_number unless ins.claim_phone_number.blank?
      else
        phone << "Phone: " + agency_phone_number unless agency_phone_number.blank?
        phone << "Fax: " + agency_fax_number
      end
      phone.join("   ")
    end

    def agency_email
      (private_ins_print_flag)?  ' ' : treatment.agency_email
    end

    def agency_contact_info
      if private_ins_print_flag
        "Phone: #{ins.claim_phone_number}" if (ins.claim_phone_number.present?)
      else
        phone = "#{agency_phone_number}" if (agency_phone_number.present?)
        fax =  "#{agency_fax_number}" if (agency_fax_number.present? )
        email = "Email: #{agency_email}" if (agency_email.present?)
        phone + ", " + fax + ", " + email
      end
    end

    def provider_name
      return private_ins_print_flag ? ins.full_name.to_s.upcase : super
    end

    def provider_contact
      if private_ins_print_flag
        "<b>Phone </b>" + ins.claim_phone_number unless ins.claim_phone_number.blank?
      else
        super
      end
    end

    def provider_full_address
      return private_ins_print_flag ? ins_agency_address : super
    end

    def physician_address_line1
      physician.address_line_1
    end

    def physician_address_line2
      physician.address_line_2
    end

    def physician_phone_number
      physician.phone_number_formatted if physician.present?
    end

    def physician_fax_number
      physician.fax_number_formatted if physician.present?
    end

    def os_sign_date_display
      os_sign_date.strftime("%m/%d/%Y")
    end

    def no_of_pages_including_cover
      package_count +  1 if package_count
    end

    def cover_sheet_print_date
      Date.current.strftime("%m/%d/%Y")
    end

    def batch_medical_order_activity_doer_name
      User.current.full_name
    end

    def batch_medical_order_activity_doer_signature_path
      User.current.signature.path
    end


    def combine_selected_orders(selected_orders_list)
      pdfs = get_pdfs(orders_group_by_md(selected_orders_list))
      combined_pdf_file = "#{tempfile}.pdf"
      require 'pdf_merger'
      PdfMerger.new.merge(pdfs, combined_pdf_file)
      combined_pdf_file
    end


    def get_pdfs(orders_group_by_md)
      total_pdfs = []
      orders_group_by_md.each do |list|
        md_orders = list.collect {|order| order.combine_order_and_attached_docs}
        order = list.first
        order.package_count = md_orders.collect{|p| PDF::Reader.new(p).page_count}.sum
        cover_sheet = order.to_pdf("cover_sheet")
        total_pdfs += [cover_sheet] + md_orders
      end
      total_pdfs
    end

    def to_xml(options = {})
      super :methods =>  [:created_user_name,
                          :order_type_display,
                          :created_user_signature_path,
                          :field_staff_name,
                          :order_date_display,
                          :os_sign_date_display,
                          :patient_mr_number,
                          :physician_phone_number,
                          :physician_fax_number,
                          :ins_agency_name,
                          :ins_agency_address_line1,
                          :ins_agency_address_line2,
                          :agency_phone_number,
                          :agency_fax_number,
                          :ins_agency_address,
                          :ins_agency_phone_fax_number,
                          :agency_email,
                          :agency_contact_info,
                          :patient_name,
                          :episode_display,
                          :physician_name,
                          :physician_address_line1,
                          :physician_address_line2,
                          :patient_details,
                          :patient_contact,
                          :patient_address,
                          :medicare_number,
                          :provider_name,
                          :provider_contact,
                          :provider_full_address,
                          :physician_full_address,
                          :physician_short_info,
                          :physician_last_name,
                          :physician_contact,
                          :no_of_pages_including_cover,
                          :cover_sheet_print_date,
                          :batch_medical_order_activity_doer_name,
                          :batch_medical_order_activity_doer_signature_path,
                          :physician_npi_number
                          ]
    end

    def set_sign_date(date)
      self.os_sign_date = date
      self.save
    end

    def get_selected_orders(selection_list)
      MedicalOrder.not_draft(selection_list)
    end

    def get_combined_pdf(pdfs, physician)
      combined_pdf_file = "#{physician}.pdf"
      require 'pdf_merger'
      PdfMerger.new.merge(pdfs, combined_pdf_file)
      combined_pdf_file
    end

    def get_pdf_of_physician_orders(list)
      md_orders = list.collect {|order| order.combine_order_and_attached_docs}
      order = list.first
      order.package_count = md_orders.collect{|p| PDF::Reader.new(p).page_count}.sum
      cover_sheet = order.to_pdf("cover_sheet")
      pdfs = [cover_sheet] + md_orders
      pdf_name = order.physician.full_name_without_suffix.split.join("_")
      get_combined_pdf(pdfs, pdf_name)
    end


    def send_batch_of_orders_to_physician(order, physician, pdf)
      return if physician.default_email?
      os = User.current.full_name
      spawn_block do
        physician.send_batch_of_medical_orders(os, order, pdf)
      end
    end

    def orders_group_by_md(orders)
      orders.group_by{|x| x.physician_id}.collect{|k, v| v}
    end

    def send_batch_orders_per_physician(orders_group_by_md)
      orders_group_by_md.each do |physician_orders|
        physician_pdf = get_pdf_of_physician_orders(physician_orders)
        order = physician_orders.first
        physician_orders.each do |order|
          order.batch_orders_send = true
          order.send_to_physician! if order.may_send_to_physician?
        end
        order.batch_orders_send = false
        physician = order.physician
        send_batch_of_orders_to_physician(order, physician, physician_pdf)
      end
    end

    def send_selected_orders_to_physician(selection_list)
      orders = MedicalOrder.org_scope.where("medical_orders.id in (?) and medical_orders.order_status in (?)",
                                            selection_list, ['R'])
      if orders.present?
        send_batch_orders_per_physician(orders_group_by_md(orders))
        true
      else
        false
      end
    end

    def download_batch_orders(orders_group_by_md)
      pdfs_list = []
      orders_group_by_md.each do |physician_orders|
        physician_pdf = get_pdf_of_physician_orders(physician_orders)
        order = physician_orders.first
        physician_orders.each do |order|
          order.batch_orders_send = true
          order.send_to_physician! if order.may_send_to_physician?
        end
        order.batch_orders_send = false
        physician = order.physician
        pdfs_list << physician_pdf
      end
      pdfs_list
    end

    def generate_zip_file(selected_orders)
      ref = Time.current.strftime('%Y%m%dT%H%M')
      folder = "#{Rails.root}/tmp/orders_#{ref}"
      `mkdir #{folder}`

      orders = MedicalOrder.org_scope.where(["medical_orders.id in (?) and medical_orders.order_status in (?)", selected_orders, ['R']])
      if orders.present?
        pdfs = download_batch_orders(orders_group_by_md(orders))
        pdfs.each do |pdf|
          `mv #{pdf} #{folder}`
        end

        zip_file = "#{Rails.root}/tmp/orders_#{ref}.zip"
        `zip -jr #{zip_file} #{folder}`
        `rm -rf #{folder}`
        "orders_#{ref}"
      else
        false
      end
    end

    def update_denormalized_patient_list
      patient = treatment_episode.treatment.patient
      d = DenormalizedPatientList.where(:patient_id => patient.id, :org_id => Org.current.id)
      DenormalizedPatientList.update_with(patient) if d.present?
    end

    private

    def generate_reference
      self.order_reference = MedicalOrderReferenceNumber.next_sequence(self)
    end

    def set_created_user_id
      self.created_user = User.current
    end

    def set_defaults
      if self.treatment.present?
        self.physician = self.treatment.primary_physician
      end
    end

    def create_all_document
      staff = field_staff.full_name if field_staff
      description = order_type.type_description
      status = order_status.to_s.titleize
      document= self.all_documents.build(treatment_episode: treatment_episode, category: "Order", staff: staff, description: description,
                               status: status)
      document.document_date = order_date
    end

    def update_all_documents_if_required
      staff = field_staff.full_name if field_staff
      description = order_type.type_description
      status = order_status.to_s.titleize
      self.all_documents.each{|d|
        d.update_attributes(staff: staff, description: description, status: status) if (staff != d.staff or description != d.description or status != d.status)
        d.update_column(:document_date, order_date)
      }
    end
  end
