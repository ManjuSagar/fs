require 'spec_helper'

describe "AlirtsReportByPrimarySource" do
  describe "#get_treatments_by_insurance" do
    it "should return patient treatment active record relation array" do
      User.current = User.find_by_email('fnpublic+help2@gmail.com')
      alirts_obj = ReportDataSource::AlirtsReportByPrimarySource.new(2014, 2)
      output = alirts_obj.get_treatments_by_insurance('MEDICARE')
      expect(output.is_a?(ActiveRecord::Relation)).to eq true
    end
  end

  describe "#get_visits_by_source" do
    it "should return integer" do
      User.current = User.find_by_email('fnpublic+help2@gmail.com')
      alirts_obj = ReportDataSource::AlirtsReportByPrimarySource.new(2014, 2)
      output = alirts_obj.get_treatments_by_insurance('MEDICARE')
      expect(alirts_obj.get_visits_by_source(output).is_a?(Integer)).to eq true
    end
  end
end