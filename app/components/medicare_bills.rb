class MedicareBills < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'TreatmentEpisode',
        title: "Medicare Bills",
        item_id: :medicare_bills,
        columns: [
            {name: :patient_name, label: "Patient", editable: false},
            {name: :start_date, label: "Start Date", editable: false},
            {name: :end_date, label: "End Date", editable: false},
            {name: :initial_hipps_code, label: "Initial Hipps Code", editable: false},
            {name: :final_hipps_code, label: "Final Hipps Code", editable: false},
            {name: :medicare_bill_status, label: "Status", width: "15%", getter: lambda {|e| status_display(e)}},
            action_column("medicare_bills")
        ],
        scope: :rap_scope
    )
  end

  def status_display(e)
    if e.medicare_bill_status == :rap_billed
      "RAP Billed"
    elsif e.medicare_bill_status == :lupa_billed
      "LUPA Billed"
    else
      e.medicare_bill_status.to_s.titleize
    end
  end

  def default_bbar
    []
  end

  def default_context_menu
    []
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
    }
  JS

  def human_action_name(event)
    if event == :rap_bill
      "RAP Bill"
    elsif event == :lupa_bill
      "LUPA Bill"
    else
      event.title
    end
  end

end
