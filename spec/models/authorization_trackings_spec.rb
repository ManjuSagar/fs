require 'spec_helper'

  describe 'Authorization Trackings' do

    it_behaves_like 'is invalid without the field', FactoryGirl.build(:authorization_tracking, patient_id: nil), :patient_id

    it_behaves_like 'is invalid without the field', FactoryGirl.build(:authorization_tracking, treatment_episode_id: nil), :treatment_episode_id

    it_behaves_like 'is invalid without the field', FactoryGirl.build(:authorization_tracking, insurance_company_id: nil), :insurance_company_id

    it_behaves_like 'is invalid without the field', FactoryGirl.build(:authorization_tracking, discipline_id: nil), :discipline_id

    it_behaves_like 'is invalid without the field', FactoryGirl.build(:authorization_tracking, field_staff_id: nil), :field_staff_id

    it_behaves_like 'is invalid without the field', FactoryGirl.build(:authorization_tracking, visit_count: nil), :visit_count

    it_behaves_like 'is invalid without the field', FactoryGirl.build(:authorization_tracking, start_date: nil), :start_date

    it_behaves_like 'is invalid without the field', FactoryGirl.build(:authorization_tracking, end_date: nil), :end_date

    it_behaves_like 'is invalid without the field', FactoryGirl.build(:authorization_tracking, patient_number: nil), :patient_number

    it_behaves_like 'is valid without the field', FactoryGirl.build(:authorization_tracking, authorization_number: nil), :authorization_number

    it_behaves_like 'is valid without the field', FactoryGirl.build(:authorization_tracking, special_instructions: nil), :special_instructions

    it_behaves_like 'is valid without the field', FactoryGirl.build(:authorization_tracking, internal_comments: nil), :internal_comments

  end