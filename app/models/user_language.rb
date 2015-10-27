# == Schema Information
#
# Table name: user_languages
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  language_id  :integer          not null
#  lock_version :integer          default(0), not null
#

class UserLanguage < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  audited :associated_with => :user, :allow_mass_assignment => true
end
