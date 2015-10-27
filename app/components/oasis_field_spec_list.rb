class OasisFieldSpecList < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge(
        model: "OasisFieldSpec",
        editOnDblClick: false,
        columns: [
            {name: :field_sequence, label: "Sequence", width: 70, editable: false},
            {name: :field_name, label: "Name", addHeaderFilter: true, width: "15%", editable: false},
            {name: :rfa_1, label: "RFA 1", editable: false},
            {name: :rfa_2, label: "RFA 2", editable: false},
            {name: :rfa_3, label: "RFA 3", editable: false},
            {name: :rfa_4, label: "RFA 4", editable: false},
            {name: :rfa_5, label: "RFA 5", editable: false},
            {name: :rfa_6, label: "RFA 6", editable: false},
            {name: :rfa_7, label: "RFA 7", editable: false},
            {name: :rfa_8, label: "RFA 8", editable: false},
            {name: :rfa_9, label: "RFA 9", editable: false},
            {name: :rfa_10, label: "RFA 10", editable: false},
            {name: :consistency, width: "15%",tdCls: 'wrap', flex: 1, editable: false}
        ]
    )
  end

  def default_bbar
    []
  end

  def default_context_menu
    []
  end

end