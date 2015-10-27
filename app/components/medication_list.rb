class MedicationList < Mahaswami::GridPanel

  def configuration
    super.merge(
      model: 'Medication',
      columns: [
        {name: :drug_name, header: "Drug Name", editable: false},
        {name: :dosage, editable: false},
        {name: :active_ingredients, header: "Active Ingredients", width: 131, editable: false},
        {name: :status,
         editable: false,
         #getter: lambda {|r| Medication::STATUS[:"#{r.status}"]
         getter: lambda {|r|
           Medication::STATUS.each do |status|
             return status[1] if status[0] == r.status
           end}
        },
      ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Medication"
  action :edit_in_form, text: "Edit Medication"

end