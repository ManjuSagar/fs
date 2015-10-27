orgs = HealthAgency.all

org = Org.find_by_org_name("Bonum Home Health Services")
user = org.org_users.unscoped.where(role_type: "A", org_id: org.id).first.update_column(:user_status, "A")

orgs.each do |x|
  org_user = x.org_users.where(role_type: "A")
  email = org_user.first.user.email if org_user
  User.current =  User.find_by_email(email)
  Patient.org_scope.each do |patient|
    DenormalizedPatientList.create_with(patient)
  end
end