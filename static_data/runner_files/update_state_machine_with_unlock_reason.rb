
STATE_MAP = {'N' => '3', 'I' => '2', 'R' => '4', 'C' => '5'}

oasis_docs = Document.where(["document_type in (?) and unlock_reason is not NULL", Document::OASIS_DOCUMENTS])
oasis_docs.each do |doc|
  unlock_reason = STATE_MAP[doc.unlock_reason]
  doc.update_column(:state_machine_id, unlock_reason)
  doc.update_column(:unlock_reason, unlock_reason)
end