class MedicationDiscontinueForm < Mahaswami::Panel
  def configuration
    super.merge(
    header: false,
    items: [
      {name: :discontinued_date, field_label: "Date", xtype: :datefield, margin: 5, item_id: :discontinued_date}
      ])
    
  end
end
