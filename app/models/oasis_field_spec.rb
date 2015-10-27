# == Schema Information
#
# Table name: oasis_field_specs
#
#  id                :integer          not null, primary key
#  field_sequence    :integer
#  field_name        :string(100)      not null
#  length            :integer
#  start_position    :integer
#  end_position      :integer
#  rfa_1             :boolean
#  rfa_2             :boolean
#  rfa_3             :boolean
#  rfa_4             :boolean
#  rfa_5             :boolean
#  rfa_6             :boolean
#  rfa_7             :boolean
#  rfa_8             :boolean
#  rfa_9             :boolean
#  rfa_10            :boolean
#  record_type       :string(1)
#  default_value     :string(255)
#  data_type         :string(5)
#  field_description :string(255)
#

class OasisFieldSpec < ActiveRecord::Base

  scope :header, where("record_type = 'H'").order(:field_sequence)
  scope :body, where("record_type = 'B'").order(:field_sequence)
  scope :trailer, where("record_type = 'T'").order(:field_sequence)

  audited :allow_mass_assignment => true

end
