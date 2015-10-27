class Document < ActiveRecord::Base
  has_many :all_documents, :as => :documentable, :dependent => :delete_all
  belongs_to :field_staff
  belongs_to :supervised_user, :class_name => "FieldStaff"

  OASIS_DOCUMENTS = ["OasisEvaluation", "OasisResumptionOfCare", "OasisTransferredPatientWithDischarge",
                     "OasisTransferredPatientWithoutDischarge","OasisDeathAtHome", "OasisDischargeFromAgency",
                     "OasisOtherFollowup", "OasisRecertification"]
end

documents = Document.all
documents.each do |document|
  all_document = document.all_documents.first
  if ['D', 'S', 'P', 'F'].include? document.status
    document.update_column(:status, 'D')
    document.update_column(:fs_sign_required, true)
    document.update_column(:supervisor_sign_required, document.supervised_user.present?)
    all_document.update_column(:status, "Draft")
  else
    document.update_column(:fs_sign_required, false)
    document.update_column(:supervisor_sign_required, false)
    status = if all_document.status.start_with?("Export")
               'E'
             else
               all_document.update_column(:status, "Approved")
               'A'
             end
    document.update_column(:status, status)
  end
  Document::OASIS_DOCUMENTS.include?(document.document_type) ? document.update_column(:state_machine_id, '1') : document.update_column(:state_machine_id, '6')
end