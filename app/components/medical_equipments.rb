class MedicalEquipments < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'MedicalEquipment',
        title: 'Medical Equipments',
        columns: [{name: :equipment_name, label: "Name", editable: false}]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Equipment"
  action :edit_in_form, text: "Edit Equipment"
end