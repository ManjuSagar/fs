# == Schema Information
#
# Table name: visit_type_state_transitions
#
#  id            :integer          not null, primary key
#  visit_type_id :integer          not null
#  from_state    :string(1)        not null
#  to_state      :string(1)        not null
#

class VisitTypeStateTransition < ActiveRecord::Base
  belongs_to :visit_type

  audited :associated_with => :visit_type, :allow_mass_assignment => true

  ANY_STATE = :any_state
  def self.state_map
    {ANY_STATE => "*"}.merge(state_class::STATE_MAP)
  end

  def self.state_class
    TreatmentDiscipline
  end

  def self.states
   state_map.keys.collect{|k| [k, k.to_s.titleize]}
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = self.class.state_map[v.to_sym] if attr.to_sym == :from_state or attr.to_sym == :to_state
    write_attribute_without_mapping(attr, v)
  end

  def from_state
    self.class.state_map.invert[read_attribute(:from_state)]
  end

  def to_state
    self.class.state_map.invert[read_attribute(:to_state)]
  end
end
