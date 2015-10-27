require 'spec_helper'

describe RcDcPlanReportDataSource do
  before do
    Org.current = Org.find_by_email "info@mymetrohc.com"
  end

  it "should return field staff and phone number" do
    field_staff = FactoryGirl.build(:field_staff, first_name: "Herta", last_name: "Minard", phone_number: "989 787 6273")
    episode = RcDcPlanReportDataSource.new({:filter_by => "CM"})
    episode.field_staff_and_phone_number(field_staff).should == "CM Herta Minard, PT 989 787 6273"
  end

  it "should return date range statement with from and to date" do
    episode = RcDcPlanReportDataSource.new ({:from_date => "01/01/2014" , :to_date => "09/01/2014", :filter_by => "CU"})
    episode.date_range_statement.should == "Episode End Date from 01/01/2014 to 01/09/2014"
  end
end