class FreeFormTemplateList < Mahaswami::GridPanel

  def configuration
    super.merge(
      model: 'FreeFormTemplate',
      title: "Templates",
      border: false,
      columns: [
          {name: :template_short_description,
           header: "Description",
           editable: false,
           flex: 1
          },{
          name: :template_narrative,
          hidden: true
          }
      ] + ((User.current.is_a? FieldStaff) ? [{name: :agency_name, label: "Agency Name", editable: false, width: "15%"}] : []),
      scope: :org_scope
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action] if User.current.office_staff?
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action] if User.current.office_staff?
  end

  action :add_in_form, text: "", tooltip: "Add Template", icon: :add_new
  action :edit_in_form, text: "", tooltip: "Edit Template", icon: :edit

  add_form_config         class_name: "FreeFormTemplateForm"
  add_form_window_config  title: "Add Template", width: "60%", height: "60%"
  edit_form_config        class_name: "FreeFormTemplateForm"
  edit_form_window_config  title: "Edit Template"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
      this.on('itemclick', function(view, record){
        var details = Ext.ComponentQuery.query('#free_form_template_details')[0];
        if (details){
          details.setValue(record.data.template_narrative);
        }
      }, this);
    }
  JS

end