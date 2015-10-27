require 'spec_helper'

describe "ReimbursementSettlement" do

  before(:each) do
    @date = Date.parse("'2014'")
    Org.current = FactoryGirl.build(:health_agency)
  end

  describe "reimbursement_settelement" do
    it "should_return_array_of_visits_cost" do
      cost_report = CostReportDataSource.new(:date=> @date)
      cost_report.msa_codes_list
      cost_report.reimbursement_settlement
      res = cost_report.treatment_visits_count
      expect(res.is_a?(Array)).to eq true
    end
  end
end