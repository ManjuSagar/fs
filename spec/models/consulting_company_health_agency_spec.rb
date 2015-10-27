require 'spec_helper'

describe ConsultingCompanyHealthAgency do

  it "is invalid without consulting company" do
    ccha = FactoryGirl.build(:consulting_company_health_agency, consulting_company_id: nil)
    ccha.should_not be_valid
  end

  it "is invalid without Health Agency" do
    ccha = FactoryGirl.build(:consulting_company_health_agency, health_agency_id: nil)
    ccha.should_not be_valid
  end

  it "is initially not active" do
    ccha = FactoryGirl.build(:consulting_company_health_agency)
    ccha.active.should be_false
  end

  it "is active when activated" do
    ccha = FactoryGirl.build(:consulting_company_health_agency)
    expect {ccha.activate}.to change {ccha.active}.from(false).to(true)
  end

  it "has Pending Clients" do
    ccha = FactoryGirl.build(:consulting_company_health_agency)
    ConsultingCompanyHealthAgency.stub(:pending_health_agencies).and_return([ccha])
    ConsultingCompanyHealthAgency.pending_health_agencies.should include(ccha)
  end

  it "has active clients after activated" do
    ccha = FactoryGirl.build(:consulting_company_health_agency, active: true)
    ConsultingCompanyHealthAgency.stub(:active_health_agencies).and_return([ccha])
    ConsultingCompanyHealthAgency.active_health_agencies.should include(ccha)
  end
end