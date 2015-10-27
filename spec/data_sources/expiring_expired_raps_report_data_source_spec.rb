require 'spec_helper'

describe ExpiringExpiredRapsReportDataSource do

  subject {ExpiringExpiredRapsReportDataSource.any_instance.stub(:collect_expiring_or_expired_raps).and_return([]);ExpiringExpiredRapsReportDataSource.new}

  it "should return patient last name, first name and mr number" do
    patient = FactoryGirl.build(:patient)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:patient_reference).and_return("12012015")
    subject.patient_name(patient).should == "#{patient.last_name}, #{patient.first_name} (#{patient.patient_reference})"
  end

  it "should return true if expire date is with in current date to next 30 days" do
    expire_date = Date.current + 20
    subject.expires_within_maximum_number_days(expire_date).should be_true
  end

  it "should return true if expire date is with in current date and current date + 30 days" do
    expire_date = Date.current + 20
    subject.expires_within_maximum_number_days(expire_date).should be_true
  end

  it "should return false if expire date is not with in current date and current date + 30 days" do
    expire_date = Date.current + 50
    subject.expires_within_maximum_number_days(expire_date).should be_false
  end

  it "should return (episode date + 120 days) as expire date using rap sent date and episode start date" do
    rap_sent_date = Date.current
    episode_start_date = Date.current - 5
    subject.expire_date(rap_sent_date, episode_start_date).should == (episode_start_date + 120)
  end

  it "should return (RAP sent date + 120 days) expire date using rap sent date and episode start date" do
    rap_sent_date = Date.current + 60
    episode_start_date = Date.current - 5
    subject.expire_date(rap_sent_date, episode_start_date).should == (rap_sent_date + 60)
  end

  it "should return true if expire date is less than today date" do
    expire_date = Date.current - 5
    subject.should be_expired(expire_date)
  end

  it "should return jasper report url" do
    subject.jasper_report_url.should == "#{Rails.root}/app/views/reports/expired_and_expiring_rap/expired_and_expiring_raps.jasper"
  end

  it "should return XML root" do
    subject.xml_root.should == "expired_and_expiring_raps"
  end

end