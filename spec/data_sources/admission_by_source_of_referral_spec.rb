require 'spec_helper'

describe "AdmissionsBySourceOfReferral" do

  describe "#admission_by_source_of_referral" do

    it "should return array" do

      alirts_obj = ReportDataSource::AdmissionsBySourceOfReferral.new(2014)

      expect(alirts_obj.admission_by_source_of_referral.is_a?(Array)).to eq true
    end

  end

end