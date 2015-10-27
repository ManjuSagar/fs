class DocumentDefinitionSets < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'DocumentDefinitionSet',
        title: 'Document Sets',
        columns: [{name: :set_name, label: "Name", editable: false},
                  {name: :set_description, label: "Description", editable: false, width: "20%"},
                  {name: :remarks, hidden: true, label: "Remarks", editable: false}],
        add_form_window_config: {width: "50%", height: "60%", title: "Add Document Set"},
        edit_form_window_config: {width: "50%", height: "60%", title: "Edit Document Set"}
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "", tootlip: "Add Document Set"
  action :edit_in_form, text: "", tooltip: "Edit Document Set"
  add_form_config class_name: "DocumentDefinitionSetsEditForm"
  edit_form_config class_name: "DocumentDefinitionSetsEditForm"


  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.selectRecord({document_defn_set_id: record.get("id")});
      }, this);
    }
  JS

  endpoint :select_record do |params|
    session[:document_defn_set_id] = params[:document_defn_set_id]
  end
end