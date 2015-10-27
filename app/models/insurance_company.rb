# == Schema Information
#
# Table name: insurance_companies
#
#  id                   :integer          not null, primary key
#  company_name         :string(100)      not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  lock_version         :integer          default(0)
#  certification_period :integer          default(0)
#  co_pay_applicable    :boolean
#  company_code         :string(10)       not null
#

class InsuranceCompany < ActiveRecord::Base
  
  order "id"
  belongs_to :org
  has_many :insurance_company_visit_type_rates, :dependent => :destroy
  has_many :insurance_case_managers, :dependent => :destroy
  has_many :invoice_packages
  has_many :authorization_trackings
  validates :company_name, :presence => true, :length => {:maximum => 100}
  validates :company_code, :presence => true, :length => {:maximum => 10}
  validates :certification_period, :numericality => { :greater_than_or_equal_to => 0 }
  validates :claim_payment_due_days, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999 }
  validate :check_street_address
  validate :check_city
  validate :check_state
  validate :valid_zip_code_check
  validate :check_billing_due_days

  scope :org_scope, lambda{where(['org_id =?', Org.current.id]).order("company_name") if Org.current}
  scope :ins_scope, lambda{org_scope.where(:draft_status => false)}
  after_initialize :set_org, :if => :new_record?

  audited :associated_with => :org, :allow_mass_assignment => true

  before_save :capitalize_company_code
  before_update :sample_ins_to_real_if_required

  FORM_TYPES = [["", "---"], ['U', 'UB04'], ['C', 'CMS 1500']]

  def self.apply_visit_type_rates(ins_co_id)
	co = InsuranceCompany.find(ins_co_id)
	
	co_visit_types = co.insurance_company_visit_type_rates.org_scope
	co_visit_type_ids = co_visit_types.map(&:visit_type_id)
	
	org_visit_types = Org.current.visit_types
	org_visit_type_ids = org_visit_types.map(&:id)
	
	common_visit_type_ids = co_visit_type_ids & org_visit_type_ids
	
	if (common_visit_type_ids.count != org_visit_type_ids.count)  
	  to_be_added_to_co = org_visit_type_ids - common_visit_type_ids
	  unless to_be_added_to_co.empty?
	    to_be_added_to_co.each {|type_id| co.insurance_company_visit_type_rates.create!(:visit_type_id => type_id)}
	  end
	end
	
	if (common_visit_type_ids.count != co_visit_type_ids.count)
	  to_be_removed_from_co = co_visit_type_ids - common_visit_type_ids
	  unless to_be_removed_from_co.empty?
	    visit_types_to_be_removed = co_visit_types.select{|t| to_be_removed_from_co.include?(t.visit_type_id)}	
		#co_visit_types.delete(visit_types_to_be_removed)
	  end	
	end
  end

  def full_name
    "#{company_name} (#{company_code})"
  end

  def medicare?
    billing_flow == "H"
  end

  def private_insurance?
    billing_flow == "V"
  end

  def set_org
    self.org = Org.current unless self.org
  end

  def to_s
    full_name
  end

  def sample_ins_to_real_if_required
    self.draft_status = false
    nil
  end

  def self.insurance_company_list
    list = org_scope.order("company_name")
    list.collect{|i| [i.id, i.full_name] }
  end

  def amount_for_visit(params)
    visit_type_rate = ins_company_visit_type_rate(params)
    if visit_type_rate.present?
      params[:treatment].hourly_rate_for_insurance? ? visit_type_rate.calculate_hourly_visit_amount(params[:time_in_hour]) : visit_type_rate.visit_rate
    end
  end

  def visit_type_rate(params)
    visit_type_rate = ins_company_visit_type_rate(params)
    if visit_type_rate.present?
      params[:treatment].hourly_rate_for_insurance? ? visit_type_rate.hourly_rate : visit_type_rate.visit_rate
    end
  end

  def ins_company_visit_type_rate(params)
    @visit_type_rates ||= {}
    visit_type_rate = @visit_type_rates[params[:visit_type_id]] || insurance_company_visit_type_rates.find_by_visit_type_id(params[:visit_type_id])
    @visit_type_rates[params[:visit_type_id]] = visit_type_rate
    visit_type_rate
  end

  def check_street_address
    if self.claim_street_address.blank?
      errors.add(:base, "Street Address can't be blank.")
    elsif self.claim_street_address.length > 1000
      errors.add(:base, "Street Address is too long (maximum is 1000 characters).")
    end
  end

  def check_city
    if self.claim_city.blank?
      errors.add(:base, "City can't be blank.")
    elsif self.claim_city.length > 50
      errors.add(:base, "City is too long (maximum is 50 characters).")
    end
  end

  def check_state
    errors.add(:base, "State can't be blank.") if self.claim_state.blank?
  end

  def valid_zip_code_check
    if self.claim_zip_code.blank?
      self.errors.add(:base, "ZIP Code can't blank.")
    else
      self.errors.add(:base, "ZIP Code is not valid.") unless ZipCode.find_by_zip_code(claim_zip_code.to_s)
    end
  end

  def check_billing_due_days
    if self.claim_submission_due_days.blank?
      self.errors.add(:base, "Billing due days can't be blank.");
    elsif self.claim_submission_due_days < 0
      self.errors.add(:base, "Billing due days must be greater than or equal to 0")
    elsif self.claim_submission_due_days > 999
      self.errors.add(:base, "Billing due days must be less than or equal to 999")
    end
  end


  private

  def capitalize_company_code
    company_code.upcase!  if company_code
  end


end