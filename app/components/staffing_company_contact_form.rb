class StaffingCompanyContactForm < Mahaswami::FormPanel

  def configuration
    super.merge(
      model: "StaffingCompanyContract",
      title: "Staffing Company Contact",
      items: [
       {name: :contract_date, field_label: "Contract Date"},
       {name: :effective_from_date, field_label: "From Date"},
       {name: :effective_to_date, field_label: "To Date"},
       :disciplines.component,
       :visit_types.component
      ]
    )
  end

  component :disciplines do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        association: :disciplines,
        columns: 3
    }
  end

  component :visit_types do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        association: :visit_types,
        scope: :without_discipline,
        columns: 3
    }
  end

end