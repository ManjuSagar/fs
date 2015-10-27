class HaProfileSetting < Netzke::Basepack::TabPanel
  include Mahaswami::NetzkeBase
  def configuration
    s = super
    s.merge(
        title: "Settings",
        items: [
            user_profile
        ]+((Org.current.org_users.detect{|ou| ou.user == User.current}.role_type == "A") ? [:health_agency_profile.component] : [])
    )
  end

  component :health_agency_user_profile do
    {
        class_name: "HealthAgencyUserProfile",
    }
  end

  def user_profile
    (User.current.field_staff? && User.current.clinical_staff.present?)  ? (:field_staff_profile.component) : (:health_agency_user_profile.component)
  end

  component :field_staff_profile do
    {
        class_name: "FieldStaffProfile"
    }
  end

  component :health_agency_profile do
    {
        class_name: "HealthAgencyProfile"
    }
  end

end