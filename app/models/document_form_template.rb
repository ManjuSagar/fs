# == Schema Information
#
# Table name: document_form_templates
#
#  id                      :integer          not null, primary key
#  template_name           :string(30)       not null
#  template_description    :string(255)
#  document_class_name     :string(100)      not null
#  input_template_content  :text
#  report_template_content :text
#  status                  :string(2)        not null
#  report_file_name        :string(100)
#  lock_version            :integer          default(0)
#

class DocumentFormTemplate < ActiveRecord::Base
  before_create :set_status
  has_many :document_definitions

  validates :template_name, :presence => true
  validates :document_class_name, :presence => true
  validates :report_file_name, :length => {:maximum => 100}
  validates :template_description, :length => {:maximum => 255}

  audited :allow_mass_assignment => true
  has_associated_audits

  def to_s
    self.template_name
  end

 private

  def set_status
    self.status = "A"
  end

end
