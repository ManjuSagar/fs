require 'spec_helper'
describe StaffingCompanyContract do

  let!(:staffing_company_contract){FactoryGirl.build(:staffing_company_contract)}
  subject {:staffing_company_contract}

  it "should return true if visit date is with in from date and to date" do
    sc_contract = FactoryGirl.build(:staffing_company_contract)
    sc_contract.applicable?(Date.new(2014,04,11)).should be_true
    end

  it "should return false if visit date is not with in from date and to date" do
    sc_contract = FactoryGirl.build(:staffing_company_contract, effective_to_date: Date.new(2014,04,10))
    sc_contract.applicable?(Date.new(2014,04,11)).should be_false
  end

  it "should return true if visit date is less than or equal to from date" do
    sc_contract = FactoryGirl.build(:staffing_company_contract, effective_to_date: nil )
    sc_contract.applicable?(Date.new(2014,04,11)).should be_true
  end
end