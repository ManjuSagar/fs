# == Schema Information
#
# Table name: zip_codes
#
#  id           :integer          not null, primary key
#  locality     :string(50)       not null
#  zip_code     :string(10)       not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default(0)
#  admin_name_1 :string(255)
#  admin_code_1 :string(255)
#  admin_name_2 :string(255)
#  admin_code_2 :string(255)
#  lat          :decimal(10, 6)
#  lng          :decimal(10, 6)
#

class ZipCode < ActiveRecord::Base

  validates :locality, :presence => true, :length => {:maximum => 50}
  validates :zip_code, :presence => true, :length => {:maximum => 10}

  audited :allow_mass_assignment => true

end
