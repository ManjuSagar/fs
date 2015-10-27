# == Schema Information
#
# Table name: staffing_masters
#
#  id                :integer          not null, primary key
#  staffable_type    :string(100)      not null
#  staffable_id      :integer          not null
#  created_date_time :datetime         not null
#  staffing_status   :string(1)        not null
#  narrative         :text
#  lock_version      :integer          default(0), not null
#

class StaffingMaster < ActiveRecord::Base
  belongs_to :staffable, :polymorphic => true
  has_many :staffing_requirements, :dependent => :destroy

  audited :associated_with => :staffable, :allow_mass_assignment => true
  has_associated_audits


  before_create :set_date

  validates :staffable, :presence => true

  def health_agency
    staffable.health_agency if staffable
  end

  def language_preference_specified?
    staffable.language_preference_specified?
  end

  def gender_requirements
    staffable.gender_requirements
  end

  def languages_preferred
    staffable.languages_preferred
  end

  def special_instructions_required
    staffable.special_instructions_required
  end


  def gender_preference_specified?
    staffable.gender_preference_specified?
  end

  def patient
    staffable.patient if staffable
  end

  def patient_full_name
    staffable.patient.full_name
  end

  def broadcast_requirements
    staffing_requirements.each{|s| s.broadcast_request! if s.may_broadcast_request?}
    send_email_notifications
  end

  def send_email_notifications
    staffing_requirements.each {|sr| sr.send_email_notifications }
  end

  def reject_unselected_staffs
    staffing_requirements.each{|sr| sr.finalize_staffing! if sr.may_finalize_staffing?}
  end

  def staffed?
    staffing_requirements.all? {|s| s.staffed?}
  end

  def set_date
    self.created_date_time = Time.current
    self.staffing_status = "A"
  end

end
