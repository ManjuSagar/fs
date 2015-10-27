# == Schema Information
#
# Table name: user_ethnicities
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  ethnicity_id :string(255)      not null
#  lock_version :integer          default(0), not null
#

class UserEthnicity < ActiveRecord::Base
   belongs_to :user
   belongs_to :ethnicity
end
