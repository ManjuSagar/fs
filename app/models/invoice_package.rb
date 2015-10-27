class InvoicePackage < ActiveRecord::Base
  has_many :private_insurance_invoices
  has_many :private_receivables
  belongs_to :insurance_company

  scope :org_scope, lambda{ where(:org_id => Org.current.id) }

end