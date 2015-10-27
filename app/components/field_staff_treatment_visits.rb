class FieldStaffTreatmentVisits < Mahaswami::HasManyCollectionList
  association "treatment_visits"
  parent_model "FieldStaff"

  def initialize(conf = {}, parent = nil)
    super
    if component_session[:document_definition_id]
      document_definition = DocumentDefinition.find(component_session[:document_definition_id])
      doc_instance = ("Documents::" + document_definition.document_form_template.document_class_name).constantize.new.configuration[:model].constantize.new(:visit_id => component_session[:visit_id])
      components[:add_document].merge!(:title => "New #{document_definition.document_name}")
      components[:add_document][:items].first.merge!(:class_name => "Documents::" + document_definition.document_form_template.document_class_name)
      components[:add_document][:items].first.delete(:model)
      components[:add_document][:items].first.merge!(:record => doc_instance)
      components[:add_document][:items].first.merge!(:strong_default_attrs => {:document_definition_id => component_session[:document_definition_id],
                                                                               :status => "A", :visit_id => component_session[:visit_id]})
    end
    components[:edit_form][:items].first.merge!({class_name: "FieldStaffVisitEditForm", visit_id: component_session[:visit_id]})
  end

  endpoint :set_document_context do |params|
    component_session[:document_definition_id] = params[:document_definition_id]
  end

  def configuration
    @document_actions = []
    Org.current and Org.current.document_definitions.each {|d|
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

    self.class.action(:routesheet, text: "Add Route Sheet", icon: false)
    self.class.js_method "on_routesheet", <<-JS
        function(v) {
          this.onAddRoutesheet();
        }
    JS
    @document_actions << :routesheet.action

    super.merge(
        parent_id: User.current.id,
        item_id: "field_staff_treatment_visit_grid",
        columns: [{name: :discipline__to_s, label: "Patient & Discipline", editable: false, width:"10%"},
                  {name: :treatment_episode__certification_period, label: "Episode", editable: false, width:"10%"},
                  {name: :visit_start_time, label: "Start Time", editable: false},
                  {name: :visit_end_time, label: "End Time", editable: false},
                  {name: :frequency_string, label: "Frequency", editable: false},
                  {name: :visit_status, label: "Status", editable: false, :getter => lambda {|l|l.visit_status.to_s.titleize}},
                  action_column("field_staff_treatment_visit_grid")
        ],
        add_form_window_config: {width: "50%", auto_height: true},
        edit_form_window_config: {width: "50%", height: "80%"},
        strong_default_attrs: {visited_user_id: User.current.id}
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action,
     {:text => "Add Documents", :menu => (@document_actions || [])}]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action,
     {:text => "Add Documents", :menu => (@document_actions || [])}]
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.updateDocumentsMenu({visit_id: record.get("id")});
      }, this);
    }
  JS

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

  js_method :on_add_routesheet, <<-JS
  function(){
    this.loadNetzkeComponent({name: "add_routesheet", callback: function(w){
      w.show();
      w.on('close', function(){
        if (w.closeRes === "ok") {
          this.store.load();
        }
      }, this);
    }, scope: this});
  }
  JS

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

  endpoint :update_documents_menu do |params|
    component_session[:visit_id] = params[:visit_id]
    v = TreatmentVisit.find(params[:visit_id])
    valid_document_codes = v.visit_type.document_definitions.collect{|d| d.document_code.downcase.to_sym}
    {:show_hide_docs_menu => (@document_actions.collect{|d| {d[:action] => valid_document_codes.include?(d[:action].to_sym)}}) +
        [{:routesheet => true }]
    }
  end

  action :add_in_form, text: "Add Visit"
  action :edit_in_form, text: "Edit Visit"
  add_form_config class_name: "FieldStaffVisitNewForm"
  edit_form_config class_name: "FieldStaffVisitEditForm"

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

  component :add_routesheet do
    form_config = {
        :class_name => "Mahaswami::FormPanel",
        :model => "VisitAttachment",
        :persistent_config => config[:persistent_config],
        :strong_default_attrs => {visit_id: component_session[:visit_id]},
        :border => true,
        :bbar => false,
        :prevent_header => true,
        :mode => config[:mode],
        :record => VisitAttachment.new(visit_id: component_session[:visit_id], attachment_name: "Route Sheet"),
        file_upload: true,
        class_name: "Mahaswami::FormPanel",
        items:[
        {name: :attachment_name, field_label: "Name", read_only: true},
        {name: :attachment, field_label: "Upload", xtype: 'fileuploadfield', getter: lambda {|r| ""}, display_only: true},
        {name: :attachment_updated_at, field_label: "Date"}
    ]}

    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :auto_width => true,
        :auto_height => true,
        :title => "Add Routesheet",
        :button_align => "right",
        :items => [form_config]
    }
  end
end