desc "Draft Patient Destroy After an Hour"
task :draft_patient_destroy_after_an_hour => [:environment] do
 patients = Patient.where(["draft_status = ? AND created_at <= ?", true, 1.hour.ago])
 patients.destroy_all
end

desc "Draft Org Destroy After an Hour"
task :draft_orgs_destroy_after_an_hour => [:environment] do
 orgs = Org.where(["draft_status = ? AND created_at <= ?", true, 1.hour.ago])
 orgs.destroy_all
end

desc "Draft Insurance Company Destroy After an Hour"
task :draft_ins_companies_destroy_after_an_hour => [:environment] do
  ins_companies = InsuranceCompany.where(["draft_status = ? AND created_at <= ?", true, 1.hour.ago])
  ins_companies.destroy_all
end

desc "Draft Visits Destroy After an Hour"
task :draft_visits_destroy_after_an_hour => [:environment] do
  visits = TreatmentVisit.where(["draft_status = ? AND visit_start_time <= ?", true, 1.hour.ago])
  visits.destroy_all
end

desc "Delete Old Staffing Requests"
task :delete_old_staffing_requests => [:environment] do
  requests = StaffingRequest.where(["date(requested_date_time) < ?", 30.days.ago])
  requests.destroy_all
end