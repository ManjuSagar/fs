class MedicareRemittance < ActiveRecord::Base
  class RemittanceExistException < Exception
    def message
      "Remittance File Already Exists."
    end
  end
  include ActionView::Helpers::NumberHelper

  has_attached_file :medicare_remittance

  has_many :medicare_remittance_claims, dependent: :destroy
  has_many :invoices, :through => :medicare_remittance_claims
  has_many :medicare_remittance_provider_adjustments, dependent: :destroy
  belongs_to :org

  audited :associated_with => :org, :allow_mass_assignment => true

  after_initialize :set_defaults, :if => :new_record?
  after_validation :check_remittance_already_exists
  after_create :parse_the_edi_and_store_fields_in_db

  scope :org_scope, lambda { where(["org_id = ?", Org.current.id])}

  def check_eft_date_display
    check_eft_date.strftime("%m/%d/%Y") if check_eft_date
  end

  def formatted_amount(amount)
    amount ||= 0
    number_to_currency(amount)
  end

  private

  def set_defaults
    self.org = Org.current
  end

  def check_remittance_already_exists
    begin
      parser = MedicareRemittanceParser.new(self)
      res =  self.class.where(["check_eft_date = ? and check_eft_number = ?",
                               parser.remit_transaction_date, parser.cheque_or_eft_number]).first.present?
      if res
        raise RemittanceExistException
      end
    rescue RemittanceExistException => e
      self.errors.add(:base, e.message)
    end
  end

  def parse_the_edi_and_store_fields_in_db
    transaction do
      MedicareRemittanceDetailsStoreInDB.new(self)
    end
  end

  def convert_date_format_to_db_format(date)
    res = date.split("/")
    "#{res[2]}-#{res[0]}-#{res[1]}"
  end

end