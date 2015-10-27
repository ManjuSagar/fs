require 'spec_helper'

describe MedicalOrder do
  let!(:medical_order){FactoryGirl.build(:medical_order)}
  subject {medical_order}

  it "should return patient full name" do
    medical_order.stub(:treatment).and_return(PatientTreatment.new)
    medical_order.treatment.stub(:patient)
    medical_order.treatment.patient.stub(:full_name).and_return("Johnson Sam")
    medical_order.patient_name.should == "Johnson Sam"
  end

  it "should return Physician full name" do
    medical_order.stub(:physician)
    medical_order.physician.stub(:full_name).and_return("Edward Alexander")
    medical_order.physician_name.should == "Edward Alexander"
  end

  it "expect Medical Order Ready to Send when signed" do
    medical_order = FactoryGirl.build(:medical_order, :order_status => :draft)
    medical_order.stub(:attach_printable_order)
    expect { medical_order.sign}.to change {medical_order.order_status}.from(:draft).to(:ready_to_send)
  end
end
