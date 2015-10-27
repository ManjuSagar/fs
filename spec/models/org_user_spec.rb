require 'spec_helper'

describe 'OrgUser' do
  it "Field Staff status is Active" do
    field_staff = FactoryGirl.build(:org_user, :user_status => "A")
    field_staff.user_status.should equal(:active)
  end

  it "Field Staff status is Inactive" do
    field_staff = FactoryGirl.build(:org_user, :user_status => "D")
    field_staff.user_status.should equal(:inactive)
  end

  it "Field Staff is Active" do
    field_staff = FactoryGirl.build(:org_user, :user_status => "A")
    field_staff.should be_active
  end

  it "Field Staff is Inactive" do
    field_staff = FactoryGirl.build(:org_user, :user_status => "D")
    field_staff.should be_inactive
  end

  it "Expect Field to Active when Activated" do
    field_staff = FactoryGirl.build(:org_user, :user_status => "D")
    expect { field_staff.activate }.to change {field_staff.user_status}.from(:inactive).to(:active)
  end

  it "Expect Field to Active when Activated from In Review" do
    field_staff = FactoryGirl.build(:org_user, :user_status => "I")
    expect { field_staff.activate }.to change {field_staff.user_status}.from(:in_review).to(:active)
  end

  it "Expect Field staff to Inactive when Inactivated" do
    field_staff = FactoryGirl.build(:org_user, :user_status => "A")
    expect { field_staff.inactivate}.to change {field_staff.user_status}.from(:active).to(:inactive)
  end

  it "Check if User is an Admin" do
    user = FactoryGirl.build(:org_user, :role_type => "A")
    user.role_type.should == "A"
  end
end