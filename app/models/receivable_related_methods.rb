module ReceivableRelatedMethods

  def system_driven_event?
    self.system_driven_event == true
  end

  def payer_name
    payer.full_name if payer.present?
  end

  def patient_name
    treatment.to_s
  end

end