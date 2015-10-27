class ProspectivePaymentSystem::PPSGrouper

  def self.generate_hipps_code(export_oasis_record)
    hipps_code_generator =  ProspectivePaymentSystem::HippscodeGenerator.new(export_oasis_record)
    hipps_code_generator.calculate_hipps_code
  end

  def self.medicare_bill_amount(params)
    raise "#{params[:rfa_year]} bill rates are not updated " unless ProspectivePaymentSystem::HhrgWeight.find_by_calender_year(params[:rfa_year])
    bill_calculator =  ProspectivePaymentSystem::MedicareBillCalculator.new(params)
    bill_calculator.medicare_bill_amount(params[:final_claim_flag])
  end

  def self.cbsa_code(county_name, state_name, year)
    cbsa =   ProspectivePaymentSystem::MedicareCoreStatArea.where(county_name: county_name, state_name: state_name, calender_year: year).first
    cbsa ? cbsa.cbsa_code : nil
  end

  def self.icd_query(column)
    procedure_code_columns = [:m1012]
    diagnostic_code_columns = [:m1010, :m1011, :m1016, :m1017, :m1020, :m1021, :m1022, :m1023, :m1024, :m1025]
    if diagnostic_code_columns.any?{|code| column.starts_with?(code.to_s)}
      code_type = diagnostic_code_columns.detect{|code| column.starts_with?(code.to_s)}
      case code_type
        when :m1010, :m1016, :m1024 #v and e codes not allowed
          ProspectivePaymentSystem::Icd9DiagnosticCode.where("icd_code NOT like 'V%' and icd_code NOT like 'E%'")
       when :m1011, :m1017, :m1025
          ProspectivePaymentSystem::Icd10DiagnosticCode.where("icd_code NOT like 'V%' and icd_code NOT like 'W%' and icd_code NOT like 'X%' and icd_code NOT like 'Y%' and icd_code NOT like 'Z%' ")
        when :m1020 #v codes allowed
          ProspectivePaymentSystem::Icd9DiagnosticCode.where("icd_code NOT like 'E%'")
        when :m1022 #v and e codes are allowed
          ProspectivePaymentSystem::Icd9DiagnosticCode
        when :m1023 #v,w,x,y,z codes are allowed
          ProspectivePaymentSystem::Icd10DiagnosticCode
        when :m1021, :m1023 #v,w,x,y are not allowed
          ProspectivePaymentSystem::Icd10DiagnosticCode.where("icd_code NOT like 'V%' and icd_code NOT like 'W%' and icd_code NOT like 'X%' and icd_code NOT like 'Y%'")
      end
    elsif procedure_code_columns.any?{|code| column.starts_with?(code.to_s)}
      ProspectivePaymentSystem::Icd9ProcedureCode
    end
  end

  def self.get_diagnostic_icd_code_description(icd_code)
    ProspectivePaymentSystem::Icd9DiagnosticCode.find_by_icd_code(icd_code).long_description if icd_code
  end

  def self.get_diagnostic_icd10_code_description(icd_code)
    ProspectivePaymentSystem::Icd10DiagnosticCode.find_by_icd_code(icd_code).long_description if icd_code
  end

  def self.get_procedure_icd10_code_description(icd_code)
    ProspectivePaymentSystem::Icd10ProcedureCode.find_by_icd_code(icd_code).long_description if icd_code
  end

  def self.get_procedure_icd_code_description(icd_code)
    ProspectivePaymentSystem::Icd9ProcedureCode.find_by_icd_code(icd_code).long_description if icd_code
  end

  def self.diagnostic_code_present?(params)
    icd_code = params[:icd_code]
    if params[:e_code] == false and params[:v_code] == false
      ProspectivePaymentSystem::Icd9DiagnosticCode.where("icd_code NOT like 'V%' and icd_code NOT like 'E%'
          and upper(icd_code) = upper('#{icd_code}')")
    elsif params[:e_code] == false and params[:v_code] == true
      ProspectivePaymentSystem::Icd9DiagnosticCode.where("icd_code NOT like 'E%' and upper(icd_code) = upper('#{icd_code}')")
    elsif (params[:v_code] == false and params[:w_code] == false and params[:x_code] == false and params[:y_code] == false and params[:z_code] == false)
      ProspectivePaymentSystem::Icd10DiagnosticCode.where("icd_code NOT like 'V%' and icd_code NOT like 'W%' and icd_code NOT like 'X%'
           and icd_code NOT like 'Y%' and icd_code NOT like 'Z%' and upper(icd_code) = upper('#{icd_code}')")
    elsif (params[:v_code] == false and params[:w_code] == false and params[:x_code] == false and params[:y_code] == false)
      ProspectivePaymentSystem::Icd10DiagnosticCode.where("icd_code NOT like 'V%' and icd_code NOT like 'W%' and icd_code NOT like 'X%' 
          and icd_code NOT like 'Y%' and upper(icd_code) = upper('#{icd_code}')")
        else
      ProspectivePaymentSystem::Icd9DiagnosticCode.where("upper(icd_code) = upper('#{icd_code}')")
    end
  end

  def self.procedure_code_present?(params)
    ProspectivePaymentSystem::Icd9ProcedureCode.where("upper(icd_code) = upper('#{params[:icd_code]}')")
  end

  def self.formatted_icd_code(params)
    icd_query(params[:field_name]).find_by_icd_code(params[:value]).formatted_icd_code
  end

  def self.formatted_icd_code_for_xml(params)
    icd_query(params[:field_name]).find_by_icd_code(params[:value]).formatted_icd_code_for_xml
  end

  def self.icd_code_list(params)
    query = "#{params[:query]}".downcase
    data_class = if OasisExtension::ICD10_FIELDS_SET.include? params[:column]
                   params[:procedure_code] ? ProspectivePaymentSystem::Icd10ProcedureCode : ProspectivePaymentSystem::Icd10DiagnosticCode
                 else
                   params[:procedure_code] ? ProspectivePaymentSystem::Icd9ProcedureCode : ProspectivePaymentSystem::Icd9DiagnosticCode
                 end
    query = "#{params[:query]}".downcase
    icd_data_class ||= data_class
    icd_data_class ||= icd_query(params[:column])
    values = if query.blank?
               [[]]
             else
               records = icd_data_class.where("lower(icd_code) like '%#{query}%' or lower(short_description) like '%#{query}%' or lower(long_description) like '%#{query}%'").limit(25)
               records.map{|r|
                 [r.icd_code, r.send(:to_s)]
               }
             end
    values
  end

end