require 'spec_helper'
describe VisitType do
  let!(:visit_type){ FactoryGirl.build(:visit_type)}
  subject{:visit_type}
  it "Visit Type status should be Active" do
     visit_type = FactoryGirl.build(:visit_type, :visit_type_status => "A")
     visit_type.visit_type_status.should equal(:active)
  end

  it "Visit Type status should be Disabled" do
    visit_type = FactoryGirl.build(:visit_type, :visit_type_status => "D")
    visit_type.visit_type_status.should equal(:inactive)
  end

  it "Mark visit type as disabled" do
    visit_type = FactoryGirl.build(:visit_type, :visit_type_status => "A")
    visit_type.inactivate
    visit_type.visit_type_status.should == :inactive
  end

  it "Mark visit type as active" do
    visit_type = FactoryGirl.build(:visit_type, :visit_type_status => "D")
    visit_type.activate
    visit_type.visit_type_status.should == :active
  end
end