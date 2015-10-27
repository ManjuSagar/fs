class RemittanceUploads < Mahaswami::FormPanel
  def configuration
   c= super
   c.merge(
       model: 'MedicareRemittance',
       file_upload: true,
       items:[
           {name: :medicare_remittance, editable: false, label_align: "right", field_label: "Select File", xtype: "fileuploadfield", getter: lambda {|r| ""}, display_only: true,
               manually_required: true}
       ]
   )
  end
end