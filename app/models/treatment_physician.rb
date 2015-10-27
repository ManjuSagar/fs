# == Schema Information
#
# Table name: treatment_physicians
#
#  id                    :integer          not null, primary key
#  treatment_id          :integer          not null
#  physician_id          :integer          not null
#  primary_referral_flag :boolean
#  require_cc_flag       :boolean
#  lock_version          :integer          default(0)
#

class TreatmentPhysician < ActiveRecord::Base
  belongs_to :treatment, :class_name => "PatientTreatment"
  belongs_to :physician
  audited :associated_with => :treatment, :allow_mass_assignment => true

  validates :physician, :presence => true

  scope :cc_physicians, lambda {where({:require_cc_flag => true}) if User.current}

  def primary?
    primary_referral_flag == true
  end

  def is_cc?
    primary? || require_cc_flag == true
  end

  def send_medical_order_report(os, medical_order)
      physician.send_medical_order(os, medical_order)
  end

  def physician_full_name
    values = Physician.physician_agency_specific.collect{|x| [x.id, x.full_name]}
    values
  end
end
