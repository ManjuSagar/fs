# == Schema Information
#
# Table name: health_agency_details
#
#  id                       :integer          not null, primary key
#  provider_number          :string(100)
#  agency_type              :string(1)
#  health_agency_id         :integer
#  document_form_tpl_set_id :integer
#  document_defn_set_id     :integer
#  lock_version             :integer          default(0)
#

class HealthAgencyDetail < ActiveRecord::Base
  belongs_to :health_agency, class_name: "Org"
  belongs_to :document_form_template_set, :foreign_key => :document_form_tpl_set_id
  belongs_to :document_definition_set, :foreign_key => :document_defn_set_id
  after_save :initial_setup_for_ha, :if => :not_new_record?
  after_update :save_agency_detail
  scope :org_scope, lambda { includes(:health_agency).where({:orgs => {:id => Org.current.id}}) if Org.current}
  scope :authorized_agencies, lambda {where('clm_billing_cert_alias_name is not null and clm_billing_cert_password is not null
                                   and claims_electronic_transmission=true and submitter_id is not null')}

  audited :associated_with => :health_agency, :allow_mass_assignment => true

  store :data, :accessors =>
      ["routesheet_mandatory", "clinical_fields_required_in_oasis"]

  netzke_attribute :routesheet_mandatory, type: :boolean
  netzke_attribute :clinical_fields_required_in_oasis, type: :boolean

  validates :provider_number, :length => {:maximum => 16}
  validates :cms_cert_number, :length => {:maximum => 6}
  validates :npi_number, presence: true, length: {:minimum => 10, :maximum => 10}, :if => :not_new_record?
  validates :submitter_id, presence: true, :unless => :new_record?
  validates :zip_code, presence: true, length: { is: 5, message: " must be 5 digits" }
  validates :zip_code_part2, presence: true,  length: { is: 4, message: " must be 4 digits" }
  validates :building_name, :length => {:maximum => 40}

  def can_do_billing?
    (clm_billing_cert_alias_name.present? and clm_billing_cert_password.present? and submitter_id.present?)
  end
  
  def can_submit_claims_electronilly?
    (can_do_billing? and claims_electronic_transmission)
  end

  netzke_attribute :org_name
  netzke_attribute :street_address
  netzke_attribute :suite_number
  netzke_attribute :city
  netzke_attribute :state
  netzke_attribute :zip_code
  netzke_attribute :zip_code_part2
  netzke_attribute :building_name

  delegate :org_name, :org_name=, :street_address, :street_address=, :suite_number, :suite_number=, :city, :city=,
     :state, :state=, :zip_code, :zip_code=, :zip_code_part2, :zip_code_part2=, :building_name, :building_name=, :to => :health_agency



  def save_agency_detail
    health_agency.save! if health_agency.changed?
  end

  private

  def initial_setup_for_ha
    create_document_definitions_if_required
    create_attachment_types
    create_insurance_companies
    create_order_types
    create_visit_types
    create_vital_signs_references
    create_supplies_if_required
  end

  def not_new_record?
    (not self.new_record?) and self.health_agency
  end

  def create_document_definitions_if_required
    return unless health_agency.document_definitions.empty?
    document_definition_set and document_definition_set.document_definitions.each {|d|
      health_agency.document_definitions.create!(d.attributes.reject{|k,v| ["id", "org_id"].include? k.to_s})
    }
  end

  def create_visit_types
    return if health_agency.document_definitions.empty?
    return unless health_agency.visit_types.empty?
    docs = health_agency.document_definitions
    Org.current.visit_types.each do |vt|
      nvt = health_agency.visit_types.build(vt.attributes.reject{|k,v| ["id", "org_id"].include? k.to_s})
      vt.license_types.each {|lt|
       nlt = nvt.license_types << lt
      }
      vt.visit_type_document_definitions.each {|vd|
        next unless docs.detect{|h| h.document_code == vd.document_definition.document_code}
        docs.detect{|h| h.document_code == vd.document_definition.document_code}
        nvd = nvt.visit_type_document_definitions.build
        nvd.mandatory_flag = vd.mandatory_flag
        nvd.document_definition = docs.detect{|h| h.document_code == vd.document_definition.document_code}
      }
      vt.state_transitions.each {|st|
        nvt.state_transitions.build(from_state: st.from_state, to_state: st.to_state)
      }
      nvt.save!
    end
  end

  def create_vital_signs_references
    return unless health_agency.vitals_reference_ranges.empty?
    return unless Org.current
    Org.current.vitals_reference_ranges.each do |vital|
      health_agency.vitals_reference_ranges.create!(vital.attributes.reject{|k,v| ["id", "org_id"].include? k.to_s})
    end
  end

  def create_supplies_if_required
    return unless health_agency.supplies.empty?
    return unless Org.current
    Org.current.supplies.each do |vital|
      health_agency.supplies.create!(vital.attributes.reject{|k,v| ["id", "org_id"].include? k.to_s})
    end
  end


  def create_insurance_companies
    return unless health_agency.insurance_companies.empty?
    medicare_ins_companies = Org.current.insurance_companies.where({:company_code => "MEDICARE"}) if Org.current
    ins = health_agency.insurance_companies.build(medicare_ins_companies.first.attributes.reject{|k, v| ["id", "org_id"].include? k.to_s}) unless medicare_ins_companies.blank?
    ins.save!
  end

  def create_attachment_types
    return unless health_agency.attachment_types.empty?
    Org.current.attachment_types.each do |attach_type|
      health_agency.attachment_types.create!(attach_type.attributes.reject{|k, v| ["id", "org_id"].include? k.to_s})
    end
  end

  def create_order_types
    return unless health_agency.order_types.empty?
    Org.current.order_types.each do |order_type|
      health_agency.order_types.create!(order_type.attributes.reject{|k, v| ["id", "org_id"].include? k.to_s})
    end
  end

end
