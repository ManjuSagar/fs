# == Schema Information
#
# Table name: audit_logs
#
#  id           :integer          not null, primary key
#  log_type     :string(50)       not null
#  lock_version :integer          default(0)
#

class TreatmentAuditLog < AuditLog

end
