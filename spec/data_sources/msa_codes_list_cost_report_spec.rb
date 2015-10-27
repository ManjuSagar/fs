require 'spec_helper'

describe ReportDataSource::MsaCodesList do
  before(:each) do
    Org.current = FactoryGirl.build(:health_agency)
  end

  it "should return an Array" do
    msa_codes = ReportDataSource::MsaCodesList.new(2014)
    expect(msa_codes.msa_codes_list.is_a? (Array)).to eq true
  end

  it "should return an integer value" do
    msa_codes = ReportDataSource::MsaCodesList.new(2014)
    expect(msa_codes.medicare_services_area_count.is_a? (Fixnum)).to eq true
  end

end
