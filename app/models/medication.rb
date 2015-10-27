# == Schema Information
#
# Table name: medications
#
#  id                 :integer          not null, primary key
#  drug_name          :string(100)      not null
#  dosage             :string(100)      not null
#  active_ingredients :string(200)      not null
#  status             :string(1)        not null
#  ndu_code           :string(15)       not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lock_version       :integer          default(0)
#

class Medication < ActiveRecord::Base

  STATUS = [['A', 'Active'], ['I', 'In Active']]

  audited :allow_mass_assignment => true

end
