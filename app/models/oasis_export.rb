# == Schema Information
#
# Table name: oasis_exports
#
#  id                 :integer          not null, primary key
#  document_id        :integer          not null
#  export_status      :string(1)        default("R"), not null
#  exported_date_time :datetime
#  exported_user_id   :integer
#  export_reference   :string(20)
#
require 'zip'
class OasisExport < ActiveRecord::Base

  belongs_to :oasis_document, :class_name => "Document", :foreign_key => :document_id
  belongs_to :exported_user, :class_name => "User"
  has_many :export_batch_files, :through => :oasis_export_batches
  has_many :oasis_export_batches
  belongs_to :insurance_company
  scope :org_scope, lambda { includes(:oasis_document => {:treatment => {:patient => :patient_detail}}).where({:patient_details => {:org_id => Org.current.id}})}
  scope :medicare_scope, lambda{org_scope.where(["insurance_company_id in (?)", InsuranceCompany.org_scope.where({billing_flow: "H", company_code: "MEDICARE"}).map(&:id)])}
  scope :private_scope, lambda{org_scope.where(["insurance_company_id in (?)", InsuranceCompany.org_scope.where("company_code != 'MEDICARE'").map(&:id)])}
  after_initialize :set_defaults, :if => :new_record?

  audited :associated_with => :oasis_document, :allow_mass_assignment => true
  REJECTED = 'J'
  DRAFT = 'D'
  READY_FOR_EXPORT = 'R'
  EXPORTED = 'P'
  STATE_MAP = {:draft => DRAFT, :ready_for_export => READY_FOR_EXPORT, :exported => EXPORTED, :rejected => REJECTED}
  STATUS_STORE = STATE_MAP.collect{|k,v| [v.to_s, k.to_s == 'ready_for_export' ? 'Ready' : k.to_s.titleize]}.last(4).unshift(["", "---"])
  NEW = "New"
  CORRECTION = "Correction"
  CORRECTION_CHAR = 'C'
  INACTIVE = "Inactive"
  INACTIVE_CHAR = 'I'
  ORIGINAL = "Original"
  ORIGINAL_CHAR = 'O'
  RECORD_TYPE_MAP = {ORIGINAL_CHAR => ORIGINAL, CORRECTION_CHAR => CORRECTION, INACTIVE_CHAR => INACTIVE}

  include AASM

  netzke_attribute :correction_num_display

  aasm :column => :export_status do
    state :draft, :initial => true
    state :ready_for_export
    state :exported
    state :rejected
    event :mark_as_ready_for_export do
      transitions to: :ready_for_export, from: :draft, guard: :system_driven_event?
    end

    event :export_for_test do
      transitions to: :ready_for_export, from: :ready_for_export
      transitions to: :exported, from: :exported
    end

    event :export_for_production, :before => :update_exported_date, :after => :update_document_as_exported do
      transitions to: :exported, from: [:ready_for_export, :exported]
    end

    event :reject do
      transitions to: :rejected, from: :exported
    end

  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :export_status
    write_attribute_without_mapping(attr, v)
  end

  def export_status
    STATE_MAP.invert[read_attribute(:export_status)]
  end

  def record_type
    RECORD_TYPE_MAP[read_attribute(:record_type)]
  end

  attr_accessor :system_driven_event
  def system_driven_event?
    system_driven_event == true
  end

  def is_oasis_document_rejected?
    oasis_document.unlock_reason == 'J'
  end

  def update_exported_date
    self.update_attribute(:exported_date_time, Time.current)
  end

  def update_document_as_exported
    oasis_document.document_exported
  end

  def correction_num_display
    correction_num.nil? ? "" : correction_num
  end

  # FIXME: This code is to be deleted
  # Old Export code for submission format version 2.00
  def self.export_oasis_document_format_200(health_agency, document_ids, test_mode = false)
    Thread.current[:total_records] = document_ids.size + 2
    records = self.where(:id => document_ids)
    header = generate_header(health_agency, test_mode)
    body = records.inject(""){|result, record|
      oasis_doc = record.oasis_document
      type = oasis_doc.m0100_assmt_reason ? oasis_doc.m0100_assmt_reason.to_i : 1
      result += generate_body(health_agency, record, test_mode, type)
      result
    }
    ref = Time.current.strftime('%Y%m%dT%H%M')
    ref = "test_#{ref}" if test_mode
    trailer = generate_trailer(health_agency, test_mode)
    output = header + body + trailer
    file_name = export_file_path(ref, health_agency)
    File.open(file_name, "w") {|f| f.puts output}
    ActiveRecord::Base.transaction do
      records.each{|r|
        r.export_reference = ref
        if test_mode
          r.export_for_test!
        else
          r.export_for_production!
        end
      }
    end
    export_batch_files(ref, document_ids)
    Rails.application.routes.url_helpers.oasis_export_path(ref)
  end
  
  def self.export_oasis_document(health_agency, document_ids, test_mode = false)
    oasis_exports = self.where(:id => document_ids)
    oasis_exports.sort_by!{|oe| oe.oasis_document.m0090_info_completed_dt }

    ref = Time.current.strftime('%Y%m%dT%H%M') + "#{rand(1000000)}"
    ref = "test_#{ref}" if test_mode
    zip_file_name = export_file_path(ref, health_agency) + ".zip"

    Zip::File.open(zip_file_name,Zip::File::CREATE) do |zipfile|

      oasis_exports.each_with_index do |oasis_export, index|
        file_name = export_file_path(index + 1, health_agency) + "_#{rand(1000000)}.xml"
        exporter = ::OasisExporterFor210And211.new(oasis_export.oasis_document, oasis_export.record_type, oasis_export.correction_num)
        output = exporter.generate_xml
        File.open(file_name, "w") {|f| f.puts output }
        input_file = File.basename(file_name)
        zipfile.add(input_file, file_name)
      end

    end

    ActiveRecord::Base.transaction do
      oasis_exports.each{|r|
        r.export_reference = ref
        if test_mode
          r.export_for_test!
        else
          r.export_for_production!
        end
      }
    end
    export_batch_files(zip_file_name, document_ids)
    Rails.application.routes.url_helpers.oasis_export_path("oasis_#{health_agency.id}_#{ref}")
  end  

  def self.export_file_path(reference, health_agency = Org.current)
    "#{Rails.root}/tmp/oasis_#{health_agency.id}_#{reference}"
  end

  def self.export_batch_files(ref, document_ids)
    export_batch_file = ExportBatchFile.new
    export_batch_file.oasis_export = File.open(ref)
    export_batch_file.oasis_export_ids = document_ids
    export_batch_file.save!
  end

  def self.generate_header(health_agency, test_mode)
    fields = OasisFieldSpec.header
    fields.collect{|f|
      process_field(f, health_agency, health_agency, test_mode)
    }.join
  end

  def self.generate_trailer(health_agency, test_mode)
    fields = OasisFieldSpec.trailer
    fields.collect{|f|
      process_field(f, health_agency, health_agency, test_mode)
    }.join
  end

  def self.generate_body(health_agency, record, test_mode, type = 1)
    fields = OasisFieldSpec.body
    fields.collect{|f|
        process_field(f, health_agency, record, test_mode, f.send("rfa_#{type}".to_sym))
    }.join
  end

  def self.get_special_field_value(field_name, test_mode, health_agency)
    value = case field_name
            when "test_sw"
              (test_mode == true) ? "0" : "1"
            when "sfw_id"
              "461595188" #Fasternotes software id.
            when "fed_id"
                fed_id = health_agency.cms_certification_number
                fed_id.present? ? fed_id : ""
            when "tot_rec"
              Thread.current[:total_records].to_s.rjust(6, "0")
            end
    value
  end

  def self.special_fields?(field_name)
    %w(fed_id test_sw sfw_id tot_rec).include? field_name
  end

  def self.process_field(field, health_agency, record, test_mode = false, applicable = true)
    export_record = nil
    unless record.is_a? HealthAgency
      if record.is_a? Document
        record = record
        export_record = nil
      else
        export_record = record
        record = record.oasis_document
      end
    end

    field_name = field.field_name.downcase
    value = ""
    if export_record and export_record.record_type == INACTIVE
      original_field = "#{field_name}_original"
      value = record.respond_to?(original_field) ? "#{record.send(original_field)}" : " "
      value = "X1" if field_name == "rec_id"
      if ["data_end", "crg_rtn", "ln_fd"].include?(field_name)
        value = field.default_value
      elsif field_name == "hha_agency_id"
        value = health_agency.hha_agency_id
      elsif date_field?(field_name, value)
        value = date_format(value)
      end
    else
      if field_name == "correction_num"
        value = record.correction_num.to_s
        value = "00" if value.blank?
        value = value.rjust(2, '0')
      elsif special_fields?(field_name)
        value = get_special_field_value(field_name, test_mode, health_agency)
      elsif record.respond_to?(field_name.to_sym) and applicable
        value = if record.send(field_name.to_sym)
                  record.send(field_name.to_sym)
                elsif field.applicable_condition_expression.nil? == false
                  record.do_as_eval(field.applicable_condition_expression) ? field.default_value : ""
                else
                  field.default_value || ""
                end

        if date_field?(field_name, value)
          value = date_format(value)
        elsif icd_field?(field_name) and value.blank? == false
          value = format_icd_code(field_name, value)
        else
          value = "#{value}".upcase
        end
        value = value.to_s.strip unless icd_field?(field_name)
        if field.data_type == 'N' and value.blank? == false
          value = value.rjust(field.length, "0")
        end
      else
        puts "Warning! Field #{field.field_name} is not mapped" if applicable
        value = ""
        value = (field.default_value || "") if applicable
      end
      value = "" if (soc_roc_1308_field?(field_name) and reset_required?(field_name, record))
    end
    value = " " if value.nil?
    value = value[0..(field.length - 1)].ljust(field.length)
    value.upcase
  end

  def self.date_field?(field_name, value)
    ((field_name.start_with?("m0903") or field_name.ends_with?("_dt") or field_name.ends_with?("_date")) and value.blank? == false)
  end

  def self.date_format(value)
    value = value.is_a?(Date) ? value : Date.strptime(value, "%m/%d/%Y")
    value.strftime("%Y%m%d")
  end

  def self.soc_roc_1308_field?(field_name)
    (field_name.start_with?("m1308") and field_name.ends_with?("soc_roc"))
  end

  def self.reset_required?(field_name, record)
    rfa = record.send("m0100_assmt_reason")
    field_value = record.send(field_name)
    field_1306_value = record.send("m1306_unhld_stg2_prsr_ulcr")
    (["04", "05", "09"].include?(rfa) and field_1306_value == '0')
  end

  def self.icd_field?(field_name)
    (field_name =~ /_icd\d?$/ or field_name =~ /_icd_[a-f]{1}\d$/ )and field_name.ends_with?("_na_icd") == false and
        field_name.ends_with?("_uk_icd") == false
  end

  def self.format_icd_code(field_name, value)
    ProspectivePaymentSystem::PPSGrouper.formatted_icd_code({field_name: field_name, value: value})
  end

  def oasis_document_date_display
    oasis_document.document_date.strftime("%m/%d/%Y")
  end

  def exported_date_display
    exported_date_time.strftime("%m/%d/%Y") if exported_date_time.present?
  end

  def insurance_company
    InsuranceCompany.where(id: insurance_company_id).first.to_s
  end

  private

  def set_defaults
    self.exported_user = User.current
  end

end
