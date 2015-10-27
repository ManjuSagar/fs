class OasisExporterFor210And211
  attr_accessor :oasis_doc, :is_oasis_c1, :export_doc_type, :correction_number, :spec_version

  RECORD_TYPE = {"Control" => 'L', "Filler" => 'F', "Assessment" => 'A', "Calculated" => 'C'}
  EXPORT_RECORD_TYPE = {"Original" => 1, "Inactive" => 3, "Correction" => 2}

  def initialize(oasis_doc, export_doc_type = nil, correction_number = nil)
    @oasis_doc = oasis_doc
    @export_doc_type = export_doc_type
    @correction_number = correction_number
    # FIXME: don't check anything based on class name. check by existance of specific field
    @is_oasis_c1 = oasis_doc.document_class_name.include?("C1")
  end

  def get_oasis_c1_spec_fields(record_type)
    rfa_number = inactive_request? ? 10 : oasis_doc.m0100_assmt_reason.to_i
    @spec_version = is_oasis_c1 ? get_spec_version : "02.10.1"
    OasisFieldSpec.where(["oasis_spec_version = ? and rfa_#{rfa_number} = ? and record_type = ?", spec_version, true, RECORD_TYPE[record_type]]).order("field_sequence")
  end

  def get_spec_version
    date = oasis_doc.m0090_info_completed_dt.gsub('/','')
    info_date = Date.parse(date[4..7]+date[0..1]+date[2..3])
    (info_date < Date.parse('01-10-2015')) ? '02.11.3' : '02.12.0'    
  end

  def inactive_request?
    (export_doc_type.present? and EXPORT_RECORD_TYPE[export_doc_type] == 3)
  end

  def generate_xml
    xml_tags = ['<?xml version="1.0" standalone="yes" ?>', "<ASSESSMENT>"]
    xml_tags += get_control_tags
    xml_tags += get_assessment_tags
    xml_tags += get_filler_tags
    xml_tags += get_calculated_tags
    xml_tags << "</ASSESSMENT>"
    xml_tags.join("\n")
  end

  def get_control_tags
    control_tags = []
    field_specs = get_oasis_c1_spec_fields('Control')
    health_agency = oasis_doc.treatment.health_agency
    
    raise "Agency NPI number is blank" if health_agency.health_agency_detail.npi_number.blank?
    field_specs.each do |field|
      name = field.field_name
      value = "^"
      case name
        when "ASMT_SYS_CD"
          value = "OASIS"
        when "SUBM_HIPPS_CODE"
          value = oasis_doc.subm_hipps_code
        when "SUBM_HIPPS_VERSION"
          value = oasis_doc.subm_hipps_version
        when "TRANS_TYPE_CD"
          value = export_doc_type.present? ? EXPORT_RECORD_TYPE[export_doc_type] : 1  #1 - new, 2 - modified, 3 - inactive
        when "ITM_SBST_CD"
          value = get_item_subset_code #XX - Inactivation
        when "ITM_SET_VRSN_CD"
          value = is_oasis_c1 ? "C1-012015" : "C-072009"  #C-072009, C1-012015,
        when "SPEC_VRSN_CD"
          value = is_oasis_c1 ? get_spec_version[1..4] : "2.10"
        when "CORRECTION_NUM"
          value = (correction_number || '0').to_s.rjust(2, '0')
        when "STATE_CD"
          value = health_agency.state
        when "HHA_AGENCY_ID"
          value = health_agency.hha_agency_id
        when "SFW_ID"
          value = "461595188" #Fasternotes software id.
        when "SFW_NAME"
          value = "Fasternotes"
        when "SFW_EMAIL_ADR"
          value = "info@fasternotes.com"
        when "SFW_PROD_NAME"
          value = "Fasternotes HHA"
        when "SFW_PROD_VRSN_CD"
          value = "1.1"
        when "NATL_PRVDR_ID"
          value = health_agency.health_agency_detail.npi_number
        when "ACY_DOC_CD"
          value = "^"
      end
      control_tags << "<#{name}>#{value}</#{name}>"
    end
    control_tags
  end

  def get_item_subset_code
    inactive_request? ? "XX" : oasis_doc.m0100_assmt_reason
  end

  def get_assessment_tags
    assessment_tags = []
    field_specs = get_oasis_c1_spec_fields('Assessment')
    field_specs.each do |field|
      field_name = field.field_name
      field_in_downcase = if spec_version == '02.12.0' and field_name.start_with?('M1018')
                            field_name.downcase + "_icd10"
                          else
                            field_name.downcase
                          end
      if inactive_request?
        if OasisExtension.key_fields.include?(field_in_downcase)
          field_in_downcase = field_in_downcase + "_original"
        else
          next
        end
      end
      value = formatted_value(field_specs, field, oasis_doc.send(field_in_downcase))
      assessment_tags << "<#{field_name}>#{value}</#{field_name}>"
    end
    assessment_tags
  end

  def get_filler_tags
    [] #Filter items are should not be included in submission file
  end

  def get_calculated_tags
    [] #Calculated items are should not be included in submission file
  end

  def formatted_value(field_specs, field, value)
    if value.blank?
      if field.data_type == "Boolean"
        field_number = field.field_name[0..4]
        selected_specs = field_specs.select{|field_spec| field_spec.field_name.start_with?(field_number) }
        if selected_specs.any?{|field_spec| oasis_doc.send(field_spec.field_name.downcase).blank? == false }
          return '0'
        else
          return '^'
        end
      else
        return '^'
      end
    end
    type = field.data_type
    if type == "Date"
      value = (value[6..9] + value[0..1] + value[3..4])
    elsif OasisExport.icd_field?(field.field_name.downcase)
      begin
        value = ProspectivePaymentSystem::PPSGrouper.formatted_icd_code_for_xml({field_name: field.field_name.downcase, value: value})
      rescue
        value = '^'
      end
    end
    value
  end
end