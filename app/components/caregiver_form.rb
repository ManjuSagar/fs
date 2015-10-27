class CaregiverForm < Mahaswami::FormPanel

 def configuration
   c = super
   c.merge(
       model: "PatientCaregiver",
       items: [
           {name: :first_name, field_label:"First Name", allow_blank: false},
           {name: :last_name, field_label:"Last Name"},
           {name: :phone_number, field_label: "Phone Number", input_mask: '(999) 999-9999', allow_blank: false},
           {name: :relation_to_patient, field_label: "Relation To Patient", editable: false},
       ]

   )
 end

end