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

class TreatmentReferenceNumber < ReferenceNumber

  def self.next_sequence(treatment)
    sequence_number = super(self)
    treatment.patient.patient_detail.patient_reference + '-' + sequence_number.to_s.rjust(4, '0')
  end

end
