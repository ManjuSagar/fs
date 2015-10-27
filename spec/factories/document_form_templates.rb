require 'faker'

FactoryGirl.define do
  factory :document_form_template do |f|
    f.template_name 'SOC Oasis C1'
    f.template_description 'OASIS Evaluation C1'
    f.document_class_name 'OasisEvalFormC1'
  end
end