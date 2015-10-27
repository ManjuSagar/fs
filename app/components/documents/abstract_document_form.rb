class Documents::AbstractDocumentForm < Mahaswami::FormPanel
  include ButtonsOfOasisHeader

  def initialize(conf = {}, parent_id = nil)
    super
    result = (not Document.find(config[:record_id]).editable?) if config[:record_id]
    if result
      config[:read_only] = true
      self.config[:items].each_with_index do |item, index|
        if item.include?(:netzke_component)
          component = components[item[:netzke_component]]
          component[:read_only] = true if component
        else
          item[:read_only] = true
          config[:items][index] = item
        end
      end
    end
  end

  def configuration
    s = super
    component_session[:record_id] = s[:record_id] if s[:record_id]
    if s[:strong_default_attrs]
      component_session[:sda] = s[:strong_default_attrs]
      component_session[:ti] = s[:strong_default_attrs][:treatment_id] if s[:strong_default_attrs][:treatment_id]
    end
    component_session[:ti] = s[:treatment_id] if s[:treatment_id]
    component_session[:gii] = s[:grid_item_id] if s[:grid_item_id]
    component_session[:kn] = s[:klass_name] if s[:klass_name]
    component_session[:vi] = s[:visit_id] if s[:visit_id]
    print_not_applicable_docs = ["Documents::OasisResumptionOfCareForm", "Documents::OasisDeathAtHomeForm", "Documents::OasisTransferredPatientWithDischargeForm", "Documents::OasisTransferredPatientWithoutDischargeForm"]
    frequency_display_docs = ["Documents::MSWEvaluationForm", "Documents::OTEvaluationForm", "Documents::PTEvaluationForm", "Documents::SNEvaluationForm",
                              "Documents::STEvaluationForm", "Documents::ChhaCarePlanForm"]
    documentEditButtonRequired = false
    documentApproveButtonRequired = false
    documentIsInDraftStatus = ( User.current.office_staff? )
    doc_status_is_draft = true
    if s[:record_id].present?
      doc = Document.find(s[:record_id])
      doc.system_driven_event = true
      documentEditButtonRequired = doc.may_edit_document?
      documentApproveButtonRequired = doc.may_approve?
      documentIsInDraftStatus = doc.draft_save_required?
      doc_status_is_draft = doc.draft?
      doc.system_driven_event = false
    end
    component_session[:doc_is_draft] = doc_status_is_draft
    component_session[:save_draft_required] = documentIsInDraftStatus
    component_session[:display_frequency_in_eval_form] = frequency_display_docs.include?(s[:class_name])
    sign_date_password_required = (((s[:record_id].present? and doc.may_sign?) or s[:record_id].nil?) and  (User.current.field_staff? or User.current.clinical_staff?))
    s.merge(
        item_id: :document_cancel_id,
        signDateAndPasswordRequired: sign_date_password_required,
        trackResetOnLoad: true,
        showViewMedicationsAction: true,
        documentEditButtonRequired: documentEditButtonRequired,
        documentApproveButtonRequired: documentApproveButtonRequired,
        documentIsInDraftStatus: documentIsInDraftStatus,
        showViewOrdersActions: true,
        doc_is_draft: doc_status_is_draft,
        save_draft_required: documentIsInDraftStatus,
        show_print_icon_on_edit_form: (s[:record_id].present? and !print_not_applicable_docs.include?(s[:class_name])),
        saveDraftButtonRequired: documentIsInDraftStatus
    )
  end

  endpoint :approve_document do |params|
    doc = Document.find(component_session[:record_id])
    episode = doc.treatment_episode
    previous_episode = episode.previous_episode
    rc_doc = episode.recertified_doc
    if rc_doc.present? and doc.present? and rc_doc.document_date.between?(previous_episode.episode_55th_day, previous_episode.end_date) and
        doc.document_date.between?(previous_episode.episode_55th_day, previous_episode.end_date)
      rc_hipps_code = rc_doc.subm_hipps_code
      roc_doc_hips_code = doc.calculate_hipps_code[1]
      res = (rc_hipps_code == roc_doc_hips_code)
      doc.approve! if res == true
      {set_result: res}
    else
      doc.approve!
      {set_result: true}
    end
  end

  component :add_document do
    {
        class_name: component_session[:kn],
        border: true,
        bbar: false,
        prevent_header: true,
        record_id: component_session[:record_id],
        strong_default_attrs: component_session[:sda],
        treatment_id: component_session[:ti],
        grid_item_id: component_session[:gii],
        visit_id: component_session[:vi]
    }
  end

  endpoint :change_document_status_to_draft do |params|
    doc = Document.org_scope.find(component_session[:record_id])
    doc.update_column(:fs_sign_date, nil)
    doc.system_driven_event = true
    doc.edit_document!
    doc.system_driven_event = false
    {:set_result => true}
  end

  component :patient_details do
    c = config
    {
       :class_name => "PatientDetails",
       :treatment_id => component_session[:ti],
       :region => :north,
       :visit_id => component_session[:vi],
       :doc_klass_name => component_session[:kn],
       :strong_default_attrs => component_session[:sda],
       record: c[:record],
       record_id: component_session[:record_id],
       grid_item_id: component_session[:gii],
       doc_is_draft: component_session[:doc_is_draft],
       save_draft_required: component_session[:save_draft_required],
       display_frequency_in_eval_form: component_session[:display_frequency_in_eval_form],
       items: []
    }
  end

  component :super_visory_visits do
    c = config
    {
        :class_name => "SuperVisoryVisits",
        :treatment_id => component_session[:ti],
        :visit_id => component_session[:vi],
        :doc_is_draft => component_session[:doc_is_draft],
    }
  end

  def set_default_field_label(c)
    # multiple spaces (in case of association attrs) get replaced with one
    return if ['radiofield', 'checkboxfield'].include? c[:xtype]
    c[:field_label] ||= c[:fieldLabel]
    c[:field_label] ||= data_class ? data_class.human_attribute_name(c[:name]) : c[:name].humanize
    c[:field_label].gsub!(/\s+/, " ")
  end

  endpoint :view_report do |params|
    document_id = params[:record_id] || config[:record_id]
    d = Document.find(document_id)
    treatment = d.treatment
    url = d.combined_reports
    file_name = File.basename(url)
    certification_period = d.treatment_episode
    report_title = "Patient : #{treatment.to_s}, Certification Period - #{certification_period}"
    {:launch_document_report => ["/reports/generated/#{file_name[0..-5]}", report_title]}
  end

  js_method :launch_document_report, <<-JS
    function(reportOptions) {
      launchDocumentReport(reportOptions);
    }
  JS

  js_method :set_form_values, <<-JS
    function(values) {
      var assocValues = values._meta.associationValues || {};
      for (var assocFieldName in assocValues) {

        var assocField = this.getForm().getFields().filter('name', assocFieldName).first();
        if (!assocField)
          continue;
        if (assocField.isXType('combobox')) {
          assocField.emptyText = assocField.emptyText || "---";
          // HACK: using private property 'store' here!
          assocField.store.loadData([[values[assocFieldName], assocValues[assocFieldName]]]);
          delete assocField.lastQuery; // force loading the store next time user clicks the trigger
        }else {
          assocField.setValue(assocValues[assocFieldName]);
          delete values[assocFieldName]; // we don't want this to be set once more below with setValues()
        }
      }
      for (var fieldName in values) {
        if (fieldName != '_meta') {
          var field = this.getForm().getFields().filter('name', fieldName).first();
          if (field) {
            if (field.isXType('checkboxfield')){
              field.initialTrue = values[fieldName];
            }
            else if (field.isXType('datefield')) {
              values[fieldName] = values[fieldName].substring(0, 10);
            } else if(field.isXType('xdatetime')){
              values[fieldName] = Ext.util.Format.date(values[fieldName], "m/d/Y H:i")
            }
          }
        }
      }
     
      this.getForm().setValues(values);
    }
  JS

  js_method :init_component, <<-JS
    function(){
      var formScope = this;
      Ext.documentFormId = this.id;
      this.callParent();
      var elementsList = Ext.ComponentQuery.query('textarea, textfield');
      Ext.each(elementsList, function(ele, index){
        ele.enableKeyEvents = true;
      });
    }
  JS

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      onAfterRender(this);
    }
  JS

  endpoint :set_context do |params|
    component_session[:record_id] = params[:document_id]
  end

  component :document_notes do
    {
        class_name: "Notes",
        grid_item_id: config[:grid_item_id]
    }
  end

  component :icd_gem do
    {
        class_name: "Icd9to10Gem",
        grid_item_id: config[:grid_item_id],
        border: false
    }
  end

  component :medical_orders do
    episode_id = config[:strong_default_attrs][:treatment_episode_id] || config[:strong_default_attrs][:episode_id]
    {
        class_name: "MedicalOrders",
        parent_id: config[:strong_default_attrs][:treatment_id],
        treatment_id: config[:strong_default_attrs][:treatment_id],
        episode_id: episode_id,
        episode_orders: true,
        header: false
    }
  end

  endpoint :select_template_category do |params|
    session[:selected_template_category] = params[:template_category]
  end

  component :free_form_template_explorer_component do
    {   :header => false,
        :border => false,
        :class_name => "FreeFormTemplateExplorer"
    }
  end

  js_method :on_apply, <<-JS
    function(params){
      documentOnApply(params, this);
    }
  JS

  def netzke_submit_endpoint params
    res = super
    if @record.draft_save
      @record.save_as_draft! if @record.may_save_as_draft?
    else
      @record.submit_to_qa! if @record.may_submit_to_qa?
    end
    res
  end

  def get_combobox_options_endpoint(params)
    OasisEvaluation.netzke_combo_options_for(params[:column], {query: params["query"]})
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    component_session[:record_id] = component_params["document_id"].to_i if component_params["document_id"]
    component_params.merge!({"document_id" => component_session[:record_id]}) if ((["add_document", "document_notes", "icd_gem"].
        include? params["name"]) or params["class_name"] == "Notes")
    if params[:name] == "add_document"
      component_params.merge!({"class_name" => component_session[:kn], "treatment_id" => component_session[:ti],
                               "episode_id" => component_session[:eid], "document_definition_id" => component_session[:ddid],
                               "record_id" => component_session[:record_id]})
    end
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end

  def medication_review_form
    [
      {xtype: 'fieldset',
      margin: '5px',
      layout:{
        align: 'stretch',
        type: 'hbox'
      },
      title: 'Medication Review',
      items: [
        {
          xtype: 'radiogroup',
          width: 608,
          fieldLabel: 'Medication List reviewed during this visit?',
          labelWidth: 300,
          items:[
            {
              xtype: 'radiofield',
              name: 'medication',
              boxLabel: 'Yes',
              inputValue: 'Yes'
            },
            {
              xtype: 'radiofield',
              name: 'medication',
              boxLabel: 'No',
              inputValue: 'No'
            }
          ]
        }
      ]
      }
    ]
  end

end
