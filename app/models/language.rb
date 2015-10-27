# == Schema Information
#
# Table name: languages
#
#  id                   :integer          not null, primary key
#  language_code        :string(2)        not null
#  language_description :string(50)       not null
#  lock_version         :integer          default(0)
#

class Language < ActiveRecord::Base
  scope :sort_ascending, order("language_description ASC")

  audited :allow_mass_assignment => true

  def to_s
    language_description
  end

  validates :language_code, :presence =>  true, :length => {:maximum => 2}
  validates :language_description, :presence =>  true, :length => {:maximum => 50}

end
