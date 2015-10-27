class TreatmentFieldStaffForm < Mahaswami::FormPanel

  def configuration
    super.merge(
      model: "TreatmentStaff",
      title: "Staff",
      items: [
        {name: :staff_type, value: "FieldStaff", read_only: true, hidden: true, scope: :org_scope},
        {name: :staff_id, field_label: "Staff", xtype: :combo, store: FieldStaff.all.collect{|x| [x.id, x.first_name]}},
        {name: :discipline__discipline_description, field_label: "Discipline"},
        {name: :visit_type__visit_type_description, field_label: "Visit Type", scope: :org_scope}
      ]
    )
  end
end