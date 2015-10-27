require 'spec_helper'

describe 'Private Insurance Invoice' do

  it "should have self table name as " do
    @private_ins = FactoryGirl.build(:private_insurance_invoice)
    @private_ins.class.table_name == "invoices"
  end

end