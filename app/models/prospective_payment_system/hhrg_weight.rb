class ProspectivePaymentSystem::HhrgWeight < ActiveRecord::Base
  belongs_to :hipps_code
  attr_accessible :calender_year, :weight, :hipps_code

end
