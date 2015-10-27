class ReferralDisciplines < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'TreatmentRequestDiscipline',
        title: 'Referral Disciplines',
        columns: [{name: :treatment_request__name, label: "Patient", editable: false},
                  {name: :discipline__discipline_description, label: "Discipline", editable: false, width: "60%"}]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Referral Discipline"
  action :edit_in_form, text: "Edit Referral Discipline"
end