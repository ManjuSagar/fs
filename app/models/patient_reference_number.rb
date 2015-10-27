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

class PatientReferenceNumber < ReferenceNumber

  def self.next_sequence(patient_detail)
    sequence_number = super(self)
    sequence_number.to_s
  end

  def self.decrement_sequence(sequence)
    reference = find_by_org_id_and_reference_type(Org.current.id, "PatientReferenceNumber")
    reference.sequence = sequence
    reference.save!
  end

  def self.ref_record
    find_by_org_id_and_reference_type(Org.current.id, "PatientReferenceNumber")
  end

end
