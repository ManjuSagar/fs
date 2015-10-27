class ErrorModel < ActiveRecord::Base
  self.table_name = "users"

  attr_accessor :row_num, :msg

  netzke_attribute :row_num
  netzke_attribute :msg

end