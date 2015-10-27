require 'spec_helper'

describe "InsuranceCompany" do

  it 'is invalid without Street Address' do
     FactoryGirl.build(:insurance_company, claim_street_address: nil).should_not be_valid
  end

  it 'is invalid without ZIP code' do
    FactoryGirl.build(:insurance_company, claim_zip_code: nil).should_not be_valid
  end

  it 'is invalid without City' do
    FactoryGirl.build(:insurance_company, claim_city: nil).should_not be_valid
  end

  it 'is invalid without State' do
    FactoryGirl.build(:insurance_company, claim_state: nil).should_not be_valid
  end

  it 'is invalid if street_address is having more than 50 characters' do
    FactoryGirl.build(:insurance_company, claim_street_address: "101MS" * 10).claim_street_address.length.should <= 50
  end

  it 'is invalid if city is having more than 50 characters' do
    FactoryGirl.build(:insurance_company, claim_city: 'b' * 50).claim_city.length.should <= 50
  end

  it 'zip code should not valid' do
    ins = FactoryGirl.build(:insurance_company, claim_zip_code: "0000")
    ins.valid_zip_code_check.include?("ZIP Code is not valid.").should be_true
  end

  it 'zip code should be valid' do
    ins = FactoryGirl.build(:insurance_company, claim_zip_code: "90013")
    ins.valid_zip_code_check.should be_nil
  end

end
