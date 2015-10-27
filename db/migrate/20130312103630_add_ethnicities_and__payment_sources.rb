class AddEthnicitiesAndPaymentSources < ActiveRecord::Migration
  def up
    Ethnicity.destroy_all
    Ethnicity.create(id: "1", description: "American Indian or Alaska Native")
    Ethnicity.create(id: "2", description: "Asian")
    Ethnicity.create(id: "3", description: "Black or African-American")
    Ethnicity.create(id: "4", description: "Hispanic or Latino")
    Ethnicity.create(id: "5", description: "Native Hawaiian or Pacific Islander")
    Ethnicity.create(id: "6", description: "White")

#Payment Source
    PaymentSource.destroy_all
    PaymentSource.create(id: "0", description: "None; no charge for current services")
    PaymentSource.create(id: "1", description: "Medicare (traditional fee-for-service)")
    PaymentSource.create(id: "2", description: "Medicare (HMO/managed care/Advantage plan)")
    PaymentSource.create(id: "3", description: "Medicaid (traditional fee-for-service)")
    PaymentSource.create(id: "4", description: "Medicaid (HMO/managed care)")
    PaymentSource.create(id: "5", description: "Worker`s compensation")
    PaymentSource.create(id: "6", description: "Title programs (e.g., Title III, V, or XX)")
    PaymentSource.create(id: "7", description: "Other government (e.g., TriCare, VA, etc.)")
    PaymentSource.create(id: "8", description: "Private insurance")
    PaymentSource.create(id: "9", description: "Private HMO/managed care")
    PaymentSource.create(id: "10", description: "Self-pay")
    #PaymentSource.create(id: "11", description: "Other (specify)")
  end

  def down
  end
end
