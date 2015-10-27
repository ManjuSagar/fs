module EpisodeColumns

  def treatment_request_id
    treatment.treatment_request_id
  end

  def staffing_flag
    't'
  end

  def soc_date
    treatment.treatment_start_date.strftime("%m/%d/%Y")
  end

  def treatment_status
    status = treatment.treatment_status
    "<font color=#{PatientTreatment::STATUS_DISPLAY_COLOR[status]}>#{PatientTreatment::STATUS_DISPLAY[status]}"
  end

  def referral_received_flag
    't'
  end

  def eligibility_check_flag
    't'
  end

  def oasis_document_completed_flag
    res = false
    document = documents.detect{|d| d.oasis_evaluation? or d.oasis_recertification? or d.oasis_resumption_of_care?}
    if document
      res = document.completed? ? true : "n"
    end
    res
  end

  def plan_of_care_completed_flag
    return false if documents.empty?
    documents.any? {|d| d.respond_to?("is_poc?")}
  end

  def discharged_flag
    treatment.discharged? || episode_status == TreatmentEpisode::RECERT
  end

  def final_claim_sent_flag
    [:lupa_billed, :final_claim_billed].include?(self.medicare_bill_status)
  end

  def disciplines_display
    treatment_disciplines.collect{|x| {d: x.discipline.discipline_code, s: TreatmentDiscipline::STATE_MAP[x.treatment_status], o: x.discipline.sort_order}}.sort_by { |x| x[:o]}.to_json
=begin
    ActiveRecord::Base.connection.execute("SELECT d.discipline_code, td.treatment_status FROM disciplines d INNER JOIN
      treatment_disciplines td ON d.id = td.discipline_id WHERE td.treatment_episode_id = 53").to_json
=end
  end

  def certification_open_flag
    treatment.pending_evaluation? == false
  end

  def rap_status
    [:rap_billed, :lupa_billed, :final_claim_billed].include?(self.medicare_bill_status)
  end

  def documents_status
    return false if documents.empty?
    res = ActiveRecord::Base.connection.execute("SELECT d.id FROM documents d WHERE d.status = 'A' AND d.treatment_episode_id = #{self.id}")
    return true if res.to_a.size == documents.size
    "n"
  end

  def medical_orders_status
    return true if medical_orders.empty?
    res = ActiveRecord::Base.connection.execute("SELECT mo.id FROM medical_orders mo WHERE mo.order_status = 'C' AND mo.treatment_episode_id = #{self.id}")
    return true if res.to_a.size == medical_orders.size
    return "n" if res.to_a.size != medical_orders.size
    false
  end

  def events
    treatment.events_for_current_state.collect{|x| x.name.to_s}.join(",") if treatment_last_episode?
  end
end