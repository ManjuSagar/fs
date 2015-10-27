class TreatmentDisciplinesForm < Mahaswami::FormPanel

  def configuration
    c = super
    c.merge(
        model: "TreatmentDiscipline",
        items: [
            {name: :discipline__discipline_description, field_label: "Disciplines", editable: false},
        ]
    )

  end

  def discipline__discipline_description_combobox_options(params)
    treatment_id = config[:strong_default_attrs][:treatment_id]
    episode_id = config[:strong_default_attrs][:treatment_episode_id]
    TreatmentDiscipline.get_disciplines_for_store(treatment_id, episode_id)
  end

end