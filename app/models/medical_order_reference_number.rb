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

class MedicalOrderReferenceNumber < ReferenceNumber

  def self.next_sequence(medical_order)
    sequence_number = super(self)
    sequence_number.to_s
  end

end
