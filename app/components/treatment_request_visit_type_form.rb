class TreatmentRequestVisitTypeForm < Mahaswami::FormPanel

  def configuration
    super.merge(
      model: "TreatmentRequestVisitType",
      items: [
        {name: :visit_type__visit_type_description, field_label: "Visit type", scope: :org_scope}
      ]
    )
  end

end