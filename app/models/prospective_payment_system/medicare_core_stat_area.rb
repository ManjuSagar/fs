# == Schema Information
#
# Table name: medicare_core_stat_areas
#
#  id            :integer          not null, primary key
#  cbsa_code     :string(255)
#  county_code   :string(255)
#  county_name   :string(255)
#  state_code    :string(255)
#  calander_year :integer
#  wage_index    :decimal(, )
#

class ProspectivePaymentSystem::MedicareCoreStatArea < ActiveRecord::Base
  has_many :wage_indices, :foreign_key => :cbsa_code_id, :class_name => "MedicareAreasWageIndex"

  RURAL_AREAS_CBSA_CODES2015 = [50001, 50002, 50005, 50007, 50025, 50028, 50031, 50035, 50036, 50037, 50041, 50045, 50047,
                                50048, 50050, 50056, 50057, 50066, 50068, 50071, 50073, 50080, 50084, 50087, 50089, 50090,
                                50091, 50103, 50104, 50111, 50115, 50117, 50118, 50120, 50121, 50139, 50146, 50147, 50149,
                                50151, 50164, 50165, 50168, 50169, 50173, 50174, 50177, 50180, 50182, 50183]

  def rural_area?
    self.cbsa_code.starts_with?("99") or RURAL_AREAS_CBSA_CODES2015.include? self.cbsa_code.to_i
  end
end
