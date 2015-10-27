class PatientAndAmountDetails < Netzke::Basepack::Panel

  def configuration
    s = super
    list = MedicareRemittanceClaim.get_patient_and_amount_details(s[:invoice_id])
    s.merge(
      items: [
        {
          xtype: 'panel',
          border: false,
          layout: 'hbox',
          items: [
            {xtype: :displayfield, value: list[:patient_name] , item_id: "patient_name", field_label: "Patient Name", editable: false, margin: '5', width: "30%", label_align: "right"},
            {xtype: :displayfield, value: list[:from_date], item_id: "service_from_date", field_label: "Service From Date", editable: false, margin: '5', labelWidth: 120,  width: "22%", label_align: "right"},
            {xtype: :displayfield, value: list[:to_date], item_id: "service_end_date", field_label: "Service To Date", editable: false, margin: '5', labelWidth: 120,  width: "22%", label_align: "right"},
            {xtype: :displayfield, value: list[:sent_date], item_id: "sent_date", field_label: "Sent Date", editable: false, margin: '5',labelWidth: 70,  width: "15%", label_align: "right"},

          ]
        },
        {
          xtype: 'panel',
          border: false,
          layout: 'hbox',
          items: [
            {xtype: :displayfield, value: list[:billed_amount], item_id: "billed_amount", field_label: "Billed Amount", editable: false, margin: '5', width: "30%", label_align: "right"},
            {xtype: :displayfield, value: list[:paid_amount], item_id: "paid_amount", field_label: "Paid Amount", editable: false, margin: '5',labelWidth: 110,  width: "22%", label_align: "right"},
            {xtype: :displayfield, value: list[:patient_responsibility], item_id: "patient_responsibility", field_label: "Patient Responsibility", editable: false, margin: '5', labelWidth: 150,  width: "23%", label_align: "right"},
            {xtype: :displayfield, value: list[:invoice_status], item_id: "invoice_status", field_label: "Status", editable: false, margin: '5', labelWidth: 60,  width: "22%"},
          ]
        }
      ]
    )
  end
end