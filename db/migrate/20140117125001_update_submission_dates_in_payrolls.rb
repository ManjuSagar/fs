class UpdateSubmissionDatesInPayrolls < ActiveRecord::Migration
  def change
    visits = TreatmentVisit.where(:visit_status => "C")
    visits.each do |v|
      last_completed_doc = v.documents.order('id DESC').where(:status => "C").first
      submission_date = last_completed_doc.present?  ? last_completed_doc.fs_sign_date : v.visit_start_date
      v.payables.where("submission_date is null").update_all(:submission_date => submission_date)
    end
  end
end
