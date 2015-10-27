class TreatmentEpisodes < Mahaswami::HasManyCollectionList

  association "treatment_episodes"
  parent_model  "PatientTreatment"

  action :add_in_form, text: "Add Cert Period"
  action :edit_in_form, text: "Edit Cert Period"

  def configuration
    c = super
    c.merge(
        title: "Certification Periods",
        columns: [{name: :start_date, label: "Start Date", editable: false},
                  {name: :end_date, label: "End Date", editable: false}
        ]
    )
  end

  def default_bbar
    (User.current.office_staff?) ? [:add_in_form.action, :del.action] : []
  end

  def default_context_menu
    (User.current.office_staff?) ? [:add_in_form.action, :del.action] : []
  end

end