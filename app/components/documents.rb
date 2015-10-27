class Documents < Mahaswami::HasManyCollectionList
  include ActionView::Helpers::NumberHelper
  include DocumentsCompRelated
  include ButtonsOfOasisHeader
  def initialize(conf = {}, parent = nil)
    super
    return unless component_session[:form_cls_name] and component_session[:doc_def_id]
    #TODO:Code Refactor needed. For any action in To Do list the below code is instantiating and giving empty episode_id.
    #As Temp fix, calling a flag from ha_work_queue and fs_work_queue comp called no_doc_creation included below.
    if component_session[:parent_id] and config[:parent_model] == "TreatmentVisit"
      parent_model_attr_name = :visit_id
      treatment_id = config[:treatment_id]
      visit_id = component_session[:parent_id]
    elsif component_session[:parent_id] and config[:parent_model] == "PatientTreatment"
      parent_model_attr_name = :treatment_id
      treatment_id = component_session[:parent_id]
    end
    document_definition = DocumentDefinition.find(component_session[:doc_def_id])
    treatment = PatientTreatment.find(treatment_id)
    patient_name = treatment.patient.full_name
    mr_num = treatment.patient.patient_reference
    klass_name = "Documents::" + document_definition.document_form_template.document_class_name
    doc_instance = klass_name.
        constantize.new.configuration[:model].constantize.new(parent_model_attr_name => component_session[:parent_id]) unless config[:no_doc_creation]

    components[:add_form].merge!(:title => "New #{component_session[:doc_name]} Patient: #{patient_name} (MR# #{mr_num})")
    components[:add_form].merge!(header:{
       titlePosition: 0,
       items: [gem_button('gem'), medications_button('view_medications'), order_button('view_orders') ]
                                 })
    components[:edit_form].merge!(:title => "Edit #{component_session[:doc_name]} Patient: #{patient_name} (MR# #{mr_num})")
    components[:edit_form].merge!(header: view_and_order_buttons)
    components[:edit_form][:items].first.merge!(:klass_name => klass_name, :class_name => "Documents::" + component_session[:form_cls_name], :treatment_id => treatment_id, :visit_id => visit_id, mode: :edit,
                                                :strong_default_attrs => {treatment_id: treatment_id, treatment_episode_id: config[:strong_default_attrs][:treatment_episode_id]})
    components[:add_form][:items].first.merge!(:class_name => "Documents::" + component_session[:form_cls_name], :treatment_id => treatment_id, :visit_id => visit_id, mode: :add)
    components[:add_form][:items].first.delete(:model)
    components[:edit_form][:items].first.delete(:model)
    components[:add_form][:items].first.merge!(:record => doc_instance)
  end

  def configuration
    c = super
    @doc_actions = []
    treatment_id = (c[:parent_model] == "PatientTreatment")? component_session[:parent_id] : c[:treatment_id]
    episode_id =  c[:episode_id]
    if treatment_id and PatientTreatment.find_by_id(treatment_id).present?
      treatment = PatientTreatment.find(treatment_id)
      episode = TreatmentEpisode.find(episode_id) if episode_id.present?
      @doc_actions = document_actions(treatment, episode)
    end
    c.merge(
        parent_model: c[:parent_model],
        model: 'Document',
        title:  'Documents',
        width: c[:width] || 130,
        columns: [{name: :document_definition__document_name, label: "Name"},
        ] + optional_columns(c[:parent_model], c[:item_id]),
        add_form_window_config: {:width => "90%", :height => "90%"},
        edit_form_window_config: {:width => "90%", :height => "90%"},
        add_form_config: {:grid_item_id => c[:item_id]},
        edit_form_config: {:grid_item_id => c[:item_id]},
        strong_default_attrs:  {:document_definition_id => component_session[:doc_def_id],
                                treatment_episode_id: episode_id,
                                :status => "A", treatment_id: treatment_id}.merge(c[:strong_default_attrs]),
        scope: (if c[:episode_docs]
                  "(id in (select d.id from documents d inner join treatment_visits v on d.visit_id = v.id where v.draft_status = false) OR visit_id is null) AND treatment_episode_id = #{c[:episode_id]}"
                else
                  c[:oasis_documents] ? ["treatment_id = ? AND document_type IN (?)", component_session[:parent_id], Document::SPECIAL_DOCUMENTS] : c[:scope]
                end)
    )
  end

  def optional_columns(parent_model, item_id)
    [{name: :status, label: "Status", editable: false, :getter => get_document_status, width: "35%"}, action_column(item_id)]
  end

  def get_document_status
    lambda {|l|
      l.get_pending_status
    }
  end

  def human_action_name(event)   
    if event.name == :what_if
      "$?"
    else
      event.title
    end
  end

  action :edit_in_form, text: "", tooltip: "Edit"
  action :view_report, text: "", tooltip: "Print", icon: :print, disabled: true

  js_method :on_add_document, <<-JS
    function(){
      this.onAddInForm();
    }
  JS

  js_method :enable_disable_edit_action, <<-JS
    function(active){
      this.actions.editInForm.setDisabled(!active);
    }
  JS


  endpoint :set_document_context do |params|
    component_session[:form_cls_name] = params[:document_class_name]

    treatment_id = (config[:parent_model] == "PatientTreatment")? component_session[:parent_id] : config[:treatment_id]
    treatment = PatientTreatment.find(treatment_id)
    definition = treatment.document_definition(component_session[:form_cls_name])

    component_session[:doc_def_id] = definition.id
    component_session[:doc_name] = definition.document_name
    {}
  end



  js_method :launch_report, <<-JS
    function(report_options) {
      var reportUrl = report_options[0];
      reportUrl = window.location.protocol + "//" + window.location.host + reportUrl;
      var reportTitle = report_options[1];
      if (Ext.isGecko) {
        window.location = reportUrl;
      } else {
        Ext.create('Ext.window.Window', {
            width : 800,
            height: 600,
            layout : 'fit',
            title : reportTitle,
            items : [{
                xtype : "component",
                id: 'myIframe',
                autoEl : {
                    tag : "iframe",
                    href : ""
                }
            }]
        }).show();

        Ext.getDom('myIframe').src = reportUrl;
      }
    }
  JS

  js_method :on_view_report, <<-JS
    function() {
      var selModel = this.getSelectionModel();
      if (selModel.getCount() != 1) {
        return;
      }
      var recordId = selModel.selected.first().getId();
      this.viewReport({document_id: recordId});
    }
  JS

  js_method :init_component, <<-JS
    function(){
      this.callParent();

      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
        this.selectDocument({document_id: record.get('id')}, function(result){
          if(result[0]){
            this.actions.editInForm.setText('Edit');
          } else {
            this.actions.editInForm.setText('View');
          }
          this.actions.del.setDisabled(!result[1]);
        });
      }, this);
      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.viewReport.setDisabled(selModel.getCount() != 1);
      }, this);
      this.store.on('load', function(){
        this.updateDocumentsMenu({});
      }, this);
      this.updateDocumentsMenu({});
      this.getView().getRowClass = function(row, index) {
          return (row.get('status').indexOf('Correction') >= 0) ? 'red-color' : '';
      };
    }
  JS

  endpoint :view_report do |params|
    document_id = params[:document_id]
    d = Document.find(document_id)
    treatment = d.treatment
    url = d.combined_reports
    file_name = File.basename(url)
    certification_period = d.treatment_episode
    report_title = "Patient : #{treatment.to_s}, Certification Period - #{certification_period}"
    {:launch_report => ["/reports/generated/#{file_name[0..-5]}", report_title]}
  end

  endpoint :select_document do |params|
    component_session[:doc_id] = params[:document_id]
    document = Document.find(component_session[:doc_id])
    component_session[:form_cls_name] = document.document_form_template.document_class_name
    component_session[:doc_name] = document.document_definition.document_name
    component_session[:doc_def_id] = document.document_definition_id
    {:set_result => [document.editable?, document.deletable?]}
  end

  endpoint :update_documents_menu do |params|
    parent = config[:parent_model].constantize.find_by_id(component_session[:parent_id])
    valid_document_codes = valid_document_codes(parent, config[:oasis_documents], params[:visit_type_id])
    {:show_hide_docs_menu => (@doc_actions.collect{|d| {d[:action] => valid_document_codes.include?(d[:action].to_sym)}}) }
  end

  def valid_document_codes(parent, oasis_documents_flag, visit_type_id)
     documents = []
     return documents unless parent
     if config[:parent_model] == "TreatmentVisit"
       documents = valid_document_codes_for_visit(parent, visit_type_id)
     else
       treatment = parent
       treatment.disciplines.each{|d|
         d.visit_types.each{|v|
           documents += if oasis_documents_flag
                          v.document_definitions.select{|d| DocumentDefinition::OASIS_DOCS_CODES.include?(d.document_code)}.collect{|d| (d.document_code.downcase).to_sym}
                        else
                          v.document_definitions.collect{|d| (d.document_code.downcase).to_sym}
                        end
         }
       }
     end
     documents.collect{|doc_code| "add_#{doc_code}".to_sym}
  end

  def valid_document_codes_for_visit(visit, visit_type_id)
    return [] if visit_type_id.nil? and (config[:visit_type_from_record].nil? or config[:visit_type_from_record] == false)
    # FIXME
    # Should refer to agency level visit types for security
    # Reasons. In case of Field Staff, it should pick the agency
    # From the Treatment's Patient.
    visit_type = VisitType.find_by_id(visit_type_id) || visit.visit_type
    visit_type.document_definitions.reject{|d| visit.documents.any?{|x| x.document_definition == d} }.collect{|d| (d.document_code.downcase).to_sym}
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

  def default_bbar
    return [:view_report.action] if config[:no_doc_creation]
    return [] if Org.current.is_a? StaffingCompany
    [:edit_in_form.action, :del.action] + [text: "", menu: @doc_actions, iconCls: "add_icon", tooltip: "Add"] + ["-", :view_report.action]
  end

  def default_context_menu
    return [:view_report.action] if config[:no_doc_creation]
    return []  if Org.current.is_a? StaffingCompany
    [:edit_in_form.action, :del.action, "-"] + [text: "Add", menu: @doc_actions] +  ["-", :view_report.action]
  end

  def perform_event(comp_name, record, event)
    if [:submit, :sign].include?(event.name)
      <<-JS
       var g = Ext.ComponentQuery.query("grid[itemId=#{comp_name}]")[0];
        g.setSessionContext({document_id: "#{record.id}"}, function(){
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
                g.store.documentEventRefresh = true;
                g.performAction(#{record.id}, "#{event.name}");
                g.refreshGrids();
                w1.close();
              }
            }, this);
          }});
        }, this);
      JS
    elsif event.name == :approve
      <<-JS
        var g = Ext.ComponentQuery.query("grid[itemId=#{comp_name}]")[0];
        g.store.documentEventRefresh = true;
        g.performAction(#{record.id}, "#{event.name}");
      JS
    elsif event.name == :what_if
      <<-JS
        var g = Ext.ComponentQuery.query("grid[itemId=#{comp_name}]")[0];
        g.setLoading(true);
        g.getHippsCodeAndAmount({doc_id: "#{record.id}"}, function(response){
          Ext.MessageBox.alert("Claim Amount", "<b>HIPPS Code: &nbsp;&nbsp;<i>" + response[0] + "</i><br/><br/>Amount: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>" + response[1] + "</i></b>");
          g.setLoading(false);
        }, this);
      JS
    elsif [:unlock].include?(event.name)
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.setSessionContext({document_id: "#{record.id}"}, function(){
          g.loadNetzkeComponent({name: "popup_window", callback: function(w){
            w.show();
            w.on('close', function(){
              if (w.closeRes === "ok") {
                g.onEditInForm();
                g.store.load();
              }
            }, this);
          }});
        }, this);
      JS
    else
      super
    end
  end

  component :popup_window do
    {
        class_name: "PopupWindow",
        comp_name: "UnlockReasons",
        params: {document_id: component_session[:document_id]},
        width: 700,
        height: 245,
        title: "Correction Type"
    }
  end

  endpoint :get_hipps_code_and_amount do |params|
    doc = OasisEvaluation.find_by_id(params[:doc_id].to_i)
    doc ||= OasisRecertification.find_by_id(params[:doc_id].to_i)
    score, bill_amount = doc.treatment_episode.score_hipps_code_and_bill_amount({doc: doc, regenerate_hipps_code: true}) if doc.treatment_episode
    hipps_code = score.hipps_code
    hipps_code ||= ""
    bill_amount = bill_amount ? number_to_currency(bill_amount, :format => "%n") : 0
    {set_result: [hipps_code, bill_amount]}
  end

  endpoint :set_session_context do |params|
    component_session[:document_id] = params[:document_id]
  end

  component :verify_user_authentication do
    {
        class_name: "VerifyUserAuthentication",
        record_klass: "Document",
        record_id: component_session[:document_id]
    }
  end

  js_method :refresh_grids, <<-JS
    function(){
      this.store.load();
      //Ext.ComponentQuery.query('#treatment_doc_grid')[0].store.load();
      //Ext.ComponentQuery.query('#visit_doc_grid')[0].store.load();
    }
  JS

end