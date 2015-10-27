class OasisPocSync
  attr_accessor :oasis, :poc

  HEALTH_STATUS_MAP = {"00" => "The patient is stable with no heightened risk(s) for serious complications and death " +
                                 "(beyond those typical of the patient`s age).",
                       "01" => "The patient is temporarily facing high health risk(s) but is likely to return to being " +
                                 "stable without heightened risk(s) for serious complications and death (beyond those " +
                                 "typical of the patient`s age).",
                       "02" => "The patient is likely to remain in fragile health and have ongoing high risk(s) of " +
                                 "serious complications and death.",
                       "03" => "The patient has serious progressive conditions that could lead to death within a year.",
                       "UK" => "The patient`s situation is unknown or unclear."}

  NO_PROBLEM_MAP ={"NP" => "No Problem", "NA" => "N/A"}
  SLEEP_OR_REST = {"1" => "Adequate", "2" => "Inadequate"}

  ABDOMEN_MAP = {"1" => "Tenderness", "2" => "Pain", "3" => "Distention", "4" => "Hard", "5" => "Soft", "6" => "Ascites",
                  "7" => "Abdominal", "8" => "Other", "9" => "Bowel sounds"}

  BOWEL_SOUNDS_MAP = {"1" => "Active", "2" => "Absent", "3" => "Hypo", "4" => "Hyperactive", "5" => "Other"}

  HOMEBOUND_REASON_MAP = {"1" => "Needs assistance for all activities", "2" => "Residual weakness", "3" => "Requires assistance to ambulate",
                          "4" => "Confusion, unable to go out of home alone", "5" => "Unable to safely leave home unassisted",
                            "6" => "Severe SOB, SOB upon exertion", "7" => "Dependent upon adaptive device(s)",
                           "8" => "Medical restrictions", "9" => "Other(specify)" }

  PERTINENT_HISTORY_MAP = {"1" => "Hypertension", "2" => "Cardiac", "3" => "Diabetes", "4" => "Cancer",
                                        "5" => "Respiratory", "6" => "Osteoporosis", "7" => "Fractures",
                                        "8" => "Surgeries", "9" => "Infection", "10" => "Immunosuppressed",
                                        "11" => "Open Wound", "12" => "Other"}
  IMMUNIZATIONS = {"1" => "Influenza"}

  IMMUNIZATION_GUIDELINES_MAP = {"1" => "Pneumonia", "2" => "Tetanus", "3" => "Other"}

  PRIOR_HOSPITALIZATIONS_MAP  = {"1" => "No", "2" => "Yes"}

  PROGNOSIS_MAP = {"1" => "Poor", "2" => "Guarded", "3" => "Fair", "4" => "Good", "5" => "Excellent"}

  SAFETY_MEASURES = {'1' => "Bleeding precautions", '2' => "O2 precautions", '3' => "Seizure precautions",
                     '4' => "Fall precautions", '5' => "Aspiration precautions", '6' => "Siderails up",
                     '7' => "Elevate head of bed", '8' => "24 hr. supervision", '9' => "Clear pathways",
                     "10" => "Lock w/c with transfers", "11" => "Walker", "12" => "Infection control measures",
                     "13" => "cane", "14" => "Other"}

  EYES_MAP = {"1" => "Glasses", "2" => "Glaucoma", "3" => "Jandice", "4" => "Contacts", "5" => "Blurred vision", "6" => "Ptosis",
              "7" => "Prosthesis", "8" => "Blind", "9" => "Other", "10" => "Infections", "11" => "Cataract surgery",
              }

  RIGHT_LEFT_MAP = {"1" => "Right", "2" => "Left"}

  YES_NO_MAP = {"Y" => "Yes", "N" => "No"}

  EARS_MAP = {"1" => "HOH" , "2" => "Deaf", "3" => "Hearing aid", "4" => "Tinnitus", "5" => "Vertigo", "6" => "Other"}

  NOSE_MAP = {"1" => "Congestion", "2" => "Epistaxis", "3" => "Loss of smell", "4" => "Sinus problem", "5" => "Other"}

  THROAT_MAP = {"1" => "Dysphagia", "2" => "Hoarseness", "3" => "Lesions", "4" => "Sore throat", "5" => "Other"}

  MOUTH_MAP = {"1" => "Dentures", "2" => "Masses", "3" => "Tumors", "4" => "Gingivitis", "5" => "Ulcerations", "6" => "Toothache",
              "7" => "Other"}

  DENTURES_MAP = {"1" => "Upper", "2" => "Lower", "3" => "Partial"}

  LIVING_ARRGMENTS_OXYGEN_BACK_UP = {"1" => "Available", "2" => "Knows how to use", "3" => "Electrical/ fire safety"}

  INTENSITY_SCALE_MAP = {"1" => "FACES Scale", "2" => "0 - 10 Scale"}

  PATIENT_PAIN_MAP = {"1" => "Unable to communicate", "2" => "Diaphoresis", "3" => "Grimacing", "4" => "Moaning",
                      "5" => "Crying", "6" => "Guarding", "7" => "Irritability", "8" => "Anger", "9" => "Tense",
                      "10" => "Restlessness", "11" => "Change in vital signs", "12" => "Self-assessment",
                        "13" => "Other", "14" => "Implications"}

  PAIN_FREQUENCY_MAP = {"1" => "Occassionally", "2" => "Continuous", "3" => "Intermittent"}

  PAIN_BETTER_MAP = {"1" => "Movement", "2" => "Ambulation", "3" => "Immobility", "4" => "Other"}

  MEDICATION_NEEDED_MAP = {"1" => "Never", "2" => "Less than daily", "3" => "2-3 times/day", "4" => "More than 3 times/day"}

  PAIN_RADIATE_MAP = {"1" => "Occasionally", "2" => "Continuously", "3" => "Intermittent"}

  NOTIFIED_BY_MAP = {"1" => "Patient", "2" => "Staff"}

  INTEGUMENTARY_MAP = {"1" => "Turgor", "2" => "Itch", "3" => "Rash", "4" => "Dry", "5" => "Scaling", "6" => "Redness",
                        "7" => "Bruises", "8" => "Ecchymosis", "9" => "Pallor", "10" => "Jaundice"}

  TURGOR = {"G" => "Good", "P" => "Poor"}

  SOILED_DRESSING_MAP = {"PA" => "Patient", "RN" => "RN", "CG" => "Caregiver", "PT" => "PT" ,"OTH" => "Other"}

  WOUND_CARE_TECHNIQUE_MAP = {"1" => "Sterile", "2" => "Clean"}

  WOUND_CLEANED = {"1" => "Wound cleaned with"}

  WOUND_IRRIGATED = {"1" => "Wound irrigated with"}

  WOUND_PACKED = {"1" => "Wound packed with"}

  WOUND_DRESSING = {"1" => "Wound dressing applied"}

  PEDAL_PULSES = {"1" => "Present", "2" => "Absent"}

  LEG_HAIR = {"1" => "Present", "2" => "Absent"}

  LOSS_OF_SENSE = {"1" => "Warm", "2" => "Cold"}

  NEUROPATHY = {"1" => "Tingling", "2" => "burning"}

  WOUND_CARE_DME = {"1" => "2X2's", "2" => "4X4's", "3" => "ABD's", "4" => "Cotton tipped applicators", "5" => "Wound cleanser",
                    "6" => "Wound gel", "7" => "Drain sponges", "8" => "Gloves", "9" => "Sterile", "10" => "Non-Sterile",
                    "11" => "Hydrocolloids", "12" => "Nu-gauze", "13" => "Saline", "14" => "Tape", "15" => "Transparent Dressing",
                    "16" => "Other"}

  ENDOCRINE = {"1" => "Diabetes", "2" => "Diet/Oral Control", '3' => "Hypoglycemia", "4" => "Insulin dose/frequency", "5" => "Hyperglycemia",
                "6" => "Blood sugar ranges", "7" => "Patient Report", "8" => "Caregiver Report", "9" => "Disease Management Problems",
                "10" => "Enlarged Thyroid", "11" => "Anemia", "12" => "Secondary bleed"}

  DIABETES = {"1" => "Type I Juvenile", "2" => "Type II"}

  BLOOD_SUGAR_REPORT = {'1' => "Patient Report", '2' => "Caregiver Report"}

  CAREGIVERS_LIST = {"SF" => "Self", "CG" => "Caregiver", "NR" => "Nurse",  "RN" => "RN", "FY" => "Family", "OTH" => "Other"}

  HYPERGLYCEMIA = {"1" => "Glycosuria", "2" => "Polyuria", "3" => "Polydipsia"}

  HYPOGLYCEMIA = {'1' => "Sweats", '2' => "Polyphagia", '3' => "Weak", '4' => "Faint", '5' => "Stupor"}

  A1C = {"1" => "Today's Visit", "2" => "Patient Reported", "3" => "Lab slip"}

  BS = {"1" => "FBS", "2" => "Before Meal", "3" => "Postprandial", "4" => "Random HS"}

  ENDOCRINE_MISCELLANEOUS = {"1" => "Fatigue", "2" => "Intolerance to heat/cold", "3" => "Other"}

  SECONDARY = {"1" => "GI", "2" => "GU", "3" => "GYN", "4" => "unknown", "5" => "Hemophilia", "6" => "Other"}

  DIABETIC_SUPPLIES = {"1" => "Chemstrips", "2" => "Syringes", "3" => "Other"}

  #WHO_MANAGES = {"SF" => "Self", "CG" => "Caregiver", "RN" => "RN", "FY" => "Family"}

  BREATH_SOUNDS = {"1" => "Cough", "2" => "Dyspnea"}

  PRODUCTIVE = {"PR" => "Productive", "NPR" => "Non-Productove"}

  DYSPNEA = {"1" => "Rest", "2" => "During ADL's"}

  HEART_SOUNDS = {"1" => "Regular", "2" => "Irregular", "3" => "Murmur", "4" => "Pacemaker", "5" => "Chest Pain",
                  "6" => "Edema", "7" => "Cramps", "8" => "Claudication", "9" => "Capillary refill",
                  "10" => "Disease Management Problems"}

  CHEST_PAIN = {"1" => "Anginal", "2" => "Postural", "3" => "Localized", "4" => "Substernal", "5" => "Radiating", "6" => "Dull",
                "7" => "Ache", "8" => "Sharp", "9" => "Vise-like"}

  ASSOCIATED_WITH = {"1" => "Shortness of breath", "2" => "Activity", "3" => "Sweats", "4" => "Palpitations", "5" => "Fatigue"}

  EDEMA = {"1" => "Pedal", "2" => "Sacral", "3" => "Dependent",}

  EDEMA_PITTING = {"1" => "Pitting", "2" => "Non-Pitting"}

  CAPILLARY_REFILL = {"1" => "Less than 3 sec", "2" => "Greater than 3 sec"}

  GENITOURINARY = {"1" => "Urgency", "2" => "Frequency", "3" => "Burning", "4" => "Pain", "5" => "Hesitancy", "6" => "Nocturia",
                   "7" => "Hematuria", "8" => "Ollguria", "9" => "Anuria", "10" => "Incontinence", "11" => "Diapers", "12" => "Other",
                   "13" => "Urostomy"}

  GENITOURINARY_DIFFICULTY = {"1" => "Without difficulty", "2" => "Suprapubic"}

  GENITOURINARY_COLOR = {"YE" => "Yellow", "ST" => "Straw", "AM" => "Amber", "BR" => "Brown", "GR" => "Gray", "BT" => "Blood-tinged",
                        "OTH" => "Other"}

  GENITOURINARY_CLARITY = {"CL" => "Clear", "CD" => "Cloudy", "SD" => "Sediment", "MU" => "mucous"}

  #OSTOMY_CARE_MANAGED_BY = {"SF" => "Self", "CG" => "Caregiver"}

  URINARY_OSTOMY_SUPPLIES = {"1" => "Underpads", "2" => "External catheters", "3" => "Urinary", "4" => "Ostomy pouch", "5" => "Ostomy wafer",
                             "6" => "Stoma adhesive tape", "7" => "Skin protectant", "8" => "Other"}

  DMESUPPLIES_MISCELLANEOUS = {"1" => "Enema supplies", "2" => "Feeding tube", "3" => "Suture removal kit", "4" => "Staple removal kit",
                               "5" => "Steri strips", "6" => "Other" }

  FOLEY_SUPPLIES = {"1" => "Straight catheter", "2" => "Irrigation tray", "3" => "Saline", "4" => "Acetic acid", "5" => "Other"}

  NUTRITIONAL_STATUS = {"1" => "NAS", "2" => "NPO", "3" => "Controlled Carbohydrate", "4" => "Other", "5" => "Increase Fluids", "6" => "Restrict Fluids"}

  NUTRITIONAL_APPETITE = {"G" => "Good", "F" => "Fair", "P" => "Poor", "A" => "Anorexic"}

  APPETITE = {"1" => "Nausea/Vomiting", "2" => "Heartburn"}

  ENTERAL_FEEDINGS = {"1" => "Nasogastric", "2" => "Gastrostomy", "3" => "Jejunostomy", "4" => "Other",
                      "5" => "Pump"}

  ENTERAL_FEEDINGS_PUMP_TYPE = {"B" => "Bolus", "C" => "Continuous"}

  #ENTERAL_FEEDING_PERFORMED_BY = {"SF" => "Self", "RN" => "RN", "CG" => "Caregiver"}

  ELIMINATION = {"1" => "Flatulence", "2" => "Constipation", "3" => "Impaction", "4" => "Diarrhea", "5" => "Last BM",
                "6" => "Hemorrhoids", "7" => "Rectal bleeding", "8" => "Frequency of stools", "9" => "Laxative/Enema use",
                 "10" => "Incontinence", "11" => "Diapers", "12" => "Ileostomy"}

  LAXATIVE_ENEMA_USE = {"D" => "Daily", "W" => "Weekly", "M" => "Monthly", "O" => "Other"}

  NEURO_EMOTIONAL_BEHAVIOUR = {"1" => "Headache", "2" => "PERRLA", "3" => "Un equal pupils", "4" => "Aphasia", "5" => "Motor change",
                              "6" => "Dominant side", "7" => "Weakness", "8" => "Tremors", "9" => "Stuporous",
                              "10" => "Psychotropic drug use", "11" => "Other"}

  APHASIA = {"1" => "Receptive", "2" => "Expressive"}

  MOTOR_CHANGE = {"F" => "Fine", "G" => "Gross"}

  TREMORS = {"F" => "Fine", "G" => "Gross", "P" => "Paralysis"}

  STUPOROUS = {"1" => "Visual", "2" => "Auditory"}

  MENTAL_STATUS = {"1" => "Oriented", "2" => "Comatose", "3" => "Forgetful", "4" => "Depressed", "5" => "Disoriented",
                  "6" => "Lethargic", "7" => "Agitated", "8" => "Other"}


  PSYCHOSOCIAL = {"1" => "Language barrier", "2" => "Needs interpreter", "3" => "Learning barrier", "4" => "Unable to read",
                  "5" => "Unable to write", "6" => "Spiritual / Cultural implications that impact care", "7" => "Sleep",
                  "8" => "Inappropriate responses to caregivers/clinician", "9" => "Inappropriate follow-through in past",
                  "10" => "Angry", "11" => "Flat effect", "12" => "Discouraged", "13" => "Withdrawn", "14" => "Difficulty coping",
                  "15" => "Disorganized", "16" => "Depressed", "17" => "Inability to cope", "18" => "Evidence",
                  }
  LEARNING_BARRIERS = {"1" => "Mental", "2" => "Psychosocial", "3" => "Physicial", "4" => "Functional"}

  INAPPROPRIATE_RESPONSES = {"1" => "Caregivers", "2" => "Clinician"}

  DEPRESSED = {"1" => "Recent", "2" => "Long-term"}

  INABILITY_TO_COPE = {"1" => "Lack of motivation", "2" => "Unrealistic expectations", "3" => "Inability to recognize problems",
                        "4" => "Denial of problems"}

  EVIDENCE  = {"1" => "Abuse", "2" => "Neglect", "3" => "Exploitation","4" => "Potential", "5" => "Actual", "6" => "Verbal",
               "7" => "Emotional", "8" => "Physical", "9" => "Financial", "10" => "Intervention"}

  MUSCULOSKELETAL = {"1" => "Hemiplegia", "2" => "Paraplegia", "3" => "Quadriplegia", "4" => "Poor conditioning",
                     "5" => "Shuffling", "6" => "Wide-based gait", "7" => "Fracture", "8" => "Swollon, painful joints",
                    "9" => "Atrophy", "10" => "Decreased ROM", "11" => "Paresthesia", "12" => "Weakness", "13" => "Contractures",
                    "14" => "Amputation", "15" => "Other"}

  ACTIVITIES_PERMITTED = {"1" => "Complete bedrest", "2" => "Bedrest/BRP", "3" => "Up as tolerated", "4" => "Transfer bed/chair",
                          "5" => "Exercises prescribed", "6" => "Partial weight bearing", "7" => "Independent in home",
                          "8" => "Crutches", "9" => "Cane", "10" => "Wheelchair", "11" => "Walker", "12" => "No restrictions",
                          "13" => "Other"}

  SUPPLIES_EQUIPMENT = {"1" => "Bathbench", "2" => "Cane", "3" => "Commode", "4" => "Eggcrate", "5" => "Hospital bed",
                        "6" => "Hoyer lift", "7" => "Enteral feeding pump", "8" => "Nebulizer", "9" => "Oxygen concentrator",
                        "10" => "Suction machine", "11" => "Ventilator", "12" => "Walker", "13" => "Wheelchair",
                        "14" => "Tens unit", "15" => "Special mattress overlay", "16" => "Pressure relieving device", "17" => "Other"}

  FUNCTIONAL_LIMITATIONS = {"1" => "Amputation", "2" => "Bowel/Bladder", "3" => "Contracture", "4" => "Hearing", "5" => "Paralysis",
                            "6" => "Endurance", "7" => "Ambulation", "8" => "Speech", "9" => "Legally blind",
                            "10" => "Dyspnea with minimal exertion", "11" => "Other"}

  ALLERGIES = {"1" => "None Known", "2" => "Aspirin", "3" => "Penicillin", "4" => "Sulfa", "5" => "Pollen", "6" => "Eggs",
              "7" => "Milk products", "8" => "Insect bites", "9" => "Other"}

  INFUSION = {"1" => "Peripheral line", "2" => "Midline catheter", "3" => "Central line", "4" => "Groshong", "5" => "Non-Groshong",
              "6" => "Tunneled", "7" => "Non-Tunneled", "8" => "Medication(s) administered", "9" => "Medication(s) administered", "10" => "Pump",
              "11" => "Infusion care provided during visit"}

  LUMENS = {"S" => "Single", "D" =>"Double", "T" => "Triple"}

  DRESSING_FREQUENCY = {"1" => "Sterile", "2" => "Clean"}

  PURPOSE_OF_INTRAVENOUS_ACCESS = {"1" => "Antibiotic therapy", "2" => "Pain control", "3" => "Lab draws", "4" => "Chemotherapy",
                                  "5" => "Maintain venous access", "6" => "Hydration", "7" => "Parenteral nutrition",
                                  "8" => "Other"}

  IV_SUPPLIES = {"1" => "IV start kit", "2" => "IV pole", "3" => "IV tubing", "4" => "Alcohol swabs", "5" => "Tape",
                 "6" => "Injection caps", "7" => "Central line dressing", "8" => "Angiocatheter size", "9" => "Extension tubings",
                 "10" => "Batteries size", "11" => "Syringes size", "12" => "Infusion pump", "13" => "Other"}

  MEDICATION_STATUS = {"1" => "Medication regimen completed", "2" => "Medication regimen reviwed", "3" => "No change",
                       "4" => "Order obtained"}

  IDENTIFICATION = {"1" => "Potential adverse effects", "2" => "Drug reactions", "3" => "Ineffective drug therapy",
                    "4" => "Significant side effects", "5" => "Significant drug interactions", "6" => "Duplicate drug therapy",
                    "7" => "Non-compliance with drug therapy"}

  SOURCE_OF_ASSISTANCE = {"1" => "Brace", "2" => "Transfer equipment", "3" => "Prosthesis", "4" => "Grab bars",
                           "5" => "Hospital bed", "6" => "Medical Alert", "7" => "Oxygen",
                            "8" => "Organizations providing equipment", "9" => "Needs"}

  BRACE = {"1" => "Orthotics"}

  TRANSFER_EQUIPMENT = {"1" => "Board", "2" => "Lift", "3" => "Bedside Commode"}

  GRAB_BARS = {"1" => "Bathroom", "2" => "Other"}

  HOSPITAL_BED = {"1" => "Semi-electric", "2" => "Crank", "3" => "Special"}

  REFERRAL = YES_NO_MAP.merge({"R" => "Refused", "NA" => "N/A"})

  CARE_COORDINATION = {"1" => "Physician", "2" => "SN", "3" => "PT", "4" => "OT", "5" => "ST", "6" => "MSW", "7" => "Aide",
                      "8" => "Other"}

  CARE_PLAN = {"1" => "Reviewed with patient involvement"}

  DISCHARGE_PLANS = {"1" => "Return to an independent level of care(self-care)", "2" => "Able to remain in residence with assistance of primary caregiver/
                    support from community agencies", "3" => "When patient knowledgeable about when to notify physician",
                    "4" => "Able to understand medication regime and care related to diagnoses", "5" => "Medical condition stabilizes",
                    "6" => "When maximum functional potential reached", "7" => "Discharge at the end of episode if the patient is hospitalized",
                    "8" => "Other"}

  REHAB_POTENTIAL = {"P" => "Poor", "F" => "Fair", "G" => "Good", "E" => "Excellent"}

  GENITALIA = {"1" => "Discharge", "2" => "Drainage", "3" => "Lesions", "4" => "Blisters", "5" => "Masses", "6" => "Cysts",
               "7" => "Inflammation", "8" => "Surgical alteration", "9" => "Prostate problem", "10" => "Self-testicular exam",
               "11" => "Menopause", "12" => "Hysterectomy", "13" => "Breast self-exam", "14" => "Discharge:R/L", "15" => "Mastectomy",
               "16" => "Other"}


  def initialize(oasis, poc)
    @oasis = oasis
    @poc = poc
  end

  def miscellaneous_content
    string_arr = []
    patient_info = "The patient is a #{patient_age} year old #{patient_race_or_ethnicity} #{patient_gender}"
    patient_info += primary_reason_for_home_health.blank? ? '.' : ", admitted to home health for #{primary_reason_for_home_health}."
    patient_history =  " The patient has a pertinent history of "
    history_list = [pertinent_history, risk_factors, hospitalization_risk, homebound_status].compact
    str = history_list.select{|x| x.blank? == false }.join(", ")
    patient_info +=  (patient_history + str + '.') unless str.blank?

    string_arr << (patient_info + "\n")
    string_arr << patient_discharge_history
    string_arr << current_overall_health_status
    string_arr << caregivers
    string_arr << five_senses
    string_arr << cardiopulmonary
    string_arr << gastrointestinal
    string_arr << genitourinary
    string_arr << genitalia
    string_arr << pain
    string_arr << endocrine
    string_arr << integumentary
    string_arr << neurologic
    string_arr << extremities
    string_arr << fall_risk_assessment
    string_arr << nutritional_risk_assessment

    string_arr.flatten!
    string_arr.select{|x| x.blank? == false}.join("\n")
  end

  def dme_supplies
    list  = []
    list << oasis.wound_care_dme.collect{|x| WOUND_CARE_DME[x] } unless oasis.wound_care_dme.blank?
    list << oasis.iv_supplies.collect{|x| IV_SUPPLIES[x] } unless oasis.iv_supplies.blank?
    list << oasis.urinary_ostomy_supplies.collect{|x| URINARY_OSTOMY_SUPPLIES[x] } unless oasis.urinary_ostomy_supplies.blank?
    list << oasis.foley_supplies.collect{|x| FOLEY_SUPPLIES[x] } unless oasis.foley_supplies.blank?
    list << oasis.miscellaneous.collect{|x| DMESUPPLIES_MISCELLANEOUS[x] } unless oasis.miscellaneous.blank?
    list << oasis.diabetic_supplies.collect{|x| DIABETIC_SUPPLIES[x] } unless oasis.diabetic_supplies.blank?
    list << oasis.supplies_equipment.collect{|x| SUPPLIES_EQUIPMENT[x] } unless oasis.supplies_equipment.blank?

    list.flatten.select{|attr| attr}
  end

  def other_dme_supplies
    str = []
    str << oasis.other_wound_care_dme unless oasis.other_wound_care_dme.blank?
    str << oasis.other_iv_supplies unless oasis.other_iv_supplies.blank?
    str << oasis.other_urinary_ostomy_supplies unless oasis.other_urinary_ostomy_supplies.blank?
    str << oasis.other_foley_supplies unless oasis.other_foley_supplies.blank?
    str << oasis.other_miscellaneous unless oasis.other_miscellaneous.blank?
    str << oasis.other_diabetic_supplies unless oasis.other_miscellaneous.blank?
    str << oasis.other_supplies_equipment unless oasis.other_miscellaneous.blank?
    str.join(", ")
  end

  def functional_limitation_content
    oasis.functional_limitations.collect{|x| FUNCTIONAL_LIMITATIONS[x]} unless oasis.functional_limitations.blank?
  end

  def other_functional_limitations_content
    oasis.functional_limitations_other
  end

  def activities_permitted
    oasis.activities_permitted.collect{|x| ACTIVITIES_PERMITTED[x]} unless oasis.activities_permitted.blank?
  end

  def other_activities_permitted
    oasis.other_activities_permitted
  end

  def metal_status_content
    oasis.mental_status.collect{|x| MENTAL_STATUS[x]} unless oasis.mental_status.blank?
  end

  def other_mental_status_content
    oasis.other_mental_status
  end

  def prognosis_content
    PROGNOSIS_MAP[oasis.prognosis]
  end

  def nutritional_requirement_content
    oasis.nutritional_requirements_diet
  end

  def allergies
    return if oasis.allergies.nil?
    str = oasis.allergies.select{|attr| attr.blank? == false }.collect{|x| ALLERGIES[x]}.join(", ")
    oasis.other_allergies.blank? ? str : (str + ", #{oasis.other_allergies}")
  end

  def safety_measures_content
    return if oasis.safety_measures.nil?
    str = oasis.safety_measures
    str = str.select{|attr| attr.blank? == false }
    str = str.collect{|s| SAFETY_MEASURES[s] }.join(", ")
    oasis.other_safety_measures.blank? ? str : (str + ", #{oasis.other_safety_measures}")
  end

  def goals_content
    return if oasis.discharge_plans.nil?
    str = "DISCHARGE PLANS: "
    str_arr = []
    str_arr << (oasis.discharge_plans.select{|attr| attr.blank? == false }.collect{|x| DISCHARGE_PLANS[x]} - ["Other"]).join(", ")
    str_arr << "#{oasis.other_discharge_plans}" unless oasis.other_discharge_plans.blank?
    str_arr << "\nDISCUSSED WITH PATIENT: #{YES_NO_MAP[oasis.goals_discussed_with_patient]}" unless oasis.goals_discussed_with_patient.blank?
    str_arr << "\nREHAB POTENTIAL: #{REHAB_POTENTIAL[oasis.rehab_potential]}" unless oasis.rehab_potential.blank?
    content = str_arr.compact.join(", ")
    content.blank? ? nil : (str + content)
  end

  def patient_age
    year = oasis.m0066_pat_birth_dt.split('/').last
    Date.current.year - year.to_i
  end

  def patient_race_or_ethnicity
    ethnicity = []
    attrs = ["m0140_ethnic_ai_an", "m0140_ethnic_asian", "m0140_ethnic_black", "m0140_ethnic_hisp",
     "m0140_ethnic_nh_pi", "m0140_ethnic_white"]
    values = ["American Indian/Alaska Native", "Asian", "Black or African-American",
              "Hispanic or Latino", "Native Hawaiian or Pacific Islander", "White"]
    attrs.each_with_index do |attr, i|
      value = oasis.send(attr)
      ethnicity << values[i] if value.present?
    end
    ethnicity.compact.join("/")
  end

  def patient_gender
    (oasis.m0069_pat_gender == 1) ? "male" : "female"
  end

  def primary_reason_for_home_health
    "#{oasis.primary_reason_for_home_health}"
  end

  def pertinent_history
    return if oasis.pertinent_history_and_outcomes.nil?
    lists = oasis.pertinent_history_and_outcomes.select{|attr| attr.blank? == false }
    str_arr = []
    lists.each do |history|
      history = PERTINENT_HISTORY_MAP[history]
      history = if history == "Cancer"
                  "#{history}: #{oasis.cancer_site}"
                elsif history == "Surgeries"
                  "#{history}: #{oasis.surgeries_type}"
                elsif history == "Other"
                  oasis.pertinent_history_and_outcomes_other
                else
                  history
                end
      str_arr << history
    end
    str_arr.join(", ")
  end

  def risk_factors
    attrs = ["m1036_rsk_smoking", "m1036_rsk_obesity", "m1036_rsk_alcoholism", "m1036_rsk_drugs"]
    values = ["Smoking", "Obesity", "Alcohol dependency", "Drug dependency"]
    if (oasis.m1036_rsk_none == '1' or oasis.m1036_rsk_unknown == '1')
      ""
    else
      str = ", with risk factor(s) of "
      factors = []
      attrs.each_with_index do |attr, i|
        value = oasis.send(attr)
        factors << values[i] if value.present?
      end
      str + factors.compact.join(", ")
    end
  end

  def hospitalization_risk
    attrs = ["m1032_hosp_risk_rcnt_dcln", "m1032_hosp_risk_mltpl_hospztn",
             "m1032_hosp_risk_hstry_falls", "m1032_hosp_risk_5plus_mdctn", "m1032_hosp_risk_frailty"]
    values = ["Recent decline in mental, emotional, or behavioral status", "Multiple hospitalizations (2 or more) in the past 12 months",
    "History of falls (2 or more falls - or any fall with an injury - in the past year)",
    "Taking five or more medications", "Frailty indicators, e.g., weight loss, self-reported exhaustion"]
    if (oasis.m1032_hosp_risk_none_above == '1' or oasis.m1032_hosp_risk_othr == '1')
      ""
    else
      str = "is in risk of being hospitalized due to "
      factors = []
      attrs.each_with_index do |attr, i|
        value = oasis.send(attr)
        factors << values[i] if value.present?
      end
      str + factors.compact.join(", ")
    end
  end

  def homebound_status
    lists = oasis.homebound_reason
    return if lists.nil?
    str1 = "and is homebound for the following reason(s):"
    str = []
    lists = lists.select{|list| list.blank? == false}
    lists.each do |status|
      str << (HOMEBOUND_REASON_MAP[status] == "Other" ? "#{oasis.homebound_reason_other}" : HOMEBOUND_REASON_MAP[status])
    end
    str = str.select{|x| x.blank? == false }.join(", ")
    str.blank? ? (str1 + str) : str
  end

  def patient_discharge_history
    discharge_from = discharge_from_an_inpatient_facility
    return nil if discharge_from.blank?
    discharge_date = inpatient_discharge_date
    str = "The patient was admitted to a #{discharge_from}"
    str = str + " for #{conditions_treated_during_the_inpatient_stay}" unless conditions_treated_during_the_inpatient_stay.blank?
    if discharge_date.blank?
      str + ".\n"
    else
      str + ", and was discharged on #{discharge_date}.\n"
    end
  end

  def discharge_from_an_inpatient_facility
    return nil if oasis.m1000_dc_none_14_da == '1'
    attrs = [ "m1000_dc_ltc_14_da", "m1000_dc_snf_14_da", "m1000_dc_ipps_14_da", "m1000_dc_ltch_14_da", "m1000_dc_irf_14_da",
      "m1000_dc_psych_14_da"]
    values = [ "Long-term nursing facility ( N F )", "Skilled nursing facility ( S N F / T C U )", "Short-stay acute hospital ( I P P S )",
               "Long-term care hospital ( L T C H )", "Inpatient rehabilitation hospital or unit ( I R F )", "Psychiatric hospital or unit" ]

    str = attrs.collect{|a| oasis.send(a) }
    factors = []
    attrs.each_with_index do |attr, i|
      value = oasis.send(attr)
      factors << values[i] if value.present?
    end
    str = factors.compact.join(", ")
    str = str + ", #{oasis.m1000_other_dc}" if oasis.m1000_dc_oth_14_da == '1'
    str
  end

  def conditions_treated_during_the_inpatient_stay
    attrs = ["m1010_14_day_inp1_icd", "m1010_14_day_inp2_icd", "m1010_14_day_inp3_icd", "m1010_14_day_inp4_icd",
     "m1010_14_day_inp5_icd", "m1010_14_day_inp6_icd"]
    icd_codes = attrs.collect{|a| oasis.send(a) }.compact
    icd_codes.collect{|icd_code| ProspectivePaymentSystem::PPSGrouper.get_diagnostic_icd_code_description(icd_code) }.join(", ")
  end

  def inpatient_discharge_date
    oasis.m1005_inp_discharge_dt
  end

  def current_overall_health_status
    HEALTH_STATUS_MAP[oasis.m1034_ptnt_ovral_stus]
  end

  def caregivers
    patient = oasis.treatment.patient
    patient_caregivers = patient.patient_caregivers
    return if patient_caregivers.empty?

    str = "The patient has the following caregiver(s):\n"
    patient = oasis.treatment.patient
    patient_caregivers = patient.patient_caregivers
    caregivers = patient_caregivers.collect{|pc|
      "#{pc.caregiver.full_name}, #{pc.relation_to_patient}, #{pc.caregiver.phone_number}"
    }.join(", ")
    (caregivers.blank? ? nil : (str + caregivers)) + "\n"
  end

  def five_senses
    [eyes, ears, nose, throat, mouth].flatten.compact.join("\n")
  end

  def eyes
    str_arr = []
    str = "EYES: "
    eyes = oasis.eyes
    return if eyes.blank?
    eyes = eyes.reject{|x| x.blank?}
    no_problem = eyes.detect{|e| e == "NP"}
    if no_problem.present?
      str = str + NO_PROBLEM_MAP[no_problem]
    else
      eyes.each do |eye|
        str_arr << if EYES_MAP[eye] == "Other"
                      oasis.eyes_other

                   elsif ["Prosthesis", "Contacts", "Blind"].include?(EYES_MAP[eye])
                     eye_value = "eyes_#{EYES_MAP[eye].downcase}"
                     values = oasis.send(eye_value)
                     unless values.blank?
                        values = values.collect{|v| RIGHT_LEFT_MAP[v] }.join(", ")
                        "#{EYES_MAP[eye]}: #{values}"
                     end
                   elsif EYES_MAP[eye] == 'Infections'
                     "Infections: #{oasis.infections_text}"
                   elsif  EYES_MAP[eye] == "Cataract surgery"
                     "Cataract surgery: site: #{oasis.cataract_surgery_site} #{oasis.cataract_surgery_date}"
                   else
                     EYES_MAP[eye]
                   end
      end

      str = str + "#{str_arr.compact.join(', ')}"
      unless oasis.impaired_vision.blank?
        str = str +  ", Impaired vision interferes/impacts function safety as follows:"
        str = str + oasis.impaired_vision
      end
    end
    (str == "EYES: ") ? nil : str
  end

  def ears
    str_arr = []
    str = "EARS: "
    ears = oasis.ears
    return if ears.blank?
    ears = ears.reject{|x| x.blank?}
    no_problem = ears.detect{|e| e == "NP"}
    if no_problem.present?
      str = str + NO_PROBLEM_MAP[no_problem]

    else
      ears.each do |ear|
        str_arr << if EARS_MAP[ear] == "Other"
                     oasis.ears_other
                   elsif ["HOH", "Deaf", "Hearing aid", "Tinnitus"].include?(EARS_MAP[ear])
                     items = oasis.send(EARS_MAP[ear].downcase.split().join('_'))
                     items = items.select{|x| x }
                     content = items.collect{|v| RIGHT_LEFT_MAP[v]}.join(", ")
                     "#{EARS_MAP[ear]}: #{content}" unless content.blank?
                   else
                     EARS_MAP[ear]
                   end
      end
      str = str + str_arr.compact.join(", ")
    end
    (str == "EARS: ") ? nil : str
  end

  def nose
    str_arr = []
    str = "NOSE: "
    nose = oasis.nose
    return if nose.nil?
    nose = nose.reject{|x| x.blank?}
    no_problem = nose.detect{|e| e == "NP"}
    if no_problem.present?
      str = str + NO_PROBLEM_MAP[no_problem]
    else
      nose.each do |problem|
        str_arr << if NOSE_MAP[problem] == "Other"
                     oasis.nose_other
                   else
                     NOSE_MAP[problem]
                   end
      end
      str = str + str_arr.compact.join(", ")
    end
    (str == "NOSE: ") ? nil : str
  end

  def throat
    str_arr = []
    str = "THROAT: "
    throat = oasis.throat
    return if throat.nil?
    throat = throat.reject{|x| x.blank?}
    no_problem = throat.detect{|e| e == "NP"}
    if no_problem.present?
      str = str + NO_PROBLEM_MAP[no_problem]
    else
      throat.each do |problem|
        str_arr << if THROAT_MAP[problem] == "Other"
                     oasis.other_throat
                   else
                     THROAT_MAP[problem]
                   end
      end
      str = str + str_arr.join(", ")
    end
    (str == "THROAT: ") ? nil : str
  end

  def mouth
    str_arr = []
    str = "MOUTH: "
    mouth = oasis.mouth
    return if mouth.nil?
    mouth = mouth.reject{|x| x.blank?}
    no_problem = mouth.detect{|e| e == "NP"}
    if no_problem.present?
      str = str + NO_PROBLEM_MAP[no_problem]
    else
      mouth.each do |problem|
        str_arr << if MOUTH_MAP[problem] == "Other"
                     oasis.mouth_other
                   elsif ["Dentures"].include?(MOUTH_MAP[problem])
                     items = oasis.send(MOUTH_MAP[problem].downcase.split().join('_'))
                     content = items.select{|x| x }.collect{|x| DENTURES_MAP[x]}.join(", ")
                     "#{MOUTH_MAP[problem]}: #{content}" unless content.blank?
                   else
                     MOUTH_MAP[problem]
                   end
      end
      str = str + str_arr.join(", ")
    end
    (str == "MOUTH: ") ? nil : str
  end

  def cardiopulmonary
    [breath_sounds, cough, dyspnea, heart_sounds].compact.select{|attr| attr.blank? == false }.join("; ")
  end

  def breath_sounds
    str = "BREATH SOUNDS: "
    sounds = oasis.breath_sounds
    return if sounds.blank?
    sounds = sounds.reject{|x| x.blank?}
    no_problem = sounds.detect{|e| e == "NP"}
    if no_problem.present?
      str = str + NO_PROBLEM_MAP[no_problem]
    else
      str_arr = []
      str_arr << "Anterior Right: #{oasis.anterior_right}" unless oasis.anterior_right.blank?
      str_arr << "Anterior Left: #{oasis.anterior_left}" unless oasis.anterior_left.blank?

      str_arr << "Posterior Right Upper: #{oasis.posterior_right_upper}" unless oasis.posterior_right_upper.blank?
      str_arr << "Posterior Right Lower: #{oasis.posterior_right_lower}" unless oasis.posterior_right_lower.blank?
      str_arr << "Posterior Left Upper: #{oasis.posterior_left_upper}" unless oasis.posterior_left_upper.blank?
      str_arr << "Posterior Left Lower: #{oasis.posterior_left_lower}" unless oasis.posterior_left_lower.blank?
      str_arr << "O2@: #{oasis.oxygen_lpm} LPM" unless oasis.oxygen_lpm.blank?
      str_arr << "O2 Saturation: #{oasis.oxygen_saturation} %" unless oasis.oxygen_saturation.blank?
      str_arr << "Trach size/type: #{oasis.trach_size} " unless oasis.trach_size.blank?
      str_arr << "Manage by: #{CAREGIVERS_LIST[oasis.who_manages]} #{oasis.who_manages_text}" unless oasis.who_manages.blank?
      str_arr << "Intermittent treatments: #{intermittent_treatments_display} " unless intermittent_treatments_display.blank?
      str + str_arr.join(", ")
    end
    (str == "BREATH SOUNDS: ") ? nil : str
  end

  def intermittent_treatments_display
    return nil if oasis.intermittent_treatments.blank?
    intermittent_treatments = YES_NO_MAP[oasis.intermittent_treatments]
    str = if intermittent_treatments == "No"
            intermittent_treatments
          else
            if oasis.intermittent_treatments_explain.blank?
              intermittent_treatments
            else
              intermittent_treatments + ", #{oasis.intermittent_treatments_explain}"
            end
          end
  end

  def cough
    return if oasis.breath_sounds.nil?
    return nil unless oasis.breath_sounds.collect{|b| BREATH_SOUNDS[b]}.include?("Cough")
    str = "COUGH: "
    if YES_NO_MAP[oasis.cough] == "No"
      str = str + "No"
    else
      str = str + "Yes"
      str = str + ", #{PRODUCTIVE[oasis.productive]}" unless oasis.productive.blank?
      str = str + ", #{oasis.productive_describe}" unless oasis.productive_describe.blank?
    end
    str
  end

  def dyspnea
    return if oasis.breath_sounds.nil?
    return nil unless oasis.breath_sounds.collect{|b| BREATH_SOUNDS[b]}.include?("Dyspnea")
    str = "DYSPNEA: "
    str = str + oasis.dyspnea.collect{|x| DYSPNEA[x]}.join(", ") unless oasis.dyspnea.blank?
    str = str +", "+oasis.dyspnea_comments unless oasis.dyspnea_comments.blank?
    str
  end

  def heart_sounds
    str = "HEART SOUNDS: "
    str_arr = []
    heart_sounds = oasis.heart_sounds
    return if heart_sounds.blank?
    heart_sounds.compact!
    no_problem = heart_sounds.detect{|e| e == "NP"}
    if no_problem.present?
      str = str + NO_PROBLEM_MAP[no_problem]
    else
      heart_sounds.each do |field|
        field = HEART_SOUNDS[field]
        if field == "Pacemaker"
          string_display = []
            string_display << "Date: #{oasis.pacemaker_date}" unless oasis.pacemaker_date.blank?
            string_display << "Last date checked: #{oasis.pacemaker_last_date_checked}" unless oasis.pacemaker_last_date_checked.blank?
            string_display << "Type: #{oasis.pacemaker_type}" unless oasis.pacemaker_type.blank?
          str_arr << (string_display.present? ? ("#{field}:" + string_display.join(", ")) : "#{field}")
        elsif field == "Chest Pain"
          string_display = []
          chest_pain = oasis.chest_pain.reject{|x| x.blank?}
          string_display << chest_pain.collect{|x| CHEST_PAIN[x]}.join(", ")  unless chest_pain.blank?
          string_display << "Associated_with: #{associated_with_display}" unless associated_with_display.blank?
          str_arr << (string_display.present? ? "#{field}: #{string_display.join(", ")}" : field)
        elsif field == "Edema"
          str_arr << (edema_display.present? ? "#{field}: #{edema_display}" : field)
        elsif field == "Capillary refill"
          str_arr << (oasis.capillary_refill.present? ? "#{field}: #{CAPILLARY_REFILL[oasis.capillary_refill]}" : field)
        elsif field == "Disease Management Problems"
          str_arr << (oasis.disease_management_explain.present? ? "#{field}: #{oasis.disease_management_explain}" : field)
        else
          str_arr << field unless field.blank?
        end
      end
      str += str_arr.join(", ")
    end
    (str == "HEART SOUNDS: ") ? nil : str
  end

  def associated_with_display
    list = []
    list << oasis.associated_with.collect{|x| ASSOCIATED_WITH[x]}.join(",") unless oasis.associated_with.blank?
    list << "Frequency/duration: #{oasis.associated_with_frequency}" unless oasis.associated_with_frequency.blank?
    list << "How relieved: #{oasis.associated_with_how_relieved}" unless oasis.associated_with_how_relieved.blank?
    list =  list.join(", ")
    list
  end

  def edema_display
    list = []
    edema_list = oasis.edema
    edema_list.each do |field|
      field = EDEMA[field]
      if field == "Pedal"
        list << (oasis.pedal.present? ? "Pedal: #{oasis.pedal.collect{|x| RIGHT_LEFT_MAP[x]}.join(", ")}" : field)
      elsif field == "Dependent"
         list << (oasis.edema_dependent.present? ? "Dependent: #{oasis.edema_dependent}" : field)
      else
        list << field
      end
      list

    end

    list << if EDEMA_PITTING[oasis.edema_pitting] == "Pitting"
              "Pitting: #{oasis.pitting.join(", ")}"
            else
              EDEMA_PITTING[oasis.edema_pitting]
            end
     list.join(", ")
  end

  def gastrointestinal
    str = "GASTROINTESTINAL: "
    items = [elimination, abdomen, miscellaneous]
    items = items.reject{|x| x.blank? }
    return if items.blank?
    str + items.join("; ")
  end

  def elimination
    str = ""
    eliminations = oasis.elimination
    unless eliminations.blank?
      eliminations = eliminations.select{|e| e }
      eliminations.compact!
      str_arr = []
      if oasis.elimination_no_problem == "NP"
        str_arr << "No Problem"
      else
        eliminations.each do |elimination|
          elimination = ELIMINATION[elimination]
          if elimination == "Last BM"
            str_arr << "Last BM: #{oasis.elimination_last_bm}"
          elsif elimination == "Frequency of stools"
            str_arr << (oasis.frequency_of_stools.blank? ? elimination : "Frequency of stools: #{oasis.frequency_of_stools}")
            str_arr << "Bowel regime/program: #{oasis.bowel_regime_program}" unless oasis.bowel_regime_program.blank?
          elsif elimination == "Laxative/Enema use"
            selected_value = LAXATIVE_ENEMA_USE[oasis.laxative_enema_use]
            res = if selected_value== "Other"
                    oasis.other_laxative_enema_use.blank? ? selected_value : "Other: #{oasis.other_laxative_enema_use}"
                  else
                    selected_value
                  end
            str_arr << (res.blank? ? elimination : "Laxative/Enema use: #{res}")
          elsif elimination == "Incontinence"
            str_arr << (oasis.incontinence.blank? ? elimination : "Incontinence: #{oasis.elimination_incontinence}")
          elsif elimination == "Diapers"
            str_arr << (oasis.elimination_diapers.blank? ? elimination : "Diapers: #{oasis.elimination_diapers}")
          elsif elimination == "Ileostomy"
            str_arr << (oasis.skin_arround_stoma.blank? ? elimination : "Ileostomy/Colostomy site: #{oasis.skin_arround_stoma}")
          else
            str_arr << elimination
          end
        end
        selected_value = CAREGIVERS_LIST[oasis.elimination_ostomy_care_managed_by]
        res = if selected_value == "Other"
                oasis.elimination_ostomy_care_other.blank? ? selected_value : "Other: #{oasis.elimination_ostomy_care_other}"
              else
                selected_value
              end
        str_arr << "Ostomy care managed by: #{res}" unless oasis.elimination_ostomy_care_managed_by.blank?
        str_arr << "#{oasis.other_elimination}" unless oasis.other_elimination.blank?
      end
      str = str_arr.blank? ? nil : (str +  "Elimination: #{str_arr.join(', ')}")
    end
    str
  end

  def abdomen
    str = ""
    abdomens = oasis.abdomen
    unless abdomens.blank?
      abdomens = abdomens.select{|a| a }
      abdomens.compact!
      str_arr = []
      if oasis.abdomen_no_problem == 'NP'
        str_arr << "No Problem"
      else
        abdomens.each do |abdomen|
          if ABDOMEN_MAP[abdomen] == "Abdominal"
            str_arr << (oasis.girth.present? ? "Abdominal: #{oasis.girth}" : "Abdominal")
          elsif ABDOMEN_MAP[abdomen] == "Other"
            str_arr << "#{oasis.abdomen_other}" unless oasis.abdomen_other.blank?
          elsif ABDOMEN_MAP[abdomen] == "Bowel sounds"
            str_arr << "Bowel sounds: #{ BOWEL_SOUNDS_MAP[oasis.bowel_sounds] }" unless oasis.bowel_sounds.blank?
            str_arr << "#{oasis.bowel_sounds_x_quadrants} quadrants" unless oasis.bowel_sounds_x_quadrants.blank?
          else
            str_arr << ABDOMEN_MAP[abdomen]
          end
        end
        str_arr << "#{oasis.bowel_sounds_other_text}" unless oasis.bowel_sounds_other.blank?
      end
      str_arr = str_arr.select{|x| x.blank? == false }
      str = str_arr.blank? ? nil : (str + "Abdomen: #{str_arr.join(', ')}")
    end
    str
  end

  def miscellaneous
    str = ""
    miscellaneous = oasis.miscellaneous
    unless miscellaneous.nil?
      miscellaneous = miscellaneous.select{|a| a }
      miscellaneous.compact!
      str_arr = []
      miscellaneous.each do |mis|
        mis = DMESUPPLIES_MISCELLANEOUS[mis]
        if mis == "Feeding tube"
          str_arr << "Type: #{oasis.feeding_tube_type}" unless oasis.feeding_tube_type.blank?
          str_arr << "Size: #{oasis.feeding_tube_size}" unless oasis.feeding_tube_size.blank?
        else
          str_arr << mis
        end
      end
      str_arr << "#{oasis.other_miscellaneous}" unless oasis.other_miscellaneous.blank?
    end
    str = str_arr.blank? ? nil : (str + "MISCELLANEOUS: #{str_arr.join(', ')}")
    str
  end

  def genitourinary
    str = "GENITOURINARY: "
    str_arr = []
    if oasis.genitourinary_no_problem == "No Problem"
      str_arr << "No Problem"
    else
      genitourinary = oasis.genitourinary
      return nil if genitourinary.nil?
      genitourinary = genitourinary.select{|g| g.blank? == false }
      genitourinary.each do |gen|
        gen = GENITOURINARY[gen]
        if gen == "Incontinence"
          str_arr << (oasis.incontinence_details.blank? ? gen : "#{gen}: #{oasis.incontinence_details}")
        elsif gen == "Diapers"
          str_arr << (oasis.genitourinary_diapers.blank? ? gen : "#{gen}: #{oasis.genitourinary_diapers}")
        elsif gen == "Other"
          str_arr << (oasis.other_genitourinary.blank? ? gen : "#{gen}: #{oasis.other_genitourinary}")
        else
          str_arr << gen
        end
      end
      str_arr << "Urinary catheter Type #{oasis.urinary_catheter_type}" unless oasis.urinary_catheter_type.blank?
      str_arr << "Urinary catheter date last changed #{oasis.urinary_catheter_date}" unless oasis.urinary_catheter_date.blank?
      str_arr << "Foley inserted on #{oasis.foly_inserted_date}" unless oasis.foly_inserted_date.blank?
      str_arr << "French #{oasis.french}" unless oasis.french.blank?
      unless oasis.inflated_balloon_with.blank?
        s = "Inflated balloon with #{oasis.inflated_balloon_with} ml"
        s += " #{GENITOURINARY_DIFFICULTY[oasis.genitourinary_difficulty]}" unless oasis.genitourinary_difficulty.blank?
        str_arr << s
      end
      str_arr << "Patient tolerated procedure well #{YES_NO_MAP[oasis.tolerated_procedure_well]}" unless oasis.tolerated_procedure_well.blank?

      irrigation_arr = []
      irrigation_arr << "Type: #{oasis.irrigation_solution_type}" unless oasis.irrigation_solution_type.blank?
      irrigation_arr << "Amount: #{oasis.irrigation_solution_amount} ml" unless oasis.irrigation_solution_amount.blank?
      irrigation_arr << "Frequency: #{oasis.irrigation_solution_frequency}" unless oasis.irrigation_solution_frequency.blank?
      irrigation_arr << "Returns: #{oasis.irrigation_solution_returns}" unless oasis.irrigation_solution_returns.blank?
      str_arr << "Irrigation solution #{irrigation_arr.join(', ')}" unless irrigation_arr.blank?

      color = GENITOURINARY_COLOR[oasis.genitourinary_color]
      color = oasis.genitourinary_color_other if color == "Other"
      str_arr << "Color: #{color}" unless color.blank?

      str_arr << "Clarity: #{GENITOURINARY_CLARITY[oasis.genitourinary_clarity]}" unless oasis.genitourinary_clarity.blank?
      str_arr << "Odor: #{YES_NO_MAP[oasis.genitourinary_odor]}" unless oasis.genitourinary_odor.blank?
      urostomy = GENITOURINARY[oasis.urostomy]
      res = if urostomy.present?
              (oasis.genitourinary_urostomy.present? ? "Urostomy: #{oasis.genitourinary_urostomy}" : urostomy)
            end
      str_arr << res unless res.blank?
      unless oasis.ostomy_care_managed_by.blank?
        ostomy_care = ((oasis.ostomy_care_managed_by == "OTH") ? "Other: #{oasis.other_ostomy_care_managed_by}" : CAREGIVERS_LIST[oasis.ostomy_care_managed_by])
        str_arr << "Ostomy care managed by "+ ostomy_care unless ostomy_care.blank?
      end

    end

    str + str_arr.join(", ") if str_arr.present?
  end

  def genitalia
    str_arr = []
    no_problem = oasis.genitalia_no_problem == "NP"
    if no_problem.present?
      str_arr << "No Problem"
    else
      genitalia = oasis.genitalia
      return if genitalia.blank?
      genitalia = genitalia.select{|g| g.blank? == false }
      genitalia.each do |field|
        field = GENITALIA[field]
        if field == "Drainage"
          str_arr << (oasis.discharge_drainage.present? ? "Drainage: #{oasis.discharge_drainage}" : field)
        elsif field == "Prostate problem"
          list = []
          prostate_problem = oasis.prostate_problem.reject{|x| x.blank?}
          list << "#{prostate_problem.join(",")}" unless prostate_problem.blank?
          list << "Date: #{oasis.bph_turp_date}" unless oasis.bph_turp_date.blank?
          str_arr <<  (list.present? ? "Prostate problem: #{list.join(", ")}" : field)
        elsif field == "Self-testicular exam"
          str_arr << (oasis.self_testicular_exam_freq.present? ? "Self-testicular exam: #{oasis.self_testicular_exam_freq}" : field)
        elsif field == "Hysterectomy"
          list = []
          list << "Date: #{oasis.hysterectomy_date}"  unless oasis.hysterectomy_date.blank?
          list << "Date last PAP: #{oasis.hysterectomy_last_date}" unless oasis.hysterectomy_last_date.blank?
          list << "Results: #{oasis.hysterectomy_results}" unless oasis.hysterectomy_results.blank?
          str_arr << (list.present? ? "Hysterectomy: #{list.join(", ")}" : field)
        elsif field == "Breast self-exam"
          str_arr << (oasis.breast_self_exam_freq.present? ? "Breast self-exam: #{oasis.breast_self_exam_freq}" : field)
        elsif field == "Discharge:R/L"
          genitalia_discharge = oasis.genitalia_discharge.reject{|x| x.blank?}
          str_arr << (genitalia_discharge.present? ? "Discharge: #{genitalia_discharge.collect{|x| RIGHT_LEFT_MAP[x]}.join(", ")}" : field)
        elsif field == "Mastectomy"
          list = []
          mastectomy = oasis.mastectomy.reject{|x| x.blank?}
          list << mastectomy.collect{|x| RIGHT_LEFT_MAP[x]}.join(", ") unless mastectomy.blank?
          list << "Date:  #{oasis.mastectomy_date}" unless oasis.mastectomy_date.blank?
          str_arr << (list.present? ? "Mastectomy: #{list.join(", ")}" : field)
        elsif field == "Other"
          str_arr << (oasis.genitalia_other.present? ? "Other: #{oasis.genitalia_other}" : field)
          str_arr
        else
          str_arr << field
        end
      end
    end
    str = str_arr.present? ? "GENITALIA: #{str_arr.join(', ')}" : nil
    str
  end

  def pain
    str1 = "PAIN:"
    str_arr = []
    (1..6).each do |num|
      location = oasis.send("pain_location#{num}")
      onset = oasis.send("pain_onset#{num}")
      worst = oasis.send("pain_worst#{num}")
      best = oasis.send("pain_best#{num}")
      aggravating_factors = oasis.send("pain_aggravating_factors#{num}")
      relieving_factors = oasis.send("pain_relieving_factors#{num}")

      next if location.blank?
      str = "#{num}. #{location}"
      str += ", Onset #{onset}" unless onset.blank?
      if (worst != "/10" and best != "/10")
        worst_value = worst.split("/").first
        best_value = best.split("/").first
        str += ", #{best_value}-#{worst_value}/10 scale"
      end
      str += ", #{aggravating_factors} makes pain worse" unless aggravating_factors.blank?
      str += ", #{relieving_factors} makes pain better" unless relieving_factors.blank?

      str_arr << str
    end
    pains_str = str_arr.join("\n")
    (pains_str.size > 0) ? (str1 + pains_str) : nil
  end

  def endocrine
    str_arr = []
    endocrine = oasis.endocrine
    return nil if endocrine.nil?
    endocrine = endocrine.select{|x| x.blank? == false}
    no_problem = endocrine.detect{|x| x == "NP" }
    if no_problem.present?
      str_arr << "No Problem"
    else
      endocrine.each do |ec|
        if ec == '1'
          str_arr << (oasis.diabetes.blank? ? ENDOCRINE[ec] : "#{ENDOCRINE[ec]}: #{DIABETES[oasis.diabetes]}")
          str_arr << "Date of onset: #{oasis.diabetes_date}" unless oasis.diabetes_date.blank?
        elsif ec == '2'
          str_arr << (oasis.other_diet_control.blank? ? ENDOCRINE[ec] : "#{ENDOCRINE[ec]}: #{oasis.other_diet_control}")
        elsif ec == '3'
          s = if oasis.hypoglycemia.blank?
                ENDOCRINE[ec]
              else
                 "#{ENDOCRINE[ec]}:" + ' ' + oasis.hypoglycemia.select{|x| x.blank? == false }.collect{|x| HYPOGLYCEMIA[x] }.join(", ")
               end
          unless oasis.a1c.blank?
            s += ", A1c: #{oasis.a1c} %"
            s += ": #{oasis.a1c_found.select{|x| x.blank? == false }.collect{|x| A1C[x]}.join(', ')}" unless oasis.a1c_found.blank?
          end
          unless oasis.bs_weight.blank?
            s += ", BS: #{oasis.bs_weight} %"
            s += ", Date: #{oasis.bs_date}" unless oasis.bs_date.blank?
            s += ", Time: #{oasis.bs_time}" unless oasis.bs_time.blank?
            s += ", #{oasis.bs.select{|x| x.blank? == false }.collect{|x| BS[x]}.join(', ')}" unless oasis.bs.blank?
          end
          str_arr << s
        elsif ec == '4'
          s =  (oasis.insulin_dose_frequency.blank? ? ENDOCRINE[ec] : "#{ENDOCRINE[ec]}: #{oasis.insulin_dose_frequency}")
          s += ", On insulin since: #{oasis.insulin_since}" unless oasis.insulin_since.blank?
          unless oasis.endocrine_administered_by.blank?
            endocrine_administered = ((oasis.endocrine_administered_by == "OTH") ? oasis.endocrine_administered_by_other : CAREGIVERS_LIST[oasis.endocrine_administered_by])
            s +=", Administered by: " + endocrine_administered unless endocrine_administered.blank?
          end
          str_arr << s
        elsif ec == '5'
          str_arr << if oasis.hyperglycemia.blank?
                       ENDOCRINE[ec]
                     else
                       "#{ENDOCRINE[ec]}:" + ' ' + oasis.hyperglycemia.select{|x| x.blank? == false }.collect{|x| HYPERGLYCEMIA[x]}.join(", ")
                     end
        elsif ec == '6'
          s = oasis.blood_sugar_ranges.blank? ? ENDOCRINE[ec] : "#{ENDOCRINE[ec]}: #{oasis.blood_sugar_ranges}"
          s += ', ' + BLOOD_SUGAR_REPORT[oasis.blood_sugar_report] unless oasis.blood_sugar_report.blank?
          unless oasis.monitored_by.blank?
            monitored_by = ((oasis.monitored_by == "OTH") ? oasis.other_monitored_by : CAREGIVERS_LIST[oasis.monitored_by])
            s += ', Monitored By ' + monitored_by unless monitored_by.blank?
          end
          s += ", Frequency of manitoring: #{oasis.frequency_of_monitoring}" unless oasis.frequency_of_monitoring.blank?
          s += ", Competency with use of Glucometer: #{oasis.competency}" unless oasis.competency.blank?
          str_arr << s
        elsif ec == '9'
          s = "Disease Management Problems"
          s += ": #{oasis.disease_mgmt_text}" unless oasis.disease_mgmt_text.blank?
          str_arr << s
        elsif ec == "10"
          s = "Enlarged Thyroid"
          s += ": #{oasis.disease_effect.select{|x| x.blank? == false }.collect{|x| ENDOCRINE_MISCELLANEOUS[x] }.join(', ')}"
          s += ", #{oasis.other_disease_effect}" unless oasis.other_disease_effect.blank?
          str_arr << s
        elsif ec == "11"
          str_arr << (oasis.other_disease_effect.blank? ? ENDOCRINE[ec] : "#{ENDOCRINE[ec]}: #{oasis.other_disease_effect}") unless oasis.other_disease_effect.blank?
        elsif ec == "12"
          secondary = oasis.secondary.select{|x| x.blank? == false }
            if secondary.present?
              list  = []
              secondary.each do |el|
                if (SECONDARY[el] == "Other")
                  list << (oasis.secondary_other.present? ? "Other: #{oasis.secondary_other}" : "Other")
                else
                  list << SECONDARY[el]
                end
              end
            end
             str_arr << (list.present? ?  "#{ENDOCRINE[ec]}: #{list.join(', ')}": ENDOCRINE[ec])
        else
          str_arr << ENDOCRINE[ec]
        end
      end
    end
    str =  " ENDOCRINE/HEMATOLOGY: #{str_arr.join(", ")} " unless str_arr.blank?

    supplies = oasis.diabetic_supplies - ['3']
    diabetic_supplies = supplies.select{|x| x.blank? == false }.collect{|x| DIABETIC_SUPPLIES[x]}
    diabetic_supplies << oasis.other_diabetic_supplies unless oasis.other_diabetic_supplies.blank?
    unless str.blank?
      (diabetic_supplies.size > 0) ? (str + ", Diabetic: #{diabetic_supplies.join(", ")}") : str
    end

  end

  def integumentary
    str = []
    str_arr = []
    integumentaries = oasis.integumentary
    return if integumentaries.nil?
    integumentaries = integumentaries.select{|x| x }
    if integumentaries.include?("NP")
      str << "No Problem"
    else
      integumentaries.each do |integumentary|
        integumentary = INTEGUMENTARY_MAP[integumentary]
        if integumentary == "Turgor"
          str_arr << "Turgor: #{TURGOR[oasis.turgor]}" unless oasis.turgor.blank?
        elsif integumentary == "Technique"
          wound_care_technique = oasis.wound_care_technique.reject{|x| x.blank?}
          items = wound_care_technique.collect{|x| WOUND_CARE_TECHNIQUE_MAP[x]} if wound_care_technique.present?
          items.select{|x| x }
          str_arr << items.blank? ? integumentary : "#{integumentary}: #{items.join(', ')}"
        elsif integumentary == "Other"
          str_arr << oasis.other_integumentary unless oasis.other_integumentary.blank?
        else
          str_arr << integumentary unless integumentary.blank?
        end
      end
      str_arr = str_arr.select{|attr| attr}
      str << str_arr.compact.join(", ")
    end

    str << "Wound care done during this visit: #{YES_NO_MAP[oasis.wound_care]}" unless oasis.wound_care.blank?
    str << "Location(s) wound site: #{oasis.wound_care_location}" unless oasis.wound_care_location.blank?
    unless oasis.soiled_dressing.blank?
      text_arr = []
      sd = SOILED_DRESSING_MAP[oasis.soiled_dressing]
      text_arr << if sd == "Caregiver"
                "Caregiver: #{oasis.soiled_dressing_cargiver}"
              elsif sd == "Other"
                oasis.other_soiled_dressing
              else
                sd
              end
      content = text_arr.compact.join(', ')
      str << "Soiled dressing removed by: #{content}" unless content.blank?
    end
    items = oasis.wound_care_technique.collect{|x| WOUND_CARE_TECHNIQUE_MAP[x]}.select{|x| x }
    str << "Technique: #{items.join(', ')}" unless items.blank?
    str << "Wound cleaned with: #{oasis.wound_cleaned_with}" unless oasis.wound_cleaned.blank?
    str << "Wound irrigated with: #{oasis.wound_irrigated_with}" unless oasis.wound_irrigated.blank?
    str << "Wound packed with: #{oasis.wound_packed_with}" unless oasis.wound_packed.blank?
    str << "Wound dressing applied: #{oasis.wound_dressing_applied}" unless oasis.wound_dressing.blank?
    str << "Patient tolerated procedure well: #{YES_NO_MAP[oasis.patient_tolerate]}" unless oasis.patient_tolerate.blank?
    str << "#{oasis.wound_care_comments}" unless oasis.wound_care_comments.blank?
    str = str.select{|x| x.blank? == false }
    "INTEGUMENTARY: "+ str.join(", ") if str.size > 1
  end

  def neurologic
    list = [neuro_emotional_behavioural_display, psychosocial_display ].compact.join(", ")
    return if list.blank?
    "NEUROLOGIC: " + list
  end

  def psychosocial_display
    str_arr = []
    str_arr << oasis.psychosocial_primary_language unless oasis.psychosocial_primary_language.blank?
    psychosocials =  oasis.psychosocial
    return if psychosocials.blank?
    psychosocials.compact!
    psychosocials.each do |field|
      field_value = PSYCHOSOCIAL[field]
      if field == "2"
        str_arr << (oasis.psychosocial_interpreter.present? ? "#{field_value}: #{oasis.psychosocial_interpreter}" : field_value)
      elsif field == "3"
        learning_barrier = oasis.learning_barrier.reject{|x| x.blank?}
        str_arr << (learning_barrier.present? ? "#{field_value}: #{learning_barrier.collect{|x| LEARNING_BARRIERS[x]}.join(", ")}" : field_value)
      elsif field == "6"
        list  = []
        list << "Explain: #{oasis.spiritual_cultural_explain}" unless oasis.spiritual_cultural_explain.blank?
        list << "Spiritual Resource: #{oasis.spiritual_resource}" unless oasis.spiritual_resource.blank?
        list << "Phone No: #{oasis.psychosocial_phone_number}" unless oasis.psychosocial_phone_number.blank?
        str_arr << (list.present? ? "#{field_value}: #{list.join(", ")}" : field_value)
      elsif field == "7"
        list  = []
        list << SLEEP_OR_REST[oasis.sleep_rest] unless oasis.sleep_rest.blank?
        list << "Explain: #{oasis.sleep_rest_explain}" unless oasis.sleep_rest_explain.blank?
        str_arr << (list.present? ? "#{field_value}: #{list.join(", ")}" : field_value)
      elsif field == "8"
        inappropriate_responses = oasis.inappropriate_responses.reject{|x| x.blank?}
        str_arr << (inappropriate_responses.present? ? "#{field_value}: #{inappropriate_responses.collect{|x| INAPPROPRIATE_RESPONSES[x]}.join(", ")}" : field_value)
      elsif field == "16"
        list  = []
        list << DEPRESSED[oasis.depressed] unless oasis.depressed.blank?
        list << "Treatment: #{oasis.psychosocial_treatment}" unless oasis.psychosocial_treatment.blank?
        str_arr << (list.present? ? "#{field_value}: #{list.join(", ")}" : field_value)
      elsif field == "17"
        inability_to_cope = oasis.inability_to_cope.reject{|x| x.blank?}
        str_arr << (inability_to_cope.present? ? "#{field_value}: #{inability_to_cope.collect{|x| INABILITY_TO_COPE[x]}.join(", ")}" : field_value)
      elsif field == "18"
        list = []
        evidence = oasis.evidence.reject{|x| x.blank?}
        list << evidence.collect{|x| EVIDENCE[x]}.join(", ") unless evidence.blank?
        list << "Describe: #{oasis.psychosocial_describe}" unless oasis.psychosocial_describe.blank?
        str_arr << (list.present? ? "#{field_value}: #{list.join(", ")}" : field_value)
      else
        str_arr << field_value unless field_value.blank?
      end
      str_arr
    end
    str_arr << "Education Level: #{oasis.psychosocial_education_level}" unless oasis.psychosocial_education_level.blank?
    str_arr << "Comments: #{oasis.psychosocial_comments}" unless oasis.psychosocial_comments.blank?
    str = str_arr.present? ? "Psychosocial: " + str_arr.join(", ") : nil
    str
  end


  def neuro_emotional_behavioural_display
    neuro_emotions = oasis.neuro_emotional_behaviour
    return if neuro_emotions.blank?
    neuro_emotions.compact!
    no_problem = neuro_emotions.detect{|x| x == "NP"}
    str_arr = []
    if no_problem.present?
      str_arr << "No Problem"
    else
      neuro_emotions.each do |field|
        field_value = NEURO_EMOTIONAL_BEHAVIOUR[field]
        if field == "1"
          list  = []
          list << "Location: #{oasis.headache_location}" unless oasis.headache_location.blank?
          list << "Frequency: #{oasis.headache_frequency}" unless oasis.headache_frequency.blank?
          str_arr << (list.present? ? "#{field_value}: #{list.join(', ')}" : field_value)
        elsif field == "3"
          pupils = oasis.un_equal_pupils.reject{|x| x.blank?}
          str_arr << (pupils.present? ? "#{field_value}: #{pupils.collect{|x| RIGHT_LEFT_MAP[x]}.join(", ")}" : field_value)
        elsif field == "4"
          aphasia = oasis.aphasia.reject{|x| x.blank?}
          str_arr << (aphasia.present? ? "#{field_value}: #{aphasia.collect{|x| APHASIA[x] }.join(', ')}" : field_value)
        elsif field == "5"
          list  = []
          list << oasis.motor_change.collect{|x| MOTOR_CHANGE[x] }.compact.join(", ") unless oasis.motor_change.blank?
          list << "Site: #{oasis.motor_change_site}" unless oasis.motor_change_site.blank?
          str_arr << (list.present? ? "#{field_value}: #{list.join(', ')}" : field_value)
        elsif field == "6"
          dominant_side = oasis.dominant_side.reject{|x| x.blank?}
          str_arr << (dominant_side.present? ? "#{field_value}: #{dominant_side.collect{|x| RIGHT_LEFT_MAP[x]}.join(', ')}" : field_value)
        elsif field == "7"
          list  = []
          weakness_ue_le = oasis.weakness_ue_le.reject{|x| x.blank?}
          list << weakness_ue_le.join(", ") unless weakness_ue_le.blank?
          list << "Location: #{oasis.weakness_location}" unless oasis.weakness_location.blank?
          str_arr << (list.present? ? "#{field_value}: #{list.join(', ')}" : field_value)
        elsif field == "8"
          list  = []
          tremors = oasis.tremors.reject{|x| x.blank?}
          list << tremors.collect{|x| TREMORS[x]}.join(", ") unless tremors.blank?
          list << "Site: #{oasis.termors_site}" unless oasis.termors_site.blank?
          str_arr << (list.present? ? "#{field_value}: #{list.join(', ')}" : field_value)
        elsif field == "9"
          stuporous = oasis.stuporous.reject{|x| x.blank?}
          str_arr << (stuporous.present? ? "#{field_value}: #{stuporous.collect{|x| STUPOROUS[x]}.join(', ')}" : field_value)
        elsif field == "10"
          list = []
          list <<  oasis.psychotropic_drug unless oasis.psychotropic_drug.blank?
          list << "Dose/Frequency: #{oasis.dose_frequency}" unless oasis.dose_frequency.blank?
          str_arr << (list.present? ?  "#{field_value}: #{list.join(', ')}": field_value)
        elsif field == "11"
          str_arr << (oasis.neuro_emotional_behaviour_other.present? ? "#{field_value}: #{oasis.neuro_emotional_behaviour_other}" : field_value)
        else
          str_arr << field_value unless field_value.blank?
        end
      end
      str_arr
    end
    str_arr << "Hand grips: #{oasis.hand_grips_equal_or_unequal}" unless oasis.hand_grips_equal_or_unequal.blank?
    str_arr << "Strong / Weak: #{oasis.hand_grips_strong_or_weak}" unless oasis.hand_grips_strong_or_weak.blank?
    str = str_arr.present? ? "Neuro/Emotional/Behavioural: " + str_arr.join(", ") : nil
    str
  end

  def extremities
    musculoskeletal_display
  end


  def musculoskeletal_display
    musculoskeletals = oasis.musculoskeletal
    return if musculoskeletals.blank?
    musculoskeletals.compact!
    no_problem = musculoskeletals.detect{|x| x == "NP"}
    str_arr = []
    if no_problem.present?
      str_arr << "No Problem"
    else
      musculoskeletals.each do |field|
        field_value = MUSCULOSKELETAL[field]
        if field == "7"
          str_arr << (oasis.fracture.present? ? "#{field_value}: #{oasis.fracture}" : field_value)
        elsif field == "8"
          str_arr << (oasis.swollon_painful_joints.present? ? "#{field_value}: #{oasis.swollon_painful_joints}" : field_value)
        elsif field == "9"
          str_arr << (oasis.antrophy.present? ? "#{field_value}: #{oasis.antrophy}" : field_value)
        elsif field == "10"
          str_arr << (oasis.decreased_rom.present? ? "#{field_value}: #{oasis.decreased_rom}" : field_value)
        elsif field == "11"
          str_arr << (oasis.paresthesia.present? ? "#{field_value}: #{oasis.paresthesia}" : field_value)
        elsif field == "12"
          str_arr << (oasis.weakness.present? ? "#{field_value}: #{oasis.weakness}" : field_value)
        elsif field == "13"
          list  = []
          list << "Joint: #{oasis.contractures_joint}" unless oasis.contractures_joint.blank?
          list << "Location: #{oasis.contractures_location}" unless oasis.contractures_location.blank?
          str_arr << (list.present? ? "#{field_value}: #{list.join(', ')}" : field_value)
        elsif field == "14"
          list = []
          amputation = oasis.amputation.reject{|x| x.blank?}
          list << amputation.join(", ") unless amputation.blank?
          list << "Specify: #{oasis.amputation_specify}" unless oasis.amputation_specify.blank?
          str_arr << (list.present? ? "#{field_value}: #{list.join(', ')}" : field_value)
        elsif field == "15"
          str_arr << (oasis.musculoskeletal_other.present? ? "#{field_value}: #{oasis.musculoskeletal_other}" : field_value)
        else
          str_arr << field_value unless field_value.blank?
        end
      end
      str_arr
    end
    str = str_arr.present? ? "EXTREMITIES: " + str_arr.join(", ") : nil
    str
  end

  def fall_risk_assessment
    "FALL RISK ASSESSMENT: #{oasis.fall_risk_assessment_total}/10" if oasis.fall_risk_assessment_total.present?
  end

  def nutritional_risk_assessment
    str = "NUTRITIONAL RISK ASSESSMENT: "
    nutritional_fields = if oasis.nutritional_status_no_problem == "NP"
                            "No Problem"
                          else
                            score = oasis.nutritional_status_total
                            rating = if [1, 2].include?(score)
                                       "Good"
                                     elsif [3, 4, 5].include?(score)
                                       "Moderate risk"
                                     else
                                       "High risk"
                                     end
                            "#{score}/21 (#{rating})" if score.present?
                          end
    str += nutritional_fields.present? ? nutritional_fields : ""

    enteral_str = "; Enteral Feedings: "
    str_arr = []
    if oasis.enteral_feedings_no_problem == "NP"
      str_arr << "No Problem"
    elsif oasis.enteral_feedings.present?
      enternal_feedings = oasis.enteral_feedings.reject{|x| x.blank?}
      enternal_feedings.each do |enternal_feeding|
        enternal_feeding = ENTERAL_FEEDINGS[enternal_feeding]
        str_arr << if enternal_feeding == "Pump"
                     list = []
                     list <<  "Type: #{oasis.enteral_feedings_pump}" unless oasis.enteral_feedings_pump.blank?
                     list << "#{ENTERAL_FEEDINGS_PUMP_TYPE[oasis.enteral_feedings_pump_type]}" unless ENTERAL_FEEDINGS_PUMP_TYPE[oasis.enteral_feedings_pump_type].blank?
                     res = (list.present? ?  "Pump: #{list.join(', ')}": "Pump")
                   elsif enternal_feeding == "Other"
                      "Other: #{oasis.enteral_feedings_other}" unless oasis.enteral_feedings_other.blank?
                   else
                      enternal_feeding if enternal_feeding.present?
                   end
      end

      str_arr << "Feedings Type: #{oasis.feedings_type_rate}" unless oasis.feedings_type_rate.blank?
      str_arr << "Flush Protocol: #{oasis.flush_protocol}" unless oasis.flush_protocol.blank?
      performed_by = CAREGIVERS_LIST[oasis.enteral_feeding_performed_by]
      performed_by_other = oasis.enteral_feeding_performed_by_other
      str_arr << if performed_by_other.present?
                   "Performed by: #{performed_by_other}"
                 elsif performed_by.present?
                   "Performed by: #{performed_by}"
                 else
                   nil
                 end
      str_arr << "Dressing/Site care: #{oasis.dressing_site_care}" unless oasis.dressing_site_care.blank?
      enteral_feedings_interventions = oasis.enteral_feedings_interventions
      str_arr << "Interventions/Instructions/Comments: #{enteral_feedings_interventions}" unless enteral_feedings_interventions.blank?
    end
    enteral_fields_str = str_arr.select{|x| x.blank? == false }.join(", ")
    str = (enteral_fields_str.size > 0) ? (str + enteral_str + enteral_fields_str) : str
    (str == "NUTRITIONAL RISK ASSESSMENT: ") ? nil : str
  end
end