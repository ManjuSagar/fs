require 'spec_helper'

describe WelcomeHelper do
  class DummyClass
  end

  it "should return true if current user is office staff" do
    @dummy_class = DummyClass.new
    @dummy_class.extend(WelcomeHelper)
    User.current = FactoryGirl.build(:org_staff)
    @dummy_class.should be_current_user_is_office_staff
  end

end