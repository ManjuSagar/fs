require 'faker'
FactoryGirl.define do
  factory :document do |f|
    f.status ":completed"
    f.document_type "OasisEvaluation"    
    f.document_date Date.today   
    f.fs_sign_required false
    f.supervisor_sign_required false
    f.os_sign_required false
    f.agency_approved_user_id nil
    f.field_staff_id 350
    f.supervised_user_id nil
    f.fs_sign_date Date.today
    f.os_sign_date Date.today
    f.supervised_user_sign_date nil
    f.visit_id nil
    f.data {}
    f.physician_id 309
    association :document_form_template, strategy: :build
    association :treatment, factory: :patient_treatment, strategy: :build
    association :treatment_episode, strategy: :build
    association :document_definition, strategy: :build
  end

  factory :oasis_export do |f|
    f.export_status :exported
    f.exported_date_time Time.now
    #document
  end

  factory :oasis_evaluation do |f|
    f.status ":completed"
    f.document_type "OasisEvaluation"
    f.document_date Date.today
    f.fs_sign_required false
    f.supervisor_sign_required false
    f.os_sign_required false
    f.agency_approved_user_id nil
    f.field_staff_id 350
    f.supervised_user_id nil
    f.fs_sign_date Date.today
    f.os_sign_date Date.today
    f.supervised_user_sign_date nil
    f.visit_id nil
    f.data {}
    f.physician_id 309
    association :document_form_template, strategy: :build
    association :treatment, factory: :patient_treatment, strategy: :build
    association :treatment_episode, strategy: :build
    association :document_definition, strategy: :build
  end
end