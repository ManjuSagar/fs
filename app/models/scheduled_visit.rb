class ScheduledVisit < ActiveRecord::Base

  belongs_to :treatment, :class_name => "PatientTreatment"
  belongs_to :treatment_episode
  belongs_to :visit_type
  belongs_to :field_staff
  belongs_to :treatment_visit, :foreign_key => :visit_id

  audited :associated_with => :treatment_episode, :allow_mass_assignment => true
  has_associated_audits

  validates :treatment, presence: true
  validates :treatment_episode, presence: true
  validates :visit_type, presence: true
  validates :field_staff, presence: true
  validates :scheduled_date, presence: true
  validates :scheduled_end_date, presence: true
  validate :check_entered_visited_user_can_do_visit
  validate :schedule_visit_time_in_and_time_out_format_check
  validate :check_visit_date_valid
  validate :check_visit_timing

  default_scope lambda { order("scheduled_date") }
  scope :org_scope, lambda { |org = Org.current| includes(treatment: {patient: :patient_detail}).where({patient_details: {org_id: org.id}})}
  scope :not_visited, lambda { |org = Org.current| org_scope(org).where(["visit_id is null"]) }
  scope :visited, lambda { org_scope.where(["visit_id not is null"]) }
  scope :episode_scope, lambda {|episode_id| org_scope.where({treatment_episode_id: episode_id})}

  def schedule_visit_entry_defaults(params)
    self.treatment_id = params[:treatment_id]
    self.treatment_episode_id = params[:treatment_episode_id]
  end

  def check_visit_timing
    if scheduled_date && scheduled_end_date
      res = "Selected visit timing is invalid, either change the time or the date"
      errors.add(:base, "Visit timing cannot be same") if (scheduled_date == scheduled_end_date && start_time == end_time)
      errors.add(:base, res) if (scheduled_date == scheduled_end_date && start_time > end_time)
      errors.add(:base, "Visit dates are invalid") if scheduled_date > scheduled_end_date
    end
  end

  private

  def schedule_visit_time_in_and_time_out_format_check
    return unless scheduled_date
    raise_time_format_error(start_time, "Time In")
    raise_time_format_error(end_time, "Time Out")
  end

  def raise_time_format_error(time, error_prefix = "")
    if (time.match(/^\d{4}$/) == nil or time[0..1].to_i > 23 or time[2..3].to_i > 59)
      errors.add(:base, "#{error_prefix} should be in 'HHMM' format")
    end
  end

  def check_entered_visited_user_can_do_visit
    return nil if self.field_staff.nil? or self.visit_type.nil?
    staff = treatment.treatment_staffs.any?{|ts| ts.staff == field_staff }
    if ((visit_type.license_types.include?(field_staff.license_type) == false) or staff.nil?)
      errors.add(:base, "Visited user can't do this visit.")
    end
  end

  def check_visit_date_valid
    errors.add(:scheduled_date, "should be with in the Episode.") if scheduled_date_not_with_in_episode?
    errors.add(:scheduled_date, "Should be before the discharge date") if scheduled_date_not_in_discharge_date?
  end

  def scheduled_date_not_with_in_episode?
    if scheduled_date && scheduled_end_date
      scheduled_date < treatment_episode.start_date or scheduled_end_date > treatment_episode.end_date
    end
  end

  def scheduled_date_not_in_discharge_date?
    if ((treatment.discharged? == true) and scheduled_date and scheduled_end_date)
      discharge_date = treatment.treatment_activities.where(:activity_type => "D").first.activity_date.to_date
      (scheduled_date > discharge_date) or (scheduled_end_date > discharge_date)
    end
  end

end