class PatientInsuranceCompaniesList < Mahaswami::HasManyCollectionList
  association "patient_insurance_companies"
  title "Insurance Companies"
  parent_model "Patient"

  def configuration
    s = super
    s.merge(
      model: "PatientInsuranceCompany",
      item_id: :patient_insurance_companies_list,
      header: false,
      columns: [
          {name: :insurance_company__company_name, label: "Name", editable: false, width: 70},
          {name: :insurance_company__company_code, label: "Code", editable: false, width: 70},
          {name: :patient_insurance_number, label: "Patient Number", editable: false, width: 120},
          {name: :relation_to_insured_display, label: "Relation to Insured", editable: false, width: 120},
          {name: :effective_date, label: "Effective Date", editable: false, width:120},
          {name: :termination_date, label: "Termination Date", editable: false,width:130},
          {name: :primary_insurance_flag, label: "Primary Insurance", editable: false, width: 130},
      ],
    )
  end

  add_form_config class_name: "PatientInsuranceCompanyForm"
  edit_form_config class_name: "PatientInsuranceCompanyForm"

  add_form_window_config title: "Add Insurance Company", width: "40%", height: "60%"
  edit_form_window_config title: "Edit Insurance Company", width: "40%", height: "60%"

  action :add_in_form, text: "", tooltip: "Add Insurance Company", itemId: :patient_insurance_add
  action :edit_in_form, text: "", tooltip: "Edit Insurance Company"

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

end