class HealthAgencyDetailsForm < Mahaswami::FormPanel
  def configuration
    s = super
    s.merge(
        model: 'HealthAgencyDetail',
        title: 'Health Agency Details',
        items: [{name: :health_agency__org_name, field_label: "Agency Name", editable: false, width: "20%"},
                  {name: :provider_number, field_label: "Provider No.", editable: false, width: "10%"},
                  {name: :cms_cert_number, field_label: "CMS Certification No.", editable: false, width: "10%"},
                  {name: :npi_number, field_label: "NPI No.", editable: false, width: "10%"},
                  {name: :submitter_id, field_label: "Submitter Id", editable: false, width: "10%"},
                  {name: :clm_billing_cert_alias_name, field_label: "Claim Certificate Name", editable: false, width: "10%"},
                  {name: :clm_billing_cert_password, field_label: "Claim Certificate Password", editable: false, width: "10%"},
                  {name: :document_definition_set__set_name, field_label: "Document Set", editable: false, width: "15%"},
                  {name: :document_form_template_set__set_name, field_label: "Document Form Template Set", editable: false, width: "15%"},
                  {name: :clinical_fields_required_in_oasis, field_label: "Clinical Fields in OASIS", editable: false, width: "10%"},
                  {name: :claims_electronic_transmission, field_label: "Claims Electronic Submission"}
        ]

    )
  end
end