class ProspectivePaymentSystem::MedicareAreasWageIndex < ActiveRecord::Base
  attr_accessible :calender_year, :cbsa_code, :wage_index
  belongs_to :cbsa_code, :foreign_key => :cbsa_code_id, :class_name => "MedicareCoreStatArea"
end