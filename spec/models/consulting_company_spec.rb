require 'spec_helper'

describe ConsultingCompany do
  let!(:consulting_company) {FactoryGirl.build(:consulting_company)}
  subject { consulting_company }

  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, org_name: nil), :org_name
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, org_package: nil), :org_package
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, week_start_day: nil), :week_start_day
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, street_address: nil), :street_address
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, city: nil), :city
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, state: nil), :state
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, zip_code: nil), :zip_code
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, email: nil), :email
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, org_package: nil), :org_package
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, fed_tax_number: nil), :fed_tax_number
  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consulting_company, preferred_alert_mode: nil), :preferred_alert_mode

  it "should return org_name for to_s method call" do
    subject.to_s.should == "#{subject.org_name}"
  end

  it "should return false for is_ha? method call" do
    should_not be_is_ha
  end

  it "should return address for address_string method call" do
    subject.address_string.should == "#{subject.agency_address1 + " " + subject.agency_address2}"
  end

  it "should return street_adress and suite number for agency_address1 method call" do
    street_address = subject.street_address
    suite_number = subject.suite_number

    #Both street and suite numbers present
    subject.agency_address1.should == "#{street_address + ", Suite " + suite_number}"

    #only suite_number present
    subject.street_address = nil
    subject.agency_address1.should == "Suite #{suite_number}"

    #only street_address present
    subject.street_address = street_address
    subject.suite_number = nil
    subject.agency_address1.should == "#{street_address}"

    #Both street_address and suite_number are blank
    subject.street_address = nil
    subject.agency_address1.should == ""
  end

  it "should return city, state and zip_code for agency_address2 method call" do
    subject.agency_address2.should == "#{subject.city}, #{subject.state} #{subject.zip_code}"
  end

  it "should return city, state and zip_code for location method call" do
    subject.location.should == "#{subject.city}, #{subject.state}-#{subject.zip_code}"
  end

  it "should return 0 as total Health Agency count" do
    should have(0).health_agencies
  end

  it "should return 1 as total Health Agency count" do
    subject.health_agencies << FactoryGirl.build(:health_agency)
    should have(1).health_agencies
  end

end