class AddFormLibrary < Mahaswami::FormPanel
  def configuration
    super.merge(
        model: "DownloadableForm",
        title: "Add Form Library",
        file_upload: true,
        items: [
                {name: :form_name, field_label: "Form Name", manually_required: true},
                {name: :form_description, field_label: "Form Description", manually_required: true},
                {name: :form_content, field_label: "Select File", xtype: 'fileuploadfield', getter: lambda {|r| ""}, display_only: true, manually_required: true},
        ]
    )
  end
end