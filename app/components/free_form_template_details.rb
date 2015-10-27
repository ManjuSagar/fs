class FreeFormTemplateDetails < Mahaswami::Panel
  def configuration
    super.merge(
      header: false,
      border: false,
      items: [
        {
          xtype: 'textarea',
          name: 'free_form_template_details',
          margin: '0 5px 5px 5px',
          width: 500,
          height: 75,
          readOnly: true,
          itemId: 'free_form_template_details',
        }
      ]
    )
  end
end