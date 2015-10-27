class TreatmentPhysicians < Mahaswami::HasManyCollectionList

    association "treatment_physicians"
    parent_model  "PatientTreatment"

    action :add_in_form, text: "", tooltip: "Add Physician", item_id: 'add_treatment_physician'
    action :edit_in_form, text: "", tooltip: "Edit Physician", item_id: 'edit_treatment_physician'

    def configuration
      c = super
      c.merge(
          title: "Physicians",
          item_id: 'treatment_physicians',
          columns: [{name: :physician__full_name, label: "Physician", editable: false, width: "13%"},
                    {name: :physician__phone_number, header: "Phone Number", editable: false,width: '18%'},
                    {name: :primary_referral_flag, label: "Primary Physician?", editable: false, width: "18%"},
                    {name: :require_cc_flag, label: "Require CC?", editable: false, width: "18%"}
          ]
      )
    end

    add_form_config class_name: "TreatmentPhysicianForm"
    add_form_window_config  title: "Add Physician", width: "45%"
    edit_form_config class_name: "TreatmentPhysicianForm"
    edit_form_window_config  title: "Edit Physician", width: "45%"

    def default_bbar
      (User.current.office_staff?) ? [:add_in_form.action,:edit_in_form.action, :del.action] : []
    end

    def default_context_menu
      (User.current.office_staff?) ? [:add_in_form.action,:edit_in_form.action, :del.action] : []
    end

end