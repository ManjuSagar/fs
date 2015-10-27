require "stupidedi"

module Stupidedi::Versions::FunctionalGroups::FiftyTen::SegmentDefs

s = Stupidedi::Schema
e = Stupidedi::Versions::FunctionalGroups::FiftyTen::ElementDefs
r = Stupidedi::Versions::FunctionalGroups::FiftyTen::ElementReqs
t = Stupidedi::Versions::FunctionalGroups::FiftyTen::ElementTypes

E889  = t::ID.new(:E889 , "Follow-up Action Code"                   , 1, 1,
  s::CodeList.build(
    "C" => "Please Correct and Resubmit",
    "N" => "Resubmission Not Allowed",
    "P" => "Please Resubmit Original Transaction",
    "R" => "Resubmission Allowed",
    "S" => "Do Not Resubmit; Inquiry Initiated to a Third Party",
    "Y" => "Do Not Resubmit; We Will Hold Your Request and Respond Again Shortly"))

E875 = t::ID.new(:E875, "Maintenance Type Code"                   , 3, 3,
  s::CodeList.build(
    "001" => "Change"))

E1203 = t::ID.new(:E1203, "Maintenance Reason Code"                   , 2, 3,
  s::CodeList.build(
    "25" => "Change in Identifying Data Elements"))

E1470    = t::Nn.new(:E1470   , "Number"  , 1, 9, 0)

E1390  = t::ID.new(:E1390 , "Eligibility or Benefit Information Code"                   , 1, 2,
  s::CodeList.build(
  "1" => "Active Coverage",
  "2" => "Active - Full Risk Capitation ",
  "3" => "Active - Services Capitated",
  "4" => "Active - Services Capitated to Primary Care Physician",
  "5" => "Active - Pending Investigation ",
  "6" => "Inactive",
  "7" => "Inactive - Pending Eligibility Update ",
  "8" => "Inactive - Pending Investigation ",
  "A" => "Co-Insurance",
  "B" => "Co-Payment",
  "C" => "Deductible ",
  "CB" => "Coverage Basis ",
  "D" => "Benefit Description",
  "E" => "Exclusions",
  "F" => "Limitations",
  "G" => "Out of Pocket (Stop Loss) ",
  "H" => "Unlimited",
  "I" => "Non-Covered",
  "J" => "Cost Containment",
  "K" => "Reserve",
  "L" => "Primary Care Provider",
  "M" => "Pre-existing Condition",
  "MC" => "Managed Care Coordinator",
  "N" => "Services Restricted to Following Provider ",
  "O" => "Not Deemed a Medical Necessity",
  "P" => "Benefit Disclaimer (Not recommended. See section 1.3.10 Disclaimers Within the Transaction)",
  "Q" => "Second Surgical Opinion Required",
  "R" => "Other or Additional Payor",
  "S" => "Prior Year(s) History",
  "T" => "Card(s) Reported Lost/Stolen",
  "U" => "Contact Following Entity for Eligibility or Benefit Information",
  "V" => "Cannot Process",
  "W" => "Other Source of Data",
  "X" => "Health Care Facility",
  "Y" => "Spend Down",
))

E1365 = t::ID.new(:E1365, "Service Type Code"                    , 1, 2,
  s::CodeList.build(
  "1" => "Medical Care",
  "2" => "Surgical",
  "3" => "Consultation",
  "4" => "Diagnostic X-Ray",
  "5" => "Diagnostic Lab",
  "6" => "Radiation Therapy",
  "7" => "Anesthesia",
  "8" => "Surgical Assistance",
  "9" => "Other Medical",
  "10" => "Blood Charges",
  "11" => "Used Durable Medical Equipment",
  "12" => "Durable Medical Equipment Purchase",
  "13" => "Ambulatory Service Center Facility",
  "14" => "Renal Supplies in the Home",
  "15" => "Alternate Method Dialysis",
  "16" => "Chronic Renal Disease (CRD) Equipment",
  "17" => "Pre-Admission Testing",
  "18" => "Durable Medical Equipment Rental",
  "19" => "Pneumonia Vaccine",
  "20" => "Second Surgical Opinion ",
  "21" => "Third Surgical Opinion ",
  "22" => "Social Work",
  "23" => "Diagnostic Dental",
  "24" => "Periodontics",
  "25" => "Restorative",
  "26" => "Endodontics",
  "27" => "Maxillofacial Prosthetics",
  "28" => "Adjunctive Dental Services",
  "30" => "Health Benefit Plan Coverage",
  "32" => "Plan Waiting Period",
  "33" => "Chiropractic",
  "34" => "Chiropractic Office Visits ",
  "35" => "Dental Care",
  "36" => "Dental Crowns",
  "37" => "Dental Accident",
  "38" => "Orthodontics",
  "39" => "Prosthodontics",
  "40" => "Oral Surgery",
  "41" => "Routine (Preventive) Dental ",
  "42" => "Home Health Care",
  "43" => "Home Health Prescriptions ",
  "44" => "Home Health Visits",
  "45" => "Hospice",
  "46" => "Respite Care",
  "47" => "Hospital",
  "48" => "Hospital - Inpatient",
  "49" => "Hospital - Room to Board",
  "50" => "Hospital - Outpatient",
  "51" => "Hospital - Emergency Accident",
  "52" => "Hospital - Emergency Medical",
  "53" => "Hospital - Ambulatory Surgical",
  "54" => "Long Term Care",
  "55" => "Major Medical",
  "56" => "Medically Related Transportation",
  "57" => "Air Transportation",
  "58" => "Cabulance",
  "59" => "Licensed Ambulance",
  "60" => "General Benefits",
  "61" => "In-vitro Fertilization",
  "62" => "MRI/CAT Scan",
  "63" => "Donor Procedures",
  "64" => "Acupuncture",
  "65" => "Newborn Care",
  "66" => "Pathology",
  "67" => "Smoking Cessation",
  "68" => "Well Baby Care",
  "69" => "Maternity",
  "70" => "Transplants",
  "71" => "Audiology Exam",
  "72" => "Inhalation Therapy",
  "73" => "Diagnostic Medical",
  "74" => "Private Duty Nursing",
  "75" => "Prosthetic Device",
  "76" => "Dialysis",
  "77" => "Otological Exam",
  "78" => "Chemotherapy",
  "79" => "Allergy Testing",
  "80" => "Immunizations",
  "81" => "Routine Physical",
  "82" => "Family Planning",
  "83" => "Infertility",
  "84" => "Abortion",
  "85" => "AIDS",
  "86" => "Emergency Services",
  "87" => "Cancer",
  "88" => "Pharmacy",
  "89" => "Free Standing Prescription Drug",
  "90" => "Mail Order Prescription Drug",
  "91" => "Brand Name Prescription Drug",
  "92" => "Generic Prescription Drug",
  "93" => "Podiatry",
  "94" => "Podiatry - Office Visits",
  "95" => "Podiatry - Nursing Home Visits",
  "96" => "Professional (Physician)",
  "97" => "Anesthesiologist",
  "98" => "Professional (Physician) Visit - Office",
  "99" => "Professional (Physician) Visit - Inpatient",
  "A0" => "Professional (Physician) Visit - Outpatient",
  "A1" => "Professional (Physician) Visit - Nursing Home",
  "A2" => "Professional (Physician) Visit - Skilled Nursing Facility",
  "A3" => "Professional (Physician) Visit - Home",
  "A4" => "Psychiatric",
  "A5" => "Psychiatric - Room and Board",
  "A6" => "Psychotherapy",
  "A7" => "Psychiatric - Inpatient",
  "A8" => "Psychiatric - Outpatient",
  "A9" => "Rehabilitation",
  "AA" => "Rehabilitation - Room and Board",
  "AB" => "Rehabilitation - Inpatient",
  "AC" => "Rehabilitation - Outpatient",
  "AD" => "Occupational Therapy",
  "AE" => "Physical Medicine",
  "AF" => "Speech Therapy",
  "AG" => "Skilled Nursing Care",
  "AH" => "Skilled Nursing Care - Room and Board ",
  "AI" => "Substance Abuse",
  "AJ" => "Alcoholism",
  "AK" => "Drug Addiction",
  "AL" => "Vision (Optometry)",
  "AM" => "Frames",
  "AN" => "Routine Exam",
  "AO" => "Lenses",
  "AQ" => "Nonmedically Necessary Physical",
  "AR" => "Experimental Drug Therapy",
  "BA" => "Independent Medical Evaluation",
  "BB" => "Partial Hospitalization (Psychiatric)",
  "BC" => "Day Care (Psychiatric)",
  "BD" => "Cognitive Therapy",
  "BE" => "Massage Therapy",
  "BF" => "Pulmonary Rehabilitation",
  "BG" => "Cardiac Rehabilitation",
  "BH" => "Pediatric",
  "BI" => "Nursery",
  "BJ" => "Skin",
  "BK" => "Orthopedic",
  "BL" => "Cardiac",
  "BM" => "Lymphatic",
  "BN" => "Gastrointestinal",
  "BP" => "Endocrine",
  "BQ" => "Neurology",
  "BR" => "Eye",
  "BS" => "Invasive Procedures"
))

E1207  = t::ID.new(:E1207 , "Coverage Level Code"                   , 3, 3,
  s::CodeList.build(
    "CHD" => "Children Only",
    "DEP" => "Dependents Only",
    "FAM" => "Family",
))

E1336  = t::ID.new(:E1336 , "Insurance Type Code"                   , 1, 3,
  s::CodeList.build(
  
  "D" => "Disability",
  "12" => "Medicare Secondary Working Aged Beneficiary or Spouse with Employer Group Health Plan",
  "13" => "Medicare Secondary End-Stage Renal Disease Beneficiary in the Mandated Coordination Period with an Employer's Group Health Plan",
  "14" => "Medicare Secondary, No-fault Insurance including Auto is Primary",
  "15" => "Medicare Secondary Worker's Compensation",
  "16" => "Medicare Secondary Public Health Service (PHS)or Other Federal Agency",
  "41" => "Medicare Secondary Black Lung",
  "42" => "Medicare Secondary Veteran's Administration",
  "43" => "Medicare Secondary Disabled Beneficiary Under Age 65 with Large Group Health Plan (LGHP)",
  "47" => "Medicare Secondary, Other Liability Insurance is Primary AP Auto Insurance Policy",
  "C1" => "Commercial",
  "CO" => "Consolidated Omnibus Budget Reconciliation Act (COBRA)",
  "CP" => "Medicare Conditionally Primary",
  "DB" => "Disability Benefits",
  "EP" => "Exclusive Provider Organization FF Family or Friends",
  "GP" => "Group Policy",
  "HM" => "Health Maintenance Organization (HMO)",
  "HN" => "Health Maintenance Organization (HMO) - Medicare Risk",
  "HS" => "Special Low Income Medicare Beneficiary",
  "IN" => "Indemnity",
  "IP" => "Individual Policy",
  "LC" => "Long Term Care",
  "LD" => "Long Term Policy",
  "LI" => "Life Insurance LT Litigation",
  "MA" => "Medicare Part A",
  "MB" => "Medicare Part B",
  "MC" => "Medicaid",
  "MH" => "Medigap Part A",
  "MI" => "Medigap Part B",
  "MP" => "Medicare Primary",
  "OT" => "Other",
  "PE" => "Property Insurance - Personal",
  "PL" => "Personal",
  "PP" => "Personal Payment (Cash - No Insurance)",
  "PR" => "Preferred Provider Organization (PPO)",
  "PS" => "Point of Service (POS)",
  "QM" => "Qualified Medicare Beneficiary",
  "RP" => "Property Insurance - Real",
  "SP" => "Supplemental Policy",
  "TF" => "Tax Equity Fiscal Responsibility Act (TEFRA) WC Workers Compensation",
  "WU" => "Wrap Up Policy",
  
))

E1204   = t::AN.new(:E1204  , "Plan Coverage Description"                  , 1, 50)

E1111   = t::AN.new(:E1111, "C003 Placeholder"                  , 1, 50)

E615  = t::ID.new(:E615 , "Time Period Qualifier"                   , 1, 2,
  s::CodeList.build(
  "6" => "Hour",
  "7" => "Day",
  "13" => "24 Hours",
  "21" => "Years",
  "22" => "Service Year",
  "23" => "Calendar Year",
  "24" => "Year to Date",
  "25" => "Contract",
  "26" => "Episode",
  "27" => "Visit",
  "28" => "Outlier",
  "29" => "Remaining",
  "30" => "Exceeded",
  "31" => "Not Exceeded",
  "32" => "Lifetime",
  "33" => "Lifetime Remaining",
  "34" => "Month",
  "35" => "Week",
  "36" => "Admisson"
))

E673  = t::ID.new(:E673 , "Quantity Qualifier"                   , 2, 2,
  s::CodeList.build(
"99" => "Quantity Used",
"CA" => "Covered - Actual",
"CE" => "Covered - Estimated",
"DB" => "Deductible Blood Units",
"DY" => "Days",
"HS" => "Hours",
"LA" => "Life-time Reserve - Actual",
"LE" => "Life-time Reserve - Estimated",
"MN" => "Month",
"P6" => "Number of Services or Procedures",
"QA" => "Quantity Approved",
"S7" => "Age, High Value (Max Age)",
"S8" => "Age, Low Value (Min Age)",
"VS" => "Visits",
"YY" => "Years",
))

E1167   = t:: R.new(:E1167  , "Sample Selection Modulus"                               , 1, 6)
E616    = t::Nn.new(:E616   , "Number of Periods"  , 1, 3, 0)

E678  = t::ID.new(:E678 , "Ship/Delivery or Calendar Pattern Code"                   , 1, 2,
  s::CodeList.build(
    "1" => "1st Week of the Month",
    "2" => "2nd Week of the Month",
))

E679  = t::ID.new(:E679 , "Ship/Delivery Pattern Time Code"                   , 1, 1,
  s::CodeList.build(
    "A" => "1st Shift (Normal Working Hours)",
    "B" => "2nd Shift",
))

E374  = t::ID.new(:E374 , "Date/Time Qualifier"                  , 3, 3,
  s::CodeList.build(

"193" => "Period Start",
"194" => "Period End",
"198" => "Completion ",
"290" => "Coordination of Benefits",
"291" => "Plan",
"292" => "Benefit",
"295" => "Primary Care Provider",
"304" => "Latest Visit or Consultation",
"307" => "Eligibility",
"318" => "Added",
"348" => "Benefit Begin",
"349" => "Benefit End",
"356" => "Eligibility Begin",
"357" => "Eligibility End",
"435" => "Admission",
"472" => "Service",
"636" => "Date of Last Update",
))

DT1 = s::SegmentDef.build(:DTP, "Date or Time Period",
  "To specify any or all of a date, or a time period",
     E374 .simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
  e::E1250.simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
  e::E1251.simple_use(r::Mandatory,  s::RepeatCount.bounded(1))
)

AAA = s::SegmentDef.build(:AAA, "Request Validation",
  "To specify the validity of the request and indicate follow-up action authorized",
  e::E1073.simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
  e::E901 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  E889    .simple_use(r::Optional,   s::RepeatCount.bounded(1)),
)

INS = s::SegmentDef.build(:INS, "Subscriber Relationship",
  "To provide benefit information on insured entities",
  e::E1073.simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
  e::E1069.simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
     E875 .simple_use(r::Optional,   s::RepeatCount.bounded(1)),
     E1203.simple_use(r::Optional,   s::RepeatCount.bounded(1)),
     E1470.simple_use(r::Optional,   s::RepeatCount.bounded(1)),
) 
EB = s::SegmentDef.build(:EB, "Subscriber Eligibility or Benefit Information",
  "To supply eligibility or benefit information",
     E1390.simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
     E1207.simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E1365.simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E1336.simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E1204.simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E615 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  e::E782 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  e::E954 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E673 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  e::E380 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  e::E1073.simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  e::E1073.simple_use(r::Optional,  s::RepeatCount.bounded(1)),
#  e::C003 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E1111 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  e::C004 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  
)  

HSD = s::SegmentDef.build(:HSD, "Health Care Services Delivery",
  "To specify the delivery pattern of healthcare services",
  e::E673 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  e::E380 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
  e::E355 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E1167.simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E615 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E616 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E678 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
     E679 .simple_use(r::Optional,  s::RepeatCount.bounded(1)),
)

MSG = s::SegmentDef.build(:MSG, "Message Text",
  "Message Text",
  e::E933 .simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
)

LS = s::SegmentDef.build(:LS, "Loop Header",
  "Loop Header",
  e::E447 .simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
)

LE = s::SegmentDef.build(:LE, "Loop Trailer",
  "Loop Trailer",
  e::E447 .simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
)

GK = s::SegmentDef.build(:GK, "Guru Krupa Sample Segment",
"Test Stuff",
  E1204 .simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
)

GK2 = s::SegmentDef.build(:GK2, "Additional Name Information",
  "To specify additional names",
  e::E93  .simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
  e::E93  .simple_use(r::Optional,   s::RepeatCount.bounded(1)),
  E1204 .simple_use(r::Optional,  s::RepeatCount.bounded(1)))


N1G = s::SegmentDef.build(:N1G, "Individual or Organizational Name",
  "To supply the full name of an individual or organizational entity",
  e::E98  .simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
  e::E1065.simple_use(r::Mandatory,  s::RepeatCount.bounded(1)),
  e::E1035.simple_use(r::Relational, s::RepeatCount.bounded(1)),
  e::E1036.simple_use(r::Optional,   s::RepeatCount.bounded(1)),
  e::E1037.simple_use(r::Optional,   s::RepeatCount.bounded(1)),
  e::E1038.simple_use(r::Optional,   s::RepeatCount.bounded(1)),
  e::E1039.simple_use(r::Optional,   s::RepeatCount.bounded(1)),

  e::E66  .simple_use(r::Relational, s::RepeatCount.bounded(1)),
  e::E67  .simple_use(r::Relational, s::RepeatCount.bounded(1)),
  e::E706 .simple_use(r::Relational, s::RepeatCount.bounded(1)),
  e::E98  .simple_use(r::Optional,   s::RepeatCount.bounded(1)),
  e::E1035.simple_use(r::Optional,   s::RepeatCount.bounded(1)),
  
  Stupidedi::Versions::FunctionalGroups::FiftyTen::SyntaxNotes::P.build( 8,  9),
  Stupidedi::Versions::FunctionalGroups::FiftyTen::SyntaxNotes::C.build(11, 10),
  Stupidedi::Versions::FunctionalGroups::FiftyTen::SyntaxNotes::C.build(12,  3)

)
  
end

module GuruKrupa

  d = Stupidedi::Schema
  r = Stupidedi::Versions::FunctionalGroups::FiftyTen::SegmentReqs
  s = Stupidedi::Versions::FunctionalGroups::FiftyTen::SegmentDefs

  HB271 = d::TransactionSetDef.build("HB", "271",
    "Eligibility, Coverage, or Benefit Information",

    d::TableDef.header("Table 1 - Header",
      s:: ST.use(100, r::Mandatory, d::RepeatCount.bounded(1)),
      s::BHT.use(200, r::Mandatory, d::RepeatCount.bounded(1)),
      ),

    d::TableDef.detail("Table 2 - Detail",
      d::LoopDef.build("2000", d::RepeatCount.unbounded,
        s:: HL.use(100, r::Mandatory, d::RepeatCount.bounded(1)),
        s::TRN.use(200, r::Optional,  d::RepeatCount.bounded(9)),
        s::AAA.use(300, r::Optional,  d::RepeatCount.bounded(9)),

        d::LoopDef.build("2100", d::RepeatCount.unbounded,
          s::NM1.use( 300, r::Mandatory, d::RepeatCount.bounded(1)),
          s::REF.use( 400, r::Optional,  d::RepeatCount.bounded(9)),
          s:: N2.use( 500, r::Optional,  d::RepeatCount.bounded(1)),
          s:: N3.use( 600, r::Optional,  d::RepeatCount.bounded(1)),
          s:: N4.use( 700, r::Optional,  d::RepeatCount.bounded(1)),
          s::PER.use( 800, r::Optional,  d::RepeatCount.bounded(3)),
          s::AAA.use( 850, r::Optional,  d::RepeatCount.bounded(9)),
          s::PRV.use( 900, r::Optional,  d::RepeatCount.bounded(1)),
          s::DMG.use(1000, r::Optional,  d::RepeatCount.bounded(1)),
          s::INS.use(1100, r::Optional,  d::RepeatCount.bounded(1)),
          s::DTP.use(1200, r::Optional,  d::RepeatCount.bounded(9)),

          d::LoopDef.build("2110", d::RepeatCount.unbounded,
             s::EB.use(1300, r::Optional,  d::RepeatCount.bounded(1)),
            s::HSD.use(1350, r::Optional,  d::RepeatCount.bounded(9)),
            s::REF.use(1400, r::Optional,  d::RepeatCount.bounded(9)),
            s::DT1.use(1500, r::Optional,  d::RepeatCount.bounded(20)), #DT1 is hack name
            s::AAA.use(1600, r::Optional,  d::RepeatCount.bounded(9)),
            s::MSG.use(2500, r::Optional,  d::RepeatCount.bounded(10)),
               
                d::LoopDef.build("LS1", d::RepeatCount.bounded(1),
                s::LS.use(3300, r::Optional,  d::RepeatCount.bounded(1)),

                  d::LoopDef.build("2120", d::RepeatCount.bounded(23),
                    # Devision from the format definition of 271
                    # StupidEdi seems to have a limitation/bug where by 
                    # the NM1 below is not treated as a separate loop but
                    # starting from the HL loop
                    # So the N1G below is nothing but a copy of NM1
                    # When processing a proper 271, before parsing
                    # the file will have to have the respective NM1's 
                    # replaced with N1Gs
                     #FIXME Need to work with the developer of StupidEdi on this
                    
                    
                   s::N1G.use(3400, r::Optional,  d::RepeatCount.bounded(1)),
#                   s::NM1.use(3400, r::Optional,  d::RepeatCount.bounded(1)),
                    s:: N2.use(3500, r::Optional,  d::RepeatCount.bounded(1)),
                    s:: N3.use(3600, r::Optional,  d::RepeatCount.bounded(1)),
                    s:: N4.use(3700, r::Optional,  d::RepeatCount.bounded(1)),
                    s::PER.use(3800, r::Optional,  d::RepeatCount.bounded(3)),
                    s::PRV.use(3900, r::Optional,  d::RepeatCount.bounded(1))
                  ),

                s::LE.use(4000, r::Mandatory,  d::RepeatCount.bounded(1)),
                ),

          ),
            
        ),

      s:: SE.use(4100, r::Mandatory, d::RepeatCount.bounded(1))
      ))
  )

end
