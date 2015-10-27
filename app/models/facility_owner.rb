# == Schema Information
#
# Table name: orgs
#
#  id                   :integer          not null, primary key
#  org_name             :string(100)      not null
#  org_type             :string(50)       not null
#  org_package          :string(2)        not null
#  week_start_day       :string(3)        not null
#  suite_number         :string(15)
#  street_address       :string(50)       not null
#  city                 :string(50)       not null
#  state                :string(2)        not null
#  zip_code             :string(10)       not null
#  email                :string(100)      not null
#  preferred_alert_mode :string(1)        not null
#  notes                :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  phone_number         :string(15)
#  fax_number           :string(15)
#  lock_version         :integer          default(0)
#

class FacilityOwner < Org
  has_many :super_admins
end
