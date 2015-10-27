module ReportDataSource
class AlirtsReportByPrimaryDiagnosis

   attr_accessor :year

  def initialize(year, excess_visits)
     @year = year
     @excess_visits = excess_visits
  end

  # get the documents of patients whose document type is PlanOfCare by filtering with year
  def get_patient_treatment_and_docs
    treatments = PatientTreatment.org_scope.where("EXTRACT(YEAR FROM treatment_start_date)='#{@year}' and patient_treatments.id in
       (select treatment_id from documents where document_type = 'PlanOfCare')")
  end

  # define the method to generate the hash output of patient visits by primary source of payment
  def patients_visits_by_primary_diagnosis

    docs = get_icd_code_matched_docs
    patient_and_visits_by_icd_codes = []
    patient_and_visits_by_hiv_alzeimer = []
    names = get_icd_code_names

    names.each_with_index do |name, i|
      patients = []
      visits = []
      docs[i].each do |doc|
        treatment = doc.treatment
        patients << treatment.patient
        visits << get_visits_count(treatment)
      end
      visits_count = visits.present? ? visits.compact.sum : 0
      patient_and_visits_by_icd_codes << {line_number: i+1, principal_diagnosis: name, patients_count: patients.size,
          icd_code_visits_count: visits_count}
    end

    patient_and_visits_by_hiv_alzeimer << {line_number: 51, disease_name: "HIV", patient_count: 0, icd_code_visits_count: 0.00}
    patient_and_visits_by_hiv_alzeimer << {line_number: 52, disease_name: "Alzheimer's Disease", patient_count: 0,
        icd_code_visits_count: 0.00}

    excess_visits = @excess_visits.last

    patient_and_visits_by_icd_codes << {line_number: '**',principal_diagnosis: "Visits not covered by a plan of care",
        patients_count: excess_visits[:non_covered_patients_count],
                                        icd_code_visits_count: excess_visits[:non_covered_visits_count]}
    total_patients_visits_count = patient_and_visits_by_icd_codes.map { |h| h.values_at(:patients_count, :icd_code_visits_count) }.transpose.map {
        |v| v.inject(:+) }

    patient_and_visits_by_icd_codes << {line_number: 45, principal_diagnosis: "TOTAL",
        patients_count: total_patients_visits_count[0],
        icd_code_visits_count: (total_patients_visits_count[1]).to_i}
  end

  def get_icd_code_matched_docs
    treatments =  get_patient_treatment_and_docs
    res = [infec_parasitic_docs = [], hiv_infections_docs = [], malignant1_docs = [], malignant2_docs = [], malignant3_docs = [],
     malignant4_docs = [], non_malignant_docs = [], diabities_docs = [], endocrine_docs = [],
     blood_blood_organs_docs = [], mental_disorder_docs = [], alzheimer_docs = [], nervous_system_docs = [],
     cardiovascularsystem_docs = [], cerebrovascular_docs = [], other_circulatory_system_docs = [],
     respiratory_docs = [], digestive_system_docs = [], genitourinary_docs = [], breast_diseases_docs = [],
     complications_pregnancy_childbirth_docs = [], subcutaneous_docs = [], musculo_skeletal_docs = [],
     congenital_docs = [], ill_defined_conditions_docs = [], fractures_docs = [], injuries_docs = [],
     poisonings_docs = [], complications_surgical_medical_docs = [], reproduction_docs = [],
     infants_outside_hospital_docs = [], health_hazards_docs = [], specific_procedure_docs = [], visits_evaluation_docs = []]

    treatments.each do |treatment|
      doc = treatment.primary_poc_doc
      primary_diagnosis_code = doc.get_primary_diagnosis_code if doc.present?
      next if primary_diagnosis_code.blank?
      icds = [primary_diagnosis_code]

      infec_parasitic_docs << doc unless (inf_range & icds).empty?
      hiv_infections_docs << doc unless (hiv_infections_range & icds).empty?
      malignant1_docs << doc unless (malignant1_range & icds).empty?
      malignant2_docs << doc unless (malignant2_range & icds).empty?
      malignant3_docs << doc unless (malignant3_range & icds).empty?
      malignant4_docs << doc unless (malignant4_range & icds).empty?
      non_malignant_docs << doc unless (non_malignant_range & icds).empty?
      diabities_docs << doc unless (diabities_range & icds).empty?
      endocrine_docs << doc unless (endocrine_range & icds).empty?
      blood_blood_organs_docs << doc unless (blood_blood_organs_range & icds).empty?
      mental_disorder_docs << doc unless (mental_disorder_range & icds).empty?
      alzheimer_docs << doc unless (alzheimer_range & icds).empty?
      nervous_system_docs << doc unless (nervous_system_range & icds).empty?
      cardiovascularsystem_docs << doc unless (cardiovascularsystem_range & icds).empty?
      cerebrovascular_docs << doc unless (cerebrovascular_range & icds).empty?
      other_circulatory_system_docs << doc unless (other_circulatory_system_range & icds).empty?
      respiratory_docs << doc unless (respiratory_range & icds).empty?
      digestive_system_docs << doc unless (digestive_system_range & icds).empty?
      genitourinary_docs << doc unless (genitourinary_range & icds).empty?
      breast_diseases_docs << doc unless (breast_diseases_range & icds).empty?
      complications_pregnancy_childbirth_docs << doc unless (complications_pregnancy_childbirth_range & icds).empty?
      musculo_skeletal_docs << doc unless (musculo_skeletal_range & icds).empty?
      congenital_docs << doc unless (congenital_range & icds).empty?
      ill_defined_conditions_docs << doc unless (ill_defined_conditions_range & icds).empty?
      fractures_docs << doc unless (fractures_range & icds).empty?
      injuries_docs << doc unless (injuries_range & icds).empty?
      poisonings_docs << doc unless (poisonings_range & icds).empty?
      complications_surgical_medical_docs << doc unless (complications_surgical_medical_range & icds).empty?
      reproduction_docs << doc unless (reproduction_range & icds).empty?
      infants_outside_hospital_docs << doc unless (infants_outside_hospital_range & icds).empty?
      health_hazards_docs << doc unless (health_hazards_range & icds).empty?
      specific_procedure_docs << doc unless (specific_procedure_range & icds).empty?
      visits_evaluation_docs << doc unless (visits_evaluation_range & icds).empty?
      subcutaneous_docs << doc unless (subcutaneous_range & icds).empty?
    end
    res
  end

  def get_icd_code_names
    ["Infectious and parasitic diseases (exclude HIV)", "HIV infections (includes AIDS, ARC, HIV)", "Malignant neoplasms: Lung",
     "Malignant neoplasms: Breast","Malignant neoplasms: Intestines",
     "Malignant neoplasms: All other sites, excluding those in lung, breast and intestines",
     "Non-malignant neoplasms: All sites","Diabetes mellitus",
     "Endocrine, metabolic, and nutritional diseases; Immunity disorders","Diseases of blood and blood forming organs",
     "Mental disorder","Alzheimer's disease","Diseases of nervous system and sense organs",
     "Diseases of cardiovascular system","Diseases of cerebrovascular system",
     "Diseases of all other circulatory system","Diseases of respiratory system",
     "Diseases of digestive system","Diseases of genitourinary system","Diseases of breast",
     "Complications of pregnancy, childbirth, and the puerperium","Diseases of skin and subcutaneous tissue",
     "Diseases of musculoskeletal system and connective tissue (include pathological fx, malunion fx, and nonunion fx)",
     "Congenital anomalies and perinatal conditions (include birth fractures)",
     "Symptoms, signs, and ill-defined conditions (exclude HIV positive test)",
     "Fractures (exclude birth fx, pathological fx, malunion fx, nonunion fx)",
     "All other injuries","Poisonings and adverse effects of external causes",
     "Complications of surgical and medical care","Health services related to reproduction and development",
     "Infants born outside hospital (infant care)","Health hazards related to communicable diseases",
     "Other health services for specific procedures and aftercare","Visits for Evaluation and Assessment"]
  end


  def get_hiv_codes
    patient_and_visit_by_hiv_alzeimer = []
    patient_and_visit_by_hiv_alzeimer << {line_number: 51, disease_name: "HIV", patient_count: 0, visit_count: 0.00}
    patient_and_visit_by_hiv_alzeimer << {line_number: 52, disease_name: "Alzheimer's Disease", patient_count: 0, visit_count: 0.00}
    patient_and_visit_by_hiv_alzeimer
  end

  # this method is used to find out all the icd codes between two icd ranges, by taking starting and ending icd
  # codes as parameters
  def get_icd_codes_groups(start_icd, end_icd)
    start_id = ProspectivePaymentSystem::Icd9DiagnosticCode.find_all_by_icd_code(start_icd)
    end_id = ProspectivePaymentSystem::Icd9DiagnosticCode.find_all_by_icd_code(end_icd)
    range = ProspectivePaymentSystem::Icd9DiagnosticCode.select("icd_code").where("id between #{start_id.first.id} and #{end_id.first.id}")
    range = range.map(&:icd_code)
  end

  # this method is used to count the visits of particular group of documents by passing documents as parameter and
  # for a particular year
  def get_visits_count(treatment)
    treatment.treatment_visits.select{|v| v.visit_date.year == year}.count if treatment.treatment_visits.present?
  end

  def inf_range
    return @inf_range if @inf_range.present?
    @inf_range = get_icd_codes_groups("001.0","041.9") + get_icd_codes_groups("045.00","139.8")
  end

  def hiv_infections_range
    ["042"]
  end

  def malignant1_range
    return @malignant1_range if @malignant1_range.present?
    @malignant1_range = get_icd_codes_groups("162.2","162.9") + ["197.0", "209.21", "231.2"]
  end

  def malignant2_range
    return @malignant2_range if @malignant2_range.present?
    @malignant2_range = get_icd_codes_groups("174.0","174.9") +  get_icd_codes_groups("175.0","175.9") +
        ["198.2", "198.81", "233.0"]
  end

  def malignant3_range
    return @malignant3_range if @malignant3_range.present?
    @malignant3_range = get_icd_codes_groups("152.0","154.0") + ["159.0","197.4","197.5","197.8"] + get_icd_codes_groups("209.00","209.17") +
    ["230.3","230.4","230.7"]
  end

  def malignant4_range
    return @malignant4_range if @malignant4_range.present?
    @malignant4_range = get_icd_codes_groups("140.0","209.36")  + get_icd_codes_groups("230.0","234.9")
  end

  def non_malignant_range
    return @non_malignant_range if @non_malignant_range.present?
    @non_malignant_range = get_icd_codes_groups("209.40","209.79") + get_icd_codes_groups("210.0","229.9") + get_icd_codes_groups("235.0","238.9") +
    get_icd_codes_groups("239.0","239.9")
  end

  def diabities_range
    return @diabities_range if @diabities_range.present?
    @diabities_range = get_icd_codes_groups("249.00","250.93")
  end

  def endocrine_range
    return @endocrine_range if @endocrine_range.present?
    @endocrine_range = get_icd_codes_groups("240.0","246.9") + get_icd_codes_groups("251.0","279.9")
  end

  def blood_blood_organs_range
    return @blood_blood_organs_range if @blood_blood_organs_range.present?
    @blood_blood_organs_range = get_icd_codes_groups("280.0","289.9")
  end

  def mental_disorder_range
    return @mental_disorder_range if @mental_disorder_range.present?
    @mental_disorder_range = get_icd_codes_groups("290.0","319")
  end

  def alzheimer_range
    ["331.0"]
  end

  def nervous_system_range
    return @nervous_system_range if @nervous_system_range.present?
    @nervous_system_range = get_icd_codes_groups("320.0","330.9") + get_icd_codes_groups("331.11","389.9")
  end

  def cardiovascularsystem_range
    return @cardiovascularsystem_range if @cardiovascularsystem_range.present?
    @cardiovascularsystem_range = get_icd_codes_groups("391.0","392.0") + get_icd_codes_groups("393","402.91")  + get_icd_codes_groups("404.00","429.9")
  end

  def cerebrovascular_range
    return @cerebrovascular_range if @cerebrovascular_range.present?
    @cerebrovascular_range = get_icd_codes_groups("430","438.9")
  end

  def other_circulatory_system_range
    return @other_circulatory_system_range if @other_circulatory_system_range.present?
    @other_circulatory_system_range = ['390','392.9'] + get_icd_codes_groups("403.00","403.91") + get_icd_codes_groups("440.0","459.9")
  end

  def respiratory_range
    return @respiratory_range if @respiratory_range.present?
    @respiratory_range = get_icd_codes_groups("460","519.9")
  end

  def digestive_system_range
    return @digestive_system_range if @digestive_system_range.present?
    @digestive_system_range = get_icd_codes_groups("520.0","579.9")
  end

  def genitourinary_range
    return @genitourinary_range if @genitourinary_range.present?
    @genitourinary_range = get_icd_codes_groups("580.0","608.9") + get_icd_codes_groups("614.0","629.9")
  end

  def breast_diseases_range
    return @breast_diseases_range if @breast_diseases_range.present?
    @breast_diseases_range = get_icd_codes_groups("610.0","611.9")
  end

  def complications_pregnancy_childbirth_range
    return @complications_pregnancy_childbirth_range if @complications_pregnancy_childbirth_range.present?
    @complications_pregnancy_childbirth_range = get_icd_codes_groups("630","679.14")
  end

  def subcutaneous_range
    return @subcutaneous_range if @subcutaneous_range.present?
    @subcutaneous_range = get_icd_codes_groups("680.0","709.9")
  end

  def musculo_skeletal_range
    return @musculo_skeletal_range if @musculo_skeletal_range.present?
    @musculo_skeletal_range = get_icd_codes_groups("710.0","739.9")
  end

  def congenital_range
    return @congenital_range if @congenital_range.present?
    @congenital_range = get_icd_codes_groups("740.0","779.9")
  end

  def ill_defined_conditions_range
    return @ill_defined_conditions_range if @ill_defined_conditions_range.present?
    @ill_defined_conditions_range = get_icd_codes_groups("780.01","795.6") + ["795.79"] + get_icd_codes_groups("796.0","799.9")
  end

  def fractures_range
    return @fractures_range if @fractures_range.present?
    @fractures_range = get_icd_codes_groups("800.00","829.1")
  end

  def injuries_range
    return @injuries_range if @injuries_range.present?
    @injuries_range = get_icd_codes_groups("830.0","959.9")
  end

  def poisonings_range
    return @poisonings_range if @poisonings_range.present?
    @poisonings_range = get_icd_codes_groups("960.0","995.94")
  end

  def complications_surgical_medical_range
    return @complications_surgical_medical_range if @complications_surgical_medical_range.present?
    @complications_surgical_medical_range = get_icd_codes_groups("996.00","999.9")
  end

  def reproduction_range
    return @reproduction_range if @reproduction_range.present?
    @reproduction_range = get_icd_codes_groups("V20.0","V26.9") + get_icd_codes_groups("V28.0","V29.9")
  end

  def infants_outside_hospital_range
    ["V30.1", "V30.2", "V31.1", "V31.2", "V32.1", "V32.2", "V33.1", "V33.2", "V34.1", "V34.2",
     "V35.1", "V35.2", "V36.1", "V36.2", "V37.1", "V37.2", "V39.1", "V39.2"]
  end

  def health_hazards_range
    return @health_hazards_range if @health_hazards_range.present?
    @health_hazards_range = get_icd_codes_groups("V01.0","V07.9") + get_icd_codes_groups("V09.0","V19.8") +
        get_icd_codes_groups("V40.0","V49.9")
  end

  def specific_procedure_range
    return @specific_procedure_range if @specific_procedure_range.present?
    @specific_procedure_range = get_icd_codes_groups("V50.0", "V58.9")
  end

  def visits_evaluation_range
    return @visits_evaluation_range if @visits_evaluation_range.present?
    @visits_evaluation_range = get_icd_codes_groups("V60.0", "V91.99")
  end

end
end