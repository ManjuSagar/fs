class HealthAgencyDetails < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'HealthAgencyDetail',
        title: 'Health Agency Details',
        columns: [{name: :health_agency__org_name, label: "Agency Name", editable: false, width: "20%"},
                  {name: :provider_number, label: "Provider No.", editable: false, width: "8%"},
                  {name: :cms_cert_number, label: "CMS Certification No.", editable: false, width: "8%"},
                  {name: :npi_number, label: "NPI No.", editable: false, width: "8%"},
                  {name: :document_definition_set__set_name, label: "Document Set", editable: false, width: "12%"},
                  {name: :document_form_template_set__set_name, label: "Document Form Template Set", editable: false, width: "15%"},
                  {name: :clinical_fields_required_in_oasis, label: "Clinical Fields in OASIS", editable: false, width: "10%"},
                  {name: :claims_electronic_transmission, field_label: "Claims Electronic Submission", width: "20%",editable: false },
        ]

    )
  end

  def default_bbar
    [:edit_in_form.action]
  end

  def default_context_menu
    [:edit_in_form.action]
  end

  edit_form_config class_name: "HealthAgencyDetailsForm"
  action :edit_in_form, text: "", tooltip: "Edit Details"
end