require 'spec_helper'
require 'date'

def create_contracts(staffing_company)
  staffing_company.agency_contracts << FactoryGirl.build(:staffing_company_contract,
                                                         effective_from_date: Date.new(2014,9,13),
                                                         effective_to_date: Date.new(2014,11,12)
  )
  staffing_company.agency_contracts << FactoryGirl.build(:staffing_company_contract,
                                                         effective_from_date: Date.new(2014,11,13),
                                                         effective_to_date: Date.new(2015,1,12)
  )
  staffing_company
end

describe StaffingCompany do

  let!(:staffing_company){FactoryGirl.build(:staffing_company)}
  subject {staffing_company}

  it "should return nil if contract period is expired." do
    staffing_company = create_contracts(subject)
    staffing_company.contract_period_with_in_from_date_and_to_date(Date.new(2015,1,13)).should be_nil
  end

  it "should return Staffing Company Contract if contract period is not expired." do
    staffing_company = create_contracts(subject)
    staffing_company.contract_period_with_in_from_date_and_to_date(Date.new(2015,1,7)).should_not be_nil
  end

end
