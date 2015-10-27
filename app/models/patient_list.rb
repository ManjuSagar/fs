module PatientList

  def treatment_id
    return nil unless active_treatment
    active_treatment.id
  end

  def treatment_request_id
    return nil if active_treatment
    active_referral.id
  end

  def staffing_flag
    return true if self.active_treatment
    active_referral.staffed?
  end

  def referral_received_flag
    return true if self.active_treatment
    active_referral.referral_received?
  end

  def eligibility_check_flag
    return true if self.active_treatment
    active_referral.eligibility_check_completed?
  end

  def start_of_care_completed_flag
    return false unless self.active_treatment
    active_treatment.pending_evaluation? == false
  end

  def plan_of_care_completed_flag
    return false unless self.active_treatment
    active_treatment.documents.any?{|d| d.respond_to?("is_poc?")}
  end

  def treatment_start_date
    return "" unless active_treatment
    active_treatment.treatment_start_date.strftime("%m/%d/%Y")
  end

  def discharged_flag
    return false unless self.active_treatment
    active_treatment.discharged?
  end

  def final_claim_sent_flag
    return false unless self.active_treatment
    episode = active_treatment.treatment_episodes.detect{|e| e.final_billed? }
    episode.present?
  end

  def disciplines
    if active_treatment
      active_treatment.treatment_disciplines.uniq_by{|x| x.discipline}.collect{|td| [td.discipline.discipline_code, td.treatment_status]}.to_nifty_json
    else
      active_referral.disciplines.collect{|d| [d.discipline_code]}.to_nifty_json
    end
  end

  def certification_open_flag
    return false unless self.active_treatment
    active_treatment.pending_evaluation? == false
  end

  def rap_status
    return false unless self.active_treatment
    episode = active_treatment.treatment_episodes.detect{|e| e.rap_bill_generated?}
    episode ? true : false
  end

  def documents_status
    return false unless self.active_treatment
    return false if active_treatment.documents.empty?
    return true if active_treatment.documents.all?{|d| d.completed? or d.exported?}
    "neither"
  end

  def medical_orders_status
    return false unless self.active_treatment
    return true if active_treatment.medical_orders.empty? or active_treatment.medical_orders.all?{|m| m.completed?}
    return "neither" if active_treatment.medical_orders.any?{|m| m.pending_physician_signature? or m.order_received?}
    false
  end
end