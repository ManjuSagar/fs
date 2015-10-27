class AuthorizationTracking < ActiveRecord::Base

  belongs_to :insurance_company
  belongs_to :insurance_case_manager
  belongs_to :treatment_episode
  belongs_to :field_staff
  belongs_to :patient
  belongs_to :discipline

  validates :discipline_id, presence: true
  validates :patient_id, presence: true
  validates :insurance_company_id, presence: true
  validates :treatment_episode_id, presence: true
  validates :patient_number, presence: true
  validates :field_staff_id, presence: true
  validates :visit_count, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :org_scope, lambda {|org = Org.current| includes(:patient => :patient_detail).where({:patient_details => {:org_id => org.id}})}

  scope :approved_and_visit_done, lambda { |org| org_scope(org).where(["approval_received =? or visit_done =?",true,true])}

  scope :episode_scope, lambda{|params| org_scope(params[1]).where(["treatment_episode_id = ? and visit_done is null",params[0]]).
    includes(:discipline).order("disciplines.sort_order ASC", "start_date ASC")}

  scope :visits_not_done, lambda{ org_scope.where("visit_done is null")}

  scope :sort_filter_scope, lambda{ visits_not_done.includes(:discipline, patient: :treatments)
    .order("users.last_name ASC", "users.first_name ASC", "disciplines.sort_order ASC", "start_date ASC")}

  FLAG_COMBO_STORE =  [["", "---"], ["right", "<img style='width:15px;height:15px;'} class='checked_image_class'>"],
                        ["wrong", "<img style='width:15px;height:15px;'} class='cross_image_class'"]]

  def patient_full_name
    patient.full_name_with_out_mr_number if patient
  end

  def insurance_case_manager_name
    insurance_case_manager.name if insurance_case_manager
  end

  def insurance_company_code
    insurance_company.company_code if insurance_company
  end

  def insurance_case_manager_phone
    InsuranceCaseManager.find(self.insurance_case_manager_id).phone_number if self.insurance_case_manager_id
  end

  def discipline_display
   discipline.discipline_code
  end

  def field_staff_display
    field_staff_id == 0 ? 'Pending Staffing' : field_staff.to_s
  end

  def field_staff__full_name
    field_staff_id == 0 ? 'Pending Staffing' : field_staff.to_s
  end

end
