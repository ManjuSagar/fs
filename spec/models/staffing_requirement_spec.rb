require 'spec_helper'

describe StaffingRequirement do

  let!(:staffing_requirement) {FactoryGirl.build(:staffing_requirement)}
  subject {staffing_requirement}

  it "should return proper sql string" do
    subject.sql_string({discipline_id: 30, visit_type_id: 20, staff_id: nil}).
        should == "discipline_id = 30 AND visit_type_id = 20 AND staff_id is NULL"
  end
end