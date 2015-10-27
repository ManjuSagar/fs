# == Schema Information
#
# Table name: phone_numbers
#
#  id             :integer          not null, primary key
#  phone_type     :string(1)        not null
#  phone_number   :string(15)       not null
#  extension      :string(10)
#  default_number :boolean          default(FALSE), not null
#  org_id         :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  lock_version   :integer          default(0)
#

class PhoneNumber < ActiveRecord::Base
    belongs_to :health_agency
end
