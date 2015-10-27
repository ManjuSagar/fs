# == Schema Information
#
# Table name: visit_type_document_defns
#
#  id                     :integer          not null, primary key
#  mandatory_flag         :boolean          default(FALSE)
#  visit_type_id          :integer          not null
#  document_definition_id :integer          not null
#  lock_version           :integer          default(0)
#

class VisitTypeDocumentDefinition < ActiveRecord::Base
  self.table_name = "visit_type_document_defns"

  belongs_to :visit_type
  belongs_to :document_definition
  audited :associated_with => :visit_type, :allow_mass_assignment => true

  scope :org_scope, lambda { includes(:visit_type => :org).where(:visit_types => {:orgs => {:id => Org.current.id}}) if Org.current}

  def mandatory?
    mandatory_flag == true
  end
end
