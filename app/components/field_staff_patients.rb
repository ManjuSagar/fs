class FieldStaffPatients < Mahaswami::GridPanel

  def initialize(conf = {}, parent = nil)
    super
    if component_session[:document_definition_id]
      document_definition = DocumentDefinition.find(component_session[:document_definition_id])
      doc_instance = ("Documents::" + document_definition.document_form_template.document_class_name).constantize.new.configuration[:model].constantize.new(:treatment_id => component_session[:selected_treatment_id])
      components[:add_document].merge!(:title => "New #{document_definition.document_name}")
      components[:add_document][:items].first.merge!(:class_name => "Documents::" + document_definition.document_form_template.document_class_name)
      components[:add_document][:items].first.delete(:model)
      components[:add_document][:items].first.merge!(:record => doc_instance)
      components[:add_document][:items].first.merge!(:strong_default_attrs => {:document_definition_id => component_session[:document_definition_id],
                                                                               :status => "A", :treatment_id => component_session[:selected_treatment_id]})
    end
    #components[:edit_form][:items].first.merge!({class_name: "VisitEditForm", visit_id: component_session[:visit_id]})
  end

  endpoint :set_document_context do |params|
    component_session[:document_definition_id] = params[:document_definition_id]
  end

  def configuration
    @document_actions = []
    DocumentDefinition.all.each {|d|
      action_name = d.document_code.downcase.to_sym
      self.class.action(action_name, text: "Add #{d.document_name}", icon: false)
      self.class.js_method "on_#{d.document_code}", <<-JS
        function(v) {
          this.setDocumentContext({
            document_definition_id: #{d.id}
          });
          this.onAddDocument();
        }
      JS
      @document_actions << action_name.action
    }
    self.class.action(:attachment, text: "Add Attachment", icon: false)
    self.class.js_method "on_attachment", <<-JS
        function(v) {
          this.onAddAttachment();
        }
    JS
    @document_actions << :attachment.action

    super.merge(
        model: "PatientTreatment",
        title: "Patients",
        columns: [
          {name: :patient__patient_detail__org__to_s, label: "Agency Name", editable: false, width: "20%"},
          {name: :patient__full_name, label: "Patient Name", editable: false},
          {name: :treatment_start_date, label: "Start Date", editable: false},
          {name: :treatment_end_date, label: "End Date", editable: false}
        ],
        scope: :fs_treatment_scope
    )
  end

  def default_bbar
    [{:text => "Add Documents", :menu => (@document_actions || [])}]
  end

  def default_context_menu
    [{:text => "Add Documents", :menu => (@document_actions || [])}]
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
        this.selectRecord({treatment_id: record.get('id')});
      }, this);
    }
  JS

  endpoint :select_record do |params|
    component_session[:selected_treatment_id] = params[:treatment_id]
    update_documents_menu(params[:treatment_id])
  end

  js_method :show_hide_docs_menu, <<-JS
    function(arr){
      Ext.each(arr, function(ele) {
        var action_name = Object.keys(ele)[0];
        var should_show = ele[action_name];
        if (should_show)
          this.actions[action_name].show();
        else
          this.actions[action_name].hide();
      }, this);
    }
  JS

  def update_documents_menu(treatment_id)
    v = PatientTreatment.find(treatment_id)
    valid_document_codes = Org.current.document_definitions.collect{|d| d.document_code.downcase.to_sym}
    {:show_hide_docs_menu => (@document_actions.collect{|d| {d[:action] => valid_document_codes.include?(d[:action].to_sym)}}) +
        [{:attachment => true }]
    }

  end

  component :add_document do
    form_config = {
        :class_name => "Mahaswami::FormPanel",
        :model => config[:model],
        :persistent_config => config[:persistent_config],
        :strong_default_attrs => config[:strong_default_attrs],
        :border => true,
        :bbar => false,
        :prevent_header => true,
        :mode => config[:mode],
        :record => data_class.new(columns_default_values)

    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :width => "90%",
        :height => "80%",
        :title => "Add #{data_class.model_name.human}",
        :button_align => "right",
        :items => [form_config]
    }
  end

  js_method :on_add_document, <<-JS
  function(){
    this.loadNetzkeComponent({name: "add_document", callback: function(w){
      w.show();
      w.on('close', function(){
        if (w.closeRes === "ok") {
          this.store.load();
        }
      }, this);
    }, scope: this});
  }
  JS

  component :add_attachment do
    form_config = {
        :class_name => "Mahaswami::FormPanel",
        :model => "TreatmentAttachment",
        :persistent_config => config[:persistent_config],
        :strong_default_attrs => {treatment_id: component_session[:selected_treatment_id]},
        :border => true,
        :bbar => false,
        :prevent_header => true,
        :mode => config[:mode],
        :record => TreatmentAttachment.new(treatment_id: component_session[:selected_treatment_id]),
        file_upload: true,
        class_name: "Mahaswami::FormPanel",
        items:[
            {name: :attachment_name, field_label: "Name"},
            {name: :attachment, field_label: "Upload", xtype: 'fileuploadfield', getter: lambda {|r| ""}, display_only: true},
            {name: :attachment_updated_at, field_label: "Date"}
        ]}

    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :auto_width => true,
        :auto_height => true,
        :title => "Add Attachment",
        :button_align => "right",
        :items => [form_config]
    }
  end

  js_method :on_add_attachment, <<-JS
  function(){
    this.loadNetzkeComponent({name: "add_attachment", callback: function(w){
      w.show();
      w.on('close', function(){
        if (w.closeRes === "ok") {
          this.store.load();
        }
      }, this);
    }, scope: this});
  }
  JS

end