class Visits < Mahaswami::HasManyCollectionList
  include DocumentsCompRelated

  association "treatment_visits"
  parent_model "PatientTreatment"

  def initialize(conf = {}, parent = nil)
    super
    if component_session[:doc_def_id]
      document_definition = DocumentDefinition.find(component_session[:doc_def_id])
      doc_instance = ("Documents::" + document_definition.document_form_template.document_class_name).constantize.new.configuration[:model].constantize.new(:visit_id => component_session[:visit_id])
      components[:add_document].merge!(:title => "New #{document_definition.document_name}")
      components[:add_document][:items].first.merge!(:class_name => "Documents::" + document_definition.document_form_template.document_class_name, :mode => :add)
      components[:add_document][:items].first.delete(:model)
      components[:add_document][:items].first.merge!(:record => doc_instance, :visit_id => component_session[:visit_id], treatment_id: component_session[:parent_id])
      components[:add_document][:items].first.merge!(:strong_default_attrs => {:document_definition_id => component_session[:doc_def_id],
                                                                               :status => "A", :visit_id => component_session[:visit_id]})
    end
    components[:edit_form][:items].first.merge!({treatment_id: component_session[:treatment_id], treatment_episode_id: component_session[:episode_id]})
    components[:edit_form][:items].first.merge!({class_name: "VisitEditForm", visit_id: component_session[:visit_id]})
   end

  endpoint :set_document_context do |params|
    treatment = PatientTreatment.find(component_session[:parent_id])
    definition = treatment.document_definition(params[:document_class_name])

    component_session[:doc_def_id] = definition.id
    {}
  end

  def configuration
    c = super
    component_session[:treatment_id] = component_session[:parent_id]
    component_session[:episode_id] = c[:episode_id] if c[:episode_id]
    debug_log "In TREATVISIT Treatment ID = #{component_session[:treatment_id]}"
    @document_actions = []
    treatment = PatientTreatment.find(component_session[:treatment_id])
    episode = TreatmentEpisode.find(component_session[:episode_id])
    @document_actions = document_actions(treatment, episode, true, true)
    c.merge(
        model: 'TreatmentVisit',
        title: 'Visits',
        item_id: :visit_grid,
        isOfficeStaff: User.current.office_staff?,
        width: 570,
        columns: [
                  {name: :visited_user__full_name, label: "Staff", editable: false, width: "25%"},
                  {name: :requirement, label: "Type", editable: false, width: "25%"},
                  {name: :visit_date_display, label: "Date", editable: false, width: "16%"},
                  {name: :visit_start_time_display, label: "In", editable: false, width: "10%"},
                  {name: :visit_end_time_display, label: "Out", editable: false, width: "10%"},
                  {name: :visit_status, label: "Status", editable: false, :getter => get_visit_status, width: "15%"}
        ],
        edit_form_window_config: {width: "80%", height: "90%", title: "Edit Visit"},
        scope: (c[:episode_based] ? fs_visits_list : (c[:scope] ? c[:scope] : {}).merge({:draft_status => false}))
    )
  end


  def fs_visits_list
    if (User.current.is_a? FieldStaff and User.current.clinical_staff.blank?)
      ["(visited_staff_id = ? OR supervised_user_id = ?) AND treatment_episode_id = ? AND draft_status = ?", User.current.id, User.current.id,
      component_session[:episode_id], false]
    else
      {treatment_episode_id: component_session[:episode_id], :draft_status => false}
    end

  end

  def get_visit_status
    lambda {|l|
        (l.pending_staff_signature?)? "Pending Agency Approval" : l.visit_status.to_s.titleize
    }
  end

  def default_bbar
    return [] if (Org.current.is_a? StaffingCompany)
    add_doc = {:text => "Documents", iconCls: "add_icon", tooltip: "Add Document", item_id: :add_documents, :menu => (@document_actions || [])}
    actions = [:edit_in_form_for_add.action, :edit_in_form.action, :del.action] + [(add_doc if User.current.office_staff?)]
    actions
  end

  def default_context_menu
    return [] if (Org.current.is_a? StaffingCompany)
    [:edit_in_form_for_add.action, :edit_in_form.action, :del.action,
               {:text => "Add Documents", item_id: "add_documents_menu", :menu => (@document_actions || [])}]
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      if (this.isOfficeStaff){ 
        this.down("#add_documents").setDisabled(true);
        this.on('itemclick', function(view, record){
          this.updateDocumentsMenu({visit_id: record.get("id")}, function(result){
            if(result){
              this.actions.editInForm.setText('Edit');
              this.down("#add_documents").setDisabled(!result);
            }else{
              this.actions.editInForm.setText('View');
              this.down("#add_documents").setDisabled(!result.editable);
            }
          });
        }, this);
        this.store.on('load', function(){
          this.updateDocumentsMenu({}, function(){
            this.down("#add_documents").setDisabled(true);
          }, this);
        }, this);
        this.updateDocumentsMenu({});
      }
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

  js_method :on_attach_document, <<-JS
  function(){
    this.loadNetzkeComponent({name: "attach_document", callback: function(w){
      w.show();
      w.on('close', function(){
        if (w.closeRes === "ok") {
          this.store.load();
        }
      }, this);
    }, scope: this});
  }
  JS

  js_method :on_attach_routesheet, <<-JS
  function(){
    this.loadNetzkeComponent({name: "attach_routesheet", callback: function(w){
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
    return {show_hide_docs_menu: @document_actions.collect{|d| {d[:action] => false}}} unless params[:visit_id]
    component_session[:visit_id] = params[:visit_id]
    v = TreatmentVisit.find(params[:visit_id])
    valid_document_codes = valid_document_codes_for_visit(v)

    {:set_result => v.editable?, :show_hide_docs_menu => (@document_actions.collect{|d| {d[:action] => valid_document_codes.include?(d[:action].to_sym)}}) +
        (v.attachments.any?{|a| a.attachment_type == AttachmentType.route_sheet(v.treatment.patient.org.id)}? [] : [{:routesheet => true }])
    }
  end

  def valid_document_codes_for_visit(visit)
    return [] if visit.editable? == false
    document_action_prefix = visit.paper_entry? ? "attach_" : "add_"
    all_documents_for_visit_type =  visit.documents + visit.attachments.where("document_definition_id is not null")
    valid_document_codes = visit.visit_type.document_definitions.reject{|d| all_documents_for_visit_type.any?{|x| x.document_definition == d}}
    valid_document_codes.collect!{|d| (document_action_prefix + d.document_code.downcase).to_sym}
  end

  action :edit_in_form_for_add, text: "", tooltip: "Add Visit", icon: :add_new, item_id: :add_visit_button
  action :edit_in_form, text: "", tooltip: "Edit Visit"
  edit_form_config class_name: "VisitEditForm", mode: :edit
  
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
        :height => "90%",
        :title => "Add #{data_class.model_name.human}",
        :button_align => "right",
        :items => [form_config]
    }
  end

  component :attach_routesheet do
    form_config = {
      :class_name => "RouteSheetAttachment",
      :visit_id => component_session[:visit_id]
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :auto_width => true,
        :auto_height => true,
        :title => "Attach Route Sheet",
        :button_align => "right",
        :items => [form_config]
    }
  end

  component :attach_document do
    return {} unless component_session[:doc_def_id]
    document_definition = DocumentDefinition.find(component_session[:doc_def_id])
    type = document_definition ? AttachmentType.document(document_definition.org.id) : nil
    form_config = {
        :class_name => "Mahaswami::FormPanel",
        :model => "VisitAttachment",
        :persistent_config => config[:persistent_config],
        :strong_default_attrs => {visit_id: component_session[:visit_id], document_definition_id: component_session[:doc_def_id], attachment_type: type},
        :border => true,
        :bbar => false,
        :prevent_header => true,
        :mode => config[:mode],
        :record => VisitAttachment.new(visit_id: component_session[:visit_id], attachment_type: type ),
        file_upload: true,
        class_name: "Mahaswami::FormPanel",
        items:[
            {name: :attachment_type__attachment_description, field_label: "Type", read_only: true},
            {name: :attachment, field_label: "Select File", xtype: 'fileuploadfield', getter: lambda {|r| ""}, display_only: true},
            {name: :attachment_date, field_label: "Date", manually_required: true, item_id: :attachment_date}
        ]}

    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :auto_width => true,
        :auto_height => true,
        :title => "Attach #{document_definition.document_name}",
        :button_align => "right",
        :items => [form_config]
    }
  end

  def perform_event(comp_name, record, event)
    if [:submit, :sign].include?(event.name)
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.setSessionContext({visit_id: "#{record.id}"});
        var w1 = new Ext.window.Window({
          width: "25%",
          height: "25%",
          modal: true,
          layout:'fit',
          title: "Electronic Signature",
        });
        w1.show();
        g.loadNetzkeComponent({name: "verify_user_authentication", container:w1, callback: function(w){
          w.show();
          w.on('close', function(){
            if (w.signRes === true) {
              g.performAction(#{record.id}, "#{event.name}");
              g.refreshGrids();
              w1.close();
            }
          }, this);
        }});
      JS
    else
      super
    end
  end

  endpoint :set_session_context do |params|
    component_session[:visit_id] = params[:visit_id]
  end

  component :verify_user_authentication do
    {
        class_name: "VerifyUserAuthentication",
        record_klass: "TreatmentVisit",
        record_id: component_session[:visit_id]
    }
  end

  js_method :refresh_grids, <<-JS
    function(){
      this.store.load();
      //Ext.ComponentQuery.query('#treatment_doc_grid')[0].store.load();
      //Ext.ComponentQuery.query('#visit_doc_grid')[0].store.load();
     // Ext.ComponentQuery.query('#visit_frequency_grid')[0].store.load();
    }
  JS

  endpoint :create_new_record_and_return_id do |params|
    sample_visit = TreatmentVisit.create_visit_instance(component_session[:treatment_id], component_session[:episode_id])
    component_session[:visit_id] = sample_visit.id
    {:set_result => {:id => sample_visit.id}}
  end

  js_method :on_edit_in_form_for_add, <<-JS
    function(){
      var recordId = this.createNewRecordAndReturnId({},function(result) {
        var recordId = result.id;
        this.loadNetzkeComponent({name: "edit_form",
          params: {record_id: recordId},
          callback: function(w){
            w.show();
            w.setTitle("Add Visit");
            w.on('close', function(){
              if (w.closeRes === "ok") {
                this.store.load();
              }
            }, this);
          }, scope: this});
      });
    }
  JS

  js_method :on_del,<<-JS
    function(){
      var records = [];
      this.getSelectionModel().selected.each(function(r){
        if (r.isNew) {
          // this record is not know to server - simply remove from store
          this.store.remove(r);
        } else {
          records.push(r.getId());
        }
      }, this);
      if(records.length != 1){
        Ext.MessageBox.alert("Status", "Only single visit selection can be deletable.");
      }else{
        this.canDeleteVisit({visit_id: records[0]}, function(res){
          if(res){
            Ext.Msg.confirm(this.i18n.confirmation, this.i18n.areYouSure, function(btn){
              if(btn == 'yes'){
               if (!this.deleteMask) this.deleteMask = new Ext.LoadMask(this.getEl(), {msg: this.deleteMaskMsg});
                this.deleteMask.show();
                // call API
                this.deleteData({records: Ext.encode(records)}, function(){
                  this.deleteMask.hide();
                }, this);
              }
            }, this);
          }else{
             Ext.MessageBox.alert("Status", "Visit cannot be deleted.<br/><br/> <b>Reasons:</b><br/><br/> 1. Payroll is already processed.<br/> 2. Visit contains documents.")
          }

        },this);
      }
    }
  JS

  endpoint :can_delete_visit do |params|
    visit = TreatmentVisit.find(params[:visit_id])
    {set_result: visit.can_delete?}
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end
end
