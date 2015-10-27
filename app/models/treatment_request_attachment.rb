# == Schema Information
#
# Table name: treatment_request_attachments
#
#  id                      :integer          not null, primary key
#  request_id              :integer          not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  attachment_name         :string(100)
#  created_at              :datetime
#  attachment_type_id      :integer          not null
#

require 'attachment'
class TreatmentRequestAttachment < ActiveRecord::Base
  include Attachment
  has_attached_file :attachment
  belongs_to :attachment_type
  belongs_to :treatment_request, :foreign_key => :request_id
  before_post_process :set_content_dispositon
  after_initialize :set_defaults, :if => :new_record?
 after_create  :set_referral_received_date
  audited :associated_with => :treatment_request, :allow_mass_assignment => true

  validates_attachment :attachment, presence: true
  validates :attachment_type, presence: true

  attr_accessor :referral_received_date
  attr_accessible :request_id

  netzke_attribute :referral_received_date
  validates :referral_received_date, :presence => true

  def set_referral_received_date
    month, day, year = self.referral_received_date.split("/")
    self.treatment_request.referral_received_date = Date.new(year.to_i, month.to_i, day.to_i)
    self.treatment_request.system_driven_event = true
    self.treatment_request.referral_received! if self.treatment_request.may_referral_received?
    self.treatment_request.system_driven_event = false
    self.treatment_request.save!
  end

  def self.referral_date
    Date.current
  end

end
