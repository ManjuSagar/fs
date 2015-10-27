# == Schema Information
#
# Table name: document_form_tpl_sets
#
#  id              :integer          not null, primary key
#  set_name        :string(50)       not null
#  set_description :string(100)      not null
#  remarks         :string(200)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  lock_version    :integer          default(0)
#

class DocumentFormTemplateSet < ActiveRecord::Base
  self.table_name = "document_form_tpl_sets"
  has_and_belongs_to_many :document_form_templates, :join_table => "doc_form_tpl_set_details", :foreign_key => :document_form_tpl_set_id

  validates :set_name, :presence => true, :length => {:maximum => 50}
  validates :set_description, :presence => true, :length => {:maximum => 100}

  audited :allow_mass_assignment => true

end
