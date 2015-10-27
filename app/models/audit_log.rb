# == Schema Information
#
# Table name: audit_logs
#
#  id           :integer          not null, primary key
#  log_type     :string(50)       not null
#  lock_version :integer          default(0)
#

class AuditLog < ActiveRecord::Base
  self.inheritance_column = :log_type

  audited :allow_mass_assignment => true

end
