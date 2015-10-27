class ExpiringExpiredRapsReportDataSource

  include ReportRelatedBasicMethods

  NUMBER_OF_DAYS = 30

  def initialize
    @expiring_raps = collect_expiring_or_expired_raps
  end

  def collect_expiring_or_expired_raps
    list = []
    rap_claims = Invoice.org_scope.where({invoice_status: ['S', 'P', 'R'], invoice_type: "322"})
    rap_claims.each do |rap_claim|
      res = expired_or_expiring_rap(rap_claim)
      list << res if res
    end
    list.sort_by{|x| [x[:is_expired], x[:expires], x[:patient_name_and_mr_number]] }
  end

  def expired_or_expiring_rap(rap_claim)
    res = false
    episode = rap_claim.treatment_episode

    unless final_claim_already_sent?(episode)
      expire_date = expire_date(rap_claim.sent_date, episode.start_date)

      if expires_within_maximum_number_days expire_date
        res = collect_expired_or_expiring_rap_details(rap_claim, episode, expire_date)
      end
    end
    res
  end

  def final_claim_already_sent?(episode)
    final_claim = episode.final_claim
    final_claim and final_claim.claim_sent?
  end

  def collect_expired_or_expiring_rap_details(rap_claim, episode, expire_date)
    treatment = episode.treatment
    patient = treatment.patient
    {
        patient_name_and_mr_number: patient_name(patient),
        soc_date: treatment.soc_date,
        episode: episode.certification_period_mmddyyyy,
        treatment_status: PatientTreatment::STATUS_DISPLAY[treatment.treatment_status],
        sent_date: rap_claim.sent_date.strftime("%m/%d/%y"),
        is_expired: expired?(expire_date) ? '1' : '0',
        expires: expire_date.strftime("%m/%d/%y"),
        total_visits: episode.treatment_visits.size,
        rap_amount: rap_claim.invoice_amount
    }
  end

  def patient_name patient
    "#{patient.full_name_with_out_mr_number} (#{patient.patient_reference})"
  end

  def expires_within_maximum_number_days expire_date
    expire_date <= (Date.current + NUMBER_OF_DAYS)
  end

  def expire_date(rap_sent_date, episode_start_date)
    [rap_sent_date + 60, episode_start_date + 120].max
  end

  def expired? expire_date
    expire_date < Date.current
  end

  def get_report_url
    @expiring_raps.size > 0 ? to_pdf : false
  end

  def jasper_report_url
    "#{Rails.root}/app/views/reports/expired_and_expiring_rap/expired_and_expiring_raps.jasper"
  end

  def xml_root
    "expired_and_expiring_raps"
  end

  def pdf_options
    {methods: {raps: @expiring_raps}}
  end

end