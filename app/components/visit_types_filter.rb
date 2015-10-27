class VisitTypesFilter <  Mahaswami::Panel

def configuration
  s = super
  visit_type_status_arr = s[:visit_type_status_arr]
  visit_type_status_arr ||= ["A"]
  visit_type_status_arr = visit_type_status_arr.include?("display_none") ? [] : visit_type_status_arr
  s.merge(
      header: false,
      items: [
          {
              xtype: 'checkboxgroup',
              cls: "filter_check",
              width: '30%',
              margin: '5 5 5 5',
              items: [
                  {
                      xtype: 'checkboxfield',
                      name: "visit_type_status",
                      inputValue: "A",
                      item_id: 'visit_types_active',
                      checked: (visit_type_status_arr.include?("A")),
                      boxLabel: "<font color=#8B3AB2>Active</font>" #Purple
                  },
                  {
                      xtype: 'checkboxfield',
                      name: "visit_type_status",
                      inputValue: "D",
                      item_id: 'visit_types_inactive',
                      checked: (visit_type_status_arr.include?("D")),
                      boxLabel: "<font color=black>Inactive</font>"
                  }
              ]
          }
      ]
  )
end
end