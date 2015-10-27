class PatientNetworkInfo < Mahaswami::Panel

  def initialize(conf = {}, parent = nil)
    super
    config[:treatment_id] = component_session[:treatment_id]
  end


  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:episode_id] = s[:episode_id] if s[:episode_id]
    @treatment = PatientTreatment.find(component_session[:treatment_id])
    debug_log component_session[:episode_id]
    @episode = @treatment.treatment_episodes.find(component_session[:episode_id]) if component_session[:episode_id]
    debug_log @episode
    @patient = @treatment.patient
    s.merge(
        {
            border: false,
            title: "Network Information",
            layout: {
                type: 'table',
                columns: 4,
                table_attrs: {
                    style: {width: "100%", "cell-padding" =>  5}
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
                    text: "#{primary_physician_full_name}"
                },
                {
                    xtype: 'label',
                    text: discipline_1_info
                },
                {
                    xtype: 'label',
                    text: discipline_2_info
                },
                {
                    xtype: 'label',
                    text: discipline_3_info
                },
                {
                    xtype: 'label',
                    text: "#{primary_physician_phone_number}"
                },
                {
                    xtype: 'label',
                    text: discipline_1_field_staff_1
                },
                {
                    xtype: 'label',
                    text: discipline_2_field_staff_1
                },
                {
                    xtype: 'label',
                    text: discipline_3_field_staff_1
                },
                {
                    xtype: 'label',
                    text: "#{primary_physician_phone_number}"
                },
                {
                    xtype: 'label',
                    text: discipline_1_field_staff_2
                },
                {
                    xtype: 'label',
                    text: discipline_2_field_staff_2
                },
                {
                    xtype: 'label',
                    text: discipline_3_field_staff_2
                },
                {
                    xtype: 'label',
                    text: "#{primary_physician_location}"
                },
                {
                    xtype: 'label',
                    text: discipline_1_field_staff_3
                },
                {
                    xtype: 'label',
                    text: discipline_2_field_staff_3
                },
                {
                    xtype: 'label',
                    text: discipline_3_field_staff_3
                }
            ]
        })
  end

  def discipline_display_info(discipline)
    debug_log discipline
    td = @treatment.treatment_disciplines.episode_scope(@episode).where(discipline_id: discipline.id).first
    f = ""
    if td
      if td.pending_evaluation?
        f = "Pending Evaluation"
      elsif td.on_hold?
        f = "On Hold"
      elsif td.discharged?
        f = "Discharged"
      elsif td.active?
        frequencies = @treatment.frequencies_for_discipline(discipline)
        f = frequencies.collect{|f|f.frequency_string}.join(", ")
      end
    end
    "#{discipline.discipline_code} - #{f}"
  end

  def discipline_1_info
    return nil if @treatment.disciplines.size < 1
    discipline = @treatment.disciplines[0]
    discipline_display_info(discipline)
  end

  def discipline_2_info
    return nil if @treatment.disciplines.size < 2
    discipline = @treatment.disciplines[1]
    discipline_display_info(discipline)
  end

  def discipline_3_info
    return nil if @treatment.disciplines.size < 3
    discipline = @treatment.disciplines[2]
    discipline_display_info(discipline)
  end

  def staffs_for_discipline(discipline)
    @treatment.treatment_staffs.staffed.select{|s| s.discipline == discipline}.collect{|s| s.staff}
  end

  def staff_info_for_discipline(discipline, idx)
    staffs = staffs_for_discipline(discipline)
    return nil if staffs.size < idx
    staffs[idx-1].full_name
  end

  def discipline_1_field_staff_1
    return nil if @treatment.disciplines.size < 1
    discipline = @treatment.disciplines[0]
    staff_info_for_discipline(discipline, 1)
  end

  def discipline_2_field_staff_1
    return nil if @treatment.disciplines.size < 2
    discipline = @treatment.disciplines[1]
    staff_info_for_discipline(discipline, 1)
  end

  def discipline_3_field_staff_1
    return nil if @treatment.disciplines.size < 2
    discipline = @treatment.disciplines[2]
    staff_info_for_discipline(discipline, 1)
  end

  def discipline_1_field_staff_2
    return nil if @treatment.disciplines.size < 1
    discipline = @treatment.disciplines[0]
    staff_info_for_discipline(discipline, 2)
  end

  def discipline_2_field_staff_2
    return nil if @treatment.disciplines.size < 2
    discipline = @treatment.disciplines[1]
    staff_info_for_discipline(discipline, 2)
  end

  def discipline_3_field_staff_2
    return nil if @treatment.disciplines.size < 2
    discipline = @treatment.disciplines[2]
    staff_info_for_discipline(discipline, 2)
  end

  def discipline_1_field_staff_3
    return nil if @treatment.disciplines.size < 1
    discipline = @treatment.disciplines[0]
    staff_info_for_discipline(discipline, 3)
  end

  def discipline_2_field_staff_3
    return nil if @treatment.disciplines.size < 2
    discipline = @treatment.disciplines[1]
    staff_info_for_discipline(discipline, 3)
  end

  def discipline_3_field_staff_3
    return nil if @treatment.disciplines.size < 2
    discipline = @treatment.disciplines[2]
    staff_info_for_discipline(discipline, 3)
  end

  def primary_physician_full_name
    @treatment.primary_physician.full_name if @treatment.primary_physician
  end

  def primary_physician_phone_number
    @treatment.primary_physician.phone_number if @treatment.primary_physician
  end

  def primary_physician_location
    @treatment.primary_physician.location if @treatment.primary_physician
  end
end
