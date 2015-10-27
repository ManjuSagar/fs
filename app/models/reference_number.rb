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

class ReferenceNumber < ActiveRecord::Base
  set_inheritance_column "reference_type"

  belongs_to :org
  validates_uniqueness_of :org_id, :scope => :reference_type, :on => :create

  audited :associated_with => :org, :allow_mass_assignment => true

  def self.next_sequence(klass)
      scheme = scheme_instance(klass)
      number_of_tries = 0
      begin
        scheme.sequence += 1
        scheme.save!
      rescue ActiveRecord::StaleObjectError => e
        debug_log e.inspect
        number_of_tries += 1
        if number_of_tries > 5
          raise ReferenceNumberGenerationException
        end
        retry
      end
      scheme.sequence
  end

  class ReferenceNumberGenerationException < Exception
    def message
      "Error generating reference number"
    end
  end

  def self.scheme_instance(klass)
    scheme = self.find_by_org_id_and_reference_type(Org.current.id, klass)
    unless scheme
      begin
        scheme = klass.create!(:org => Org.current, :reference_date => Date.current)
      rescue ActiveRecord::RecordInvalid => e
        debug_log e.inspect
        scheme = scheme_instance(klass)
      end
    end
    scheme
  end

end
