class DocumentDefinitions < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'DocumentDefinition',
        title:  'Forms',
        columns: [
            {name: :document_code, header: "Code", editable: false, width: "13%"},
            {name: :document_name, header: "Name", editable: false, width: "15%"},
            {name: :formatted_payable_rate,  header: "Payable Rate",  editable: false, align: 'right'},
            {name: :document_class_name, hidden: false, width: "13%"},
            {name: :document_form_template__template_description, header: "Form Template", editable: false}
        ],
        scope: :org_scope
    )
  end


  js_method :init_component, <<-JS
    function(){
      this.callParent();

      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
        console.log(record);
        console.log(record.get("document_class_name"));
        this.selectDocument({document_definition_id: record.get('id'),

            document_class_name: record.get("document_class_name")});
      }, this);

      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.create.setDisabled(selModel.getCount() != 1);
      }, this);

    }
  JS

  endpoint :select_document do |params|
    component_session[:selected_document_definition_id] = params[:document_definition_id]
    component_session[:form_class_name] = params[:document_class_name]
  end


  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  add_form_config class_name: "DocumentDefinitionsForm"
  edit_form_config class_name: "DocumentDefinitionsForm"
  action :add_in_form, text: "", tooltip: "Add Document Definition", icon: :add_new
  action :edit_in_form, text: "", tooltip: "Edit Document Definition", icon: :edit


end
