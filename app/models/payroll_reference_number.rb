# == Schema Information
#
# Table name: reference_numbers
#
#  id             :integer          not null, primary key
#  org_id         :integer          not null
#  reference_date :date             not null
#  sequence       :integer          default(0), not null
#  reference_type :string(255)      not null
#  lock_version   :integer
#

class PayrollReferenceNumber < ReferenceNumber

  audited :allow_mass_assignment => true

  def self.next_sequence(payroll)
    sequence_number = super(self)
    sequence_number.to_s
  end
end
