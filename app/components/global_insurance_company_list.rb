class GlobalInsuranceCompanyList < Mahaswami::GridPanel
  
  def configuration
    super.merge(
      model: 'InsuranceCompany',
      title:  'Insurance Companies',
      columns: [
        {name: :company_name, label: "Name", width: "15%", editable: false},
        {name: :company_code, label: "Code", width: "10%", editable: false},
        {name: :certification_period, label: "Certification Period", width: "10%", editable: false},
        {name: :co_pay_applicable, label: "Copay Applicable", width: "10%", editable: false}
      ],
     scope: :org_scope
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Company", tooltip: "Add Insurance Company"
  action :edit_in_form, text: "Edit Company", tooltip: "Edit Insurance Company"

  add_form_config class_name: "GlobalInsuranceCompanyEditForm"

  add_form_window_config width: "50%", height: "50%",  title: "Add Insurance Company"

  edit_form_config class_name: "GlobalInsuranceCompanyEditForm"

  edit_form_window_config width: "50%", height: "50%", title: "Edit Insurance Company"








end
