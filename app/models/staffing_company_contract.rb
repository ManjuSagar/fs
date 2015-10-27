# == Schema Information
#
# Table name: ha_sc_contracts
#
#  id                  :integer          not null, primary key
#  health_agency_id    :integer          not null
#  staffing_company_id :integer          not null
#  contract_date       :datetime         not null
#  effective_from_date :date
#  effective_to_date   :date
#

class StaffingCompanyContract < ActiveRecord::Base
  set_table_name "ha_sc_contracts"
  has_many :document_definition_rates, :class_name => "HaScContractDocumentDefinitionRate", :foreign_key => :contract_id
  has_many :visit_type_rates, :class_name => "HaScContractVisitTypeRate", :foreign_key => :contract_id
  belongs_to :health_agency
  belongs_to :staffing_company

  audited :associated_with => :staffing_company, :allow_mass_assignment => true
  has_associated_audits


  has_and_belongs_to_many :disciplines, :join_table => "ha_sc_contract_details", :foreign_key => :contract_id
  has_and_belongs_to_many :visit_types, :join_table => "ha_sc_contract_details", :foreign_key => :contract_id

  
  scope :org_scope, lambda {where({:health_agency_id => Org.current.id}) if Org.current}

  def qualified_for_staffing?(patient_address = nil)
    return false if patient_address.nil? == false and not (staffing_company.is_within_preferred_coverage_area?(patient_address))
    debug_log "Coverage Area OK"
    true
  end

  def document_definition_rate_exist?(document_definition)
    self.document_definition_rates.find_by_document_definition_id(document_definition.id).present?
  end

  def visit_type_rate_exist?(visit_type)
    self.visit_type_rates.find_by_visit_type_id(visit_type.id).present?
  end

  def applicable?(date)
    if effective_to_date.present?
      (effective_from_date .. effective_to_date).include? date
    else
      effective_from_date <= date
    end
  end

  def sc_fs_visit_type_rate(params)
    sc_visit_type = visit_type_rates.find_by_visit_type_id(params[:visit_type].id)
    params[:treatment].hourly_rate_for_fs? ? sc_visit_type.hourly_rate : sc_visit_type.visit_rate
  end

  def staffing_company_rate_for_visit(params)
    sc_visit_type = visit_type_rates.find_by_visit_type_id(params[:visit_type].id)
    params[:treatment].hourly_rate_for_fs? ? sc_visit_type.calculate_payable_amount(params[:time_in_hour]) : sc_visit_type.visit_rate
  end

end
