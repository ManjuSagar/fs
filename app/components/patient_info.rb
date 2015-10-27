class PatientInfo < Mahaswami::Panel

  def start_of_care_date
    return @episode.start_date.strftime("%m/%d/%Y") if @episode
    return @treatment.treatment_start_date.strftime("%m/%d/%Y") if @treatment
  end

  def certification_period
   return  @episode.certification_period if @episode
  end

  def status
    return @treatment.treatment_status.to_s.titleize if @treatment
    return @treatment_request.request_status.to_s.titleize if @treatment_request
  end

  def configuration
    s = super
    @episode = TreatmentEpisode.user_scope.find(s[:treatment_episode_id]) if s[:treatment_episode_id]
    if s[:treatment_id]
      @treatment = PatientTreatment.user_scope.find(s[:treatment_id])
      @patient = @treatment.patient
    elsif s[:treatment_request_id]
      @treatment_request = TreatmentRequest.user_scope.find(s[:treatment_request_id])
      @patient = @treatment_request.patient
    elsif s[:patient_id]
      @patient = Patient.user_scope.find(s[:patient_id])
    end
    s.merge(
    {
        item_id: 'patient_info',
        layout: {
            type: 'table',
            columns: 5,
            table_attrs: {
                style: {width: "100%", "cell-padding" =>  5, "font-size" => "15px"}
            },
            td_attrs: {
                style: {
                    padding: "2px"
                }
            }
        },
        items: [
            {
                xtype: 'label',
                html: (@patient ? "<b>#{@patient.full_name}</b> (MR# #{@patient.patient_reference})" : " ")
            }] + (@treatment ?
            ((User.current.is_a? FieldStaff) ? [{xtype: 'label', html: (@patient ? "<b>#{@patient.org}</b>" : " ")}] : []) +
            [{
                 xtype: 'label',
                 html: "<b>SOC</b> #{start_of_care_date}"
             },
             {
                xtype: 'label',
                html: "<b>Episode</b> #{certification_period}"
            },
            {
                xtype: 'label',
                text: "#{status}"
            }] : [
            {   xtype: 'label',
                text: "#{status}"
            }])
    })
  end
end
