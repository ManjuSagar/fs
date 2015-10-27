class PatientsListFilter < Mahaswami::Panel

  def configuration
    s = super
    treatment_status_arr = s[:treatment_status_arr]
    treatment_status_arr ||= ["P", "A"]
    treatment_status_arr = treatment_status_arr.include?("display_none") ? [] : treatment_status_arr
    s.merge(
        header: false,
        items: [
            {
                xtype: 'checkboxgroup',
                cls: "filter_check",
                width: '45%',
                margin: '5 5 5 5',
                items: [
                    {
                        xtype: 'checkboxfield',
                        name: "treatment_status",
                        inputValue: "P",
                        item_id: 'PE',
                        checked: (treatment_status_arr.include?("P")),
                        boxLabel: "<font color=#8B3AB2>PE</font>" #Purple
                    },
                    {
                        xtype: 'checkboxfield',
                        name: "treatment_status",
                        inputValue: "A",
                        item_id: 'AC',
                        checked: (treatment_status_arr.include?("A")),
                        boxLabel: "<font color=black>AC</font>"
                    },
                    {
                        xtype: 'checkboxfield',
                        name: "treatment_status",
                        inputValue: "O",
                        item_id: 'HD',
                        checked: (treatment_status_arr.include?("O")),
                        boxLabel: "<font color=#4F9FB2>HD</font>" #Teal
                    },
                    {
                        xtype: 'checkboxfield',
                        name: "treatment_status",
                        inputValue: "D",
                        item_id: 'DC',
                        checked: (treatment_status_arr.include?("D")),
                        boxLabel: "<font color=#267FFF>DC</font>" #Blue
                    }] +
                   (User.current.office_staff? ? [
                    {
                        xtype: 'checkboxfield',
                        name: "treatment_status",
                        inputValue: "N",
                        item_id: 'NA',
                        checked: (treatment_status_arr.include?("N")),
                        boxLabel: "<font color=#8C8C8C>NA</font>" #60% Black
                    }
                ] : [])
            }
        ]
    )
  end

end