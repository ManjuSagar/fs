require 'spec_helper'
describe VisitFrequency do
  let!(:visit_frequency){ FactoryGirl.build(:visit_frequency)}
  subject{visit_frequency}

  it "Visit Frequency Month frequency should compute proper end date" do
    visit_frequency.frequency_string = "1M1"
    visit_frequency.frequency_end_date = visit_frequency.compute_end_date(Date.strptime("10/15/2013", "%m/%d/%Y"))
    visit_frequency.frequency_end_date.should be_present
  end

end