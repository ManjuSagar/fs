# == Schema Information
#
# Table name: ha_sc_contract_doc_defn_rates
#
#  id                     :integer          not null, primary key
#  contract_id            :integer          not null
#  document_definition_id :integer          not null
#  chargeable_rate        :decimal(8, 2)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  lock_version           :integer          default(0), not null
#

class HaScContractDocumentDefinitionRate < ActiveRecord::Base
  set_table_name "ha_sc_contract_doc_defn_rates"

  belongs_to :staffing_company_contract, :foreign_key => :contract_id
  belongs_to :document_definition

  audited :associated_with => :staffing_company_contract, :allow_mass_assignment => true
end
