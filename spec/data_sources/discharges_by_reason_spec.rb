require 'spec_helper'

describe "DischargesByReason" do

  describe "#dischanges_by_reason" do

    it "should return array" do

      alirts_obj = ReportDataSource::DischargesByReason.new(2014)

      Org.current.stub(:id).and_return(4106)

      expect(alirts_obj.dischanges_by_reason.is_a?(Array)).to eq true
    end

  end

end