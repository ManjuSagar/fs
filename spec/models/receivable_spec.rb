require 'spec_helper'

describe Receivable do
  context "Home Health Services" do
    let(:receivable) { FactoryGirl.build(:receivable, purpose: 'Home Health Services')}

    subject { receivable }
    it "should return true if receivable is 'Home Health Services'" do
      subject.should be_home_health_service
    end

    it "should return false if receivable is not 'Home Health Services'" do
      subject.purpose = "ABC"
      subject.should_not be_home_health_service
    end

    it "should change hipps code and amount when call update hipps code and amount method" do
      subject.hcpcs_code = '1AFKS'
      subject.update_hipps_code_and_amount({hipps_code: "1AFKT", amount: 1234.56})
      subject.hcpcs_code.should_not equal("1AFKS")
      subject.receivable_amount.should_not equal(200.12)
    end
  end

end