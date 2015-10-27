require 'spec_helper'

describe ReportDataSource::CostReportStasticalData do
  before(:each) do
    Org.current = FactoryGirl.build(:health_agency)
  end
  it "should return Array" do
    statistical_data = ReportDataSource::CostReportStasticalData.new(2014)
    expect(statistical_data.cost_visits.is_a? (Array)).to eq true
  end

  it "should not return an empty array" do
    statistical_data = ReportDataSource::CostReportStasticalData.new(2014)
    expect(statistical_data.cost_visits.size).should be > 0

  end

  it "should return all the descriptions in the array for statistical report" do
    statistical_data = ReportDataSource::CostReportStasticalData.new(2014)
    required_disciplines = ['Skilled Nursing','Physical Therapy','Occupational Therapy',
    'Speech Pathology','Medical Social Services','Home Health Aide','All Other Services',
    'Total Visits [Sum of Lines 1-7]','Home Health Aide Hours',
    'Unduplicated Census Count - Full Cost Reporting Period']
    stat_data_report = statistical_data.cost_visits
    flag = true
    stat_data_report.each_with_index {|sdr, index|
      flag = (sdr[:description] == required_disciplines[index])
      return if flag == false
    }
    expect(flag).to eq true
  end

end





