class FrequencyDetails < Mahaswami::HasManyCollectionList

  def configuration
    super.merge(
        columns: [{name: :detail_sequence, label: "Sequence", editable: false, width: "10%"},
                  {name: :detail_description, label: "Description", editable: false},
                  {name: :visited?, label: "Visited?", editable: false},
                  {name: :start_date, label: "Start Date", editable: false},
                  {name: :end_date, label: "End Date", editable: false},
                  {name: :detail_status, label: "Status", editable: false, :getter => lambda {|l|l.detail_status.to_s.titleize}},
                  action_column("frequency_detail_grid")
        ],
        bbar: [],
        context_menu: [],
    )
  end

  def human_action_name(event)
    if event == :justify_with_mo
      "Justify With Medical Order"
    elsif event == :mark_as_missed_and_justify_with_mo
      "Mark As Missed And Justified With Medical Order"
    else
      event.title
    end
  end

end