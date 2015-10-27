class DocumentFormTemplateSets < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'DocumentFormTemplateSet',
        title: 'Document Template Sets',
        columns: [{name: :set_name, label: "Name", editable: false},
                  {name: :set_description, label: "Description", editable: false, width: "20%"},
                  {name: :remarks, hidden: true, label: "Remarks", editable: false}],
        add_form_window_config: {width: "50%", height: "60%", title: "Add Document Template Set"},
        edit_form_window_config: {width: "50%", height: "60%", title: "Edit Document Template Set"}
    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.selectRecord({document_form_tpl_set_id: record.get("id")});
      }, this);
    }
  JS

  endpoint :select_record do |params|
    session[:document_form_tpl_set_id] = params[:document_form_tpl_set_id]
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Template Set"
  action :edit_in_form, text: "Edit Template Set"
  add_form_config class_name: "DocumentFormTemplateSetsEditForm"
  edit_form_config class_name: "DocumentFormTemplateSetsEditForm"
end