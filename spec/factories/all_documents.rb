require 'faker'

FactoryGirl.define do |f|
  factory :all_document do |f|
      f.documentable_type 'TreatmentActivity'
      f.documentable_id '4'
      association :treatment_episode, factory: :treatment_episode, strategy: :build
          f.category 'Attachment'
          f.staff 'SN'
          f.description 'Simple attachment'
          f.status 'HOLD-ON'
          f.document_date Date.current
  end
  end