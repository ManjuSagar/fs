class VisitDocumentsSignedDateMigratingFromVisitSignedDate < ActiveRecord::Migration
  def change
    Document.where("visit_id IS NOT NULL").each do |doc|
      if doc.treatment_visit
        visit = doc.treatment_visit
        doc.fs_sign_date = visit.fs_sign_date unless doc.fs_sign_date
        doc.os_sign_date = visit.os_sign_date unless doc.os_sign_date
        doc.supervised_user_sign_date = visit.supervised_user_sign_date unless doc.supervised_user_sign_date
        doc.save(:validate => false)
      end
    end
  end
end
