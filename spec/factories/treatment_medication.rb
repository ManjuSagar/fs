require 'faker'

FactoryGirl.define do
  factory :treatment_medication do |f|
    f.assessment_date '01/05/2014'
    f.medication_name "ACILAC (10GM/15ML)"
    f.dosage_form "SOLUTION; ORAL, RECTAL"
    f.medication_code 'N'
    f.frequency "once daily"
    f.purpose "GERD"
    f.start_date "01/16/2014"
    f.medication_status 'D'
    f.created_user OrgStaff.all.first
  end
end