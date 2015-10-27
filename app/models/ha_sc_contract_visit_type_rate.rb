# == Schema Information
#
# Table name: ha_sc_contract_vt_rates
#
#  id              :integer          not null, primary key
#  contract_id     :integer          not null
#  visit_type_id   :integer          not null
#  chargeable_rate :decimal(8, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  lock_version    :integer          default(0), not null
#

class HaScContractVisitTypeRate < ActiveRecord::Base
  set_table_name "ha_sc_contract_vt_rates"

  belongs_to :staffing_company_contract, :foreign_key => :contract_id
  belongs_to :visit_type

  audited :associated_with => :staffing_company_contract, :allow_mass_assignment => true

  def calculate_payable_amount(time_in_hour)
    rate = self.hourly_rate
    rate ? time_in_hour * rate : 0
  end

end
