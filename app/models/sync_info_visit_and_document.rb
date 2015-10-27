class SyncInfoVisitAndDocument

  def self.visit_created(visit, visit_flag)
    visit.documents.each{|d|
      set_document_staffs(visit, d, visit_flag)
    }
  end

  def self.document_created(document)
    visit = document.treatment_visit
    set_document_staffs(visit, document)
  end


  def self.set_document_staffs(visit, doc, visit_flag = nil)
    if visit
      doc.fs_change_from_visit_create = true
      if (doc.is_super_visory_doc?)
        doc.fs_sign_required = false
        doc.supervisor_sign_required = true
      else
        doc.field_staff = visit.visited_user
        doc.supervised_user = visit.supervised_user
        doc.document_date = visit.visit_date
        doc.fs_sign_required = true if (visit.visited_staff.is_a? FieldStaff and doc.field_signature_not_required? == false and doc.fs_sign_date.blank?)
        doc.supervisor_sign_required = true if (visit.supervised_user.present? and doc.field_signature_not_required? == false and doc.supervised_user_sign_date.blank?)
      end
      doc.save if visit_flag
    end
  end

  def self.update_documents_date(visit)
    visit.documents.each{|d|
      d.document_date = visit.visit_date
      d.save!
    }
  end

end