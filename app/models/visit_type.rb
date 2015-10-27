# == Schema Information
#
# Table name: visit_types
#
#  id                     :integer          not null, primary key
#  visit_type_code        :string(20)       not null
#  visit_type_description :string(50)       not null
#  org_id                 :integer          not null
#  payable_rate           :decimal(8, 2)
#  lock_version           :integer          default(0)
#  discipline_id          :integer
#  optional_flag          :boolean          default(FALSE)
#

class VisitType < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :org
  has_and_belongs_to_many :license_types
  belongs_to :discipline
  has_many :state_transitions, :class_name => "VisitTypeStateTransition", :dependent => :destroy
  has_many :visit_type_document_definitions, :dependent => :destroy
  has_many :document_definitions, :through => :visit_type_document_definitions
  has_many :org_visit_types, :class_name => "OrgFieldStaffVisitType", :dependent => :destroy

  audited :associated_with => :org, :allow_mass_assignment => true

  after_validation :validate_license_type
  before_create :set_org

  scope :org_scope, lambda { includes(:org).where({:orgs => {:id => Org.current.id}}) if Org.current}
  scope :active_scope, lambda { |org_id| where({visit_type_status: "A", org_id: org_id})}
  scope :sort_scope, lambda { org_scope.order(:visit_type_status, :visit_type_code)}
  scope :filter_based_on_visit_type_status, lambda {|visit_type_status_arr| sort_scope.where({:visit_type_status => visit_type_status_arr})}

  scope :without_discipline, lambda {org_scope.where({:discipline_id => nil}) if Org.current}

  scope :mandatory, lambda {org_scope.where({:optional_flag => false}) if Org.current}

  validates :visit_type_code, :presence => true, :length => {:maximum => 20}
  validates :visit_type_description, :presence => true, :length => {:maximum => 50}
  validates :sort_order, :presence => true

  # For getting netzke action columns we are using AASM, we can use boolean also.
  include AASM
  STATE_MAP = {:active => 'A', :inactive => 'D'}
  aasm :column => :visit_type_status do
    state :active, :initial => true
    state :inactive

    event :inactivate do
      transitions :to => :inactive, :from => :active
    end

    event :activate do
      transitions :to => :active, :from => :inactive
    end

  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr == :visit_type_status
    write_attribute_without_mapping(attr, v)
  end

  def visit_type_status
    STATE_MAP.invert[read_attribute(:visit_type_status)]
  end


  def formatted_payable_rate
    number_to_currency(payable_rate, :format => "%n")
  end


  def validate_license_type
    if discipline and license_types.empty?
      self.errors.add(:base, "Atleast one license type required.")
    end
  end

  def mandatory_documents
    visit_type_document_definitions.select{|d| d.mandatory?}.collect{|d| d.document_definition}
  end

  def visit_type_display
    v_code = visit_type_code.split("_").first
     discipline_id.nil? ? "#{visit_type_description}" : "#{v_code} #{visit_type_description}"
  end

  def visit_type_short_display
    visit_type_code.gsub("_", " ")
  end

  def to_s
    visit_type_description
  end

  def allowed_for?(treatment_context)
    current_state = treatment_context.aasm_current_state
    state_transitions.empty? or
        state_transitions.any?{|st| current_state == st.from_state or st.from_state == VisitTypeStateTransition::ANY_STATE}
  end

  def applicable_transitions_for(treatment_context)
    any = VisitTypeStateTransition.state_map[VisitTypeStateTransition::ANY_STATE]
    current_status = VisitTypeStateTransition.state_map[treatment_context.aasm_current_state]
    possible_transitions = state_transitions.where(["from_state IN ('#{current_status}', '#{any}') AND to_state <> '#{any}'"])
    sorted_transitions = []
    treatment_context.class::STATE_MAP.values.each{|v|
      sorted_transitions << possible_transitions.select{|st| st.class.state_map[st.to_state] == v }
      possible_transitions -= sorted_transitions
    }
    sorted_transitions.flatten
  end

  def self.get_visit_types(discipline_id)
    self.active_scope(Org.current.id).where(:discipline_id  => discipline_id).collect{|x| [x.id, x.to_s]}
  end

  def self.get_visit_types_for_visit(visited_staff, treatment_id)
    visited_staff_class_name, visited_staff_id = visited_staff.split("_")
    visited_staff = visited_staff_class_name.constantize.find(visited_staff_id)
    treatment = PatientTreatment.find(treatment_id)
    staffs = treatment.treatment_staffs.staffed.select{|s| s.staff == visited_staff}
    visit_types = staffs.collect{|s|
      if s.discipline.present? and (s.visit_type.present? and s.visit_type.active?)
        s.visit_type
      elsif s.discipline.nil? and (s.visit_type.present? and s.visit_type.active?)
        s.visit_type
      else
        s.discipline.visit_types.where(["org_id = ? and visit_type_status = ?", treatment.patient.org.id, 'A'])
      end
    }.flatten

    if visited_staff.is_a?(FieldStaff)
      visit_types.select!{|vt| vt.license_types.include?(visited_staff.license_type)}
    end

    visit_types = visit_types.select {|vt|
      treatment_context = if vt.discipline
                            treatment.treatment_disciplines.find_by_discipline_id(vt.discipline_id)
                          else
                            treatment
                          end
      vt.allowed_for?(treatment_context)
    }    
    visit_types
  end

  def self.visit_type_list
    list = org_scope.order("visit_type_description")
    list.collect{|vt| [vt.id, "#{vt.visit_type_code} #{vt.visit_type_description}"] }
  end

  def field_staff_visit_type_rate(params)
    org_visit_type =  org_visit_types.fs_scope(params[:staff], params[:org]).first
    if org_visit_type.present?
      params[:treatment].hourly_rate_for_fs? ? org_visit_type.hourly_rate :
          org_visit_type.visit_rate
    end
  end

  def field_staff_amount_for_visit(params)
    org_visit_type =  org_visit_types.fs_scope(params[:staff], params[:org]).first
    if org_visit_type.present?
      params[:treatment].hourly_rate_for_fs? ? org_visit_type.calculate_payable_amount(params[:time_in_hour]) :
          org_visit_type.visit_rate
    end
  end

private
  def set_org
    self.org = Org.current unless org_id
  end
end
