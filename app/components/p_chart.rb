class PChart < Netzke::Base
  include Mahaswami::NetzkeBase

  js_base_class "Ext.tree.TreePanel"

  def configuration
    c = super
    @treatment = PatientTreatment.user_scope.find(c[:treatment_id]) if c[:treatment_id]
    @referral = TreatmentRequest.user_scope.find(c[:treatment_request_id]) if c[:treatment_request_id]
    @episode = TreatmentEpisode.user_scope.find(c[:episode_id]) if c[:episode_id]
    c[:patient_id] = c[:patient_id] ? c[:patient_id] : get_patient_id
    c.merge({
                title: 'Chart',
                width: 220,
                height: 150,
                item_id: :p_chart,
                root_visible: false,
                cls: :patient_tree,
                root: tree_nodes(c),
            })
  end

  def get_patient_id
    return @referral.patient_id if @referral
    return @treatment.patient_id if @treatment
  end


  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.getView().on('itemclick', function(e,node,i){
        this.displayNodeBody(node);
      }, this);
    }
  JS

  js_method :display_node_body, <<-JS
    function(node){
      if (node.raw.component) {
        var mainApp = this.up("#app");
        mainApp.setContext(node.raw.params, function(){
          this.loadNetzkeComponent({name: node.raw.component, container: this.up().up().down("#main_panel")});
        }, this);
      }
    }
  JS

  js_method :after_render, <<-JS
    function() {
      this.callParent();
      var tree = this;
      this.onRefresh = function() {
        tree.refreshTree({}, function(nodes) {
          this.setRootNode(nodes);
        });
      }
    }
  JS

  endpoint :refresh_tree do |params|
    {set_result: tree_nodes(config)}
  end

  component :patient_edit_form do
    {
        class_name: "PatientEditForm",
        lazy_loading: true,
        record_id: config[:patient_id],
        title: "Patient Information",
        bbar: ["->", :delete_patient.action, :apply.action]
    }
  end

  component :schd_visit_exp do
    {
        class_name: "SchdVisitExp",
        episode_id: config[:episode_id],
        lazy_loading: true,
        treatment_id: config[:treatment_id]
    }
  end

  component :all_documents do
    {
        class_name: "AllDocuments",
        item_id: "all_documents_#{config[:episode_id]}",
        episode_id: config[:episode_id],
        lazy_loading: true,
        treatment_id: config[:treatment_id]
    }
  end

  component :visit_new_form do
    {
        class_name: "VisitEditForm",
        title: "Visit",
        treatment_id: config[:treatment_id],
        visit_id: config[:visit_id],
        record_id: config[:visit_id],
        lazy_loading: true,
    }
  end
  component :patient_dashboard do
    {
        class_name: "PatientDashboard",
        episode_id: config[:episode_id],
        treatment_id: config[:treatment_id],
        lazy_loading: true,
    }
  end
  component :visit_docs_exp do
    {
        class_name: "VisitDocsExp",
        episode_id: config[:episode_id],
        treatment_id: config[:treatment_id],
        parent_id: config[:treatment_id],
        lazy_loading: true,
        episode_based: true
    }
  end

  component :treatment_disciplines do
    {
        class_name: "TreatmentDisciplines",
        episode_id: config[:episode_id],
        treatment_id: config[:treatment_id],
        parent_id: config[:treatment_id],
        lazy_loading: true,
        episode_based: true
    }
  end

  component :medications_list do
    {
        class_name: "MedicationsList",
        treatment_id: config[:treatment_id],
        lazy_loading: true
    }
  end

  component :treatment_staffing do
    {
        class_name: "TreatmentStaffing",
        treatment_id: config[:treatment_id],
        lazy_loading: true
    }
  end

  component :episodes do
    {
        class_name: "Episodes",
        parent_id: config[:treatment_id],
        lazy_loading: true
    }
  end

  component :referral_edit_form do
    {
        class_name: "ReferralEditForm",
        lazy_loading: true,
        record_id: config[:treatment_request_id],
        title: "Referral"
    }
  end

  component :staffing do
    {
        class_name: "Staffing",
        lazy_loading: true,
        record_id: config[:treatment_request_id],
        treatment_request_id: config[:treatment_request_id],
        title: "Staffing"
    }
  end

  component :care_givers do
    {
        class_name: "CaregiversList",
        lazy_loading: true,
        record_id: config[:patient_id],
        patient_id: config[:patient_id],
        parent_id: config[:patient_id],
        title: "Caregivers"
    }
  end

  component :referral_attachments_list do
    {
        class_name: "ReferralAttachmentsList",
        lazy_loading: true,
        record_id: config[:treatment_request_id],
        title: "Referral Attachments",
        treatment_request_id: config[:treatment_request_id],
        parent_id: config[:treatment_request_id],

    }
  end

  component :asset_viewer do
    {
        class_name: "AssetViewer",
        title: "Routesheet",
        lazy_loading: true
    }
  end

  component :invoices do
    {
        class_name: "InvoiceList",
        lazy_loading: true,
        scope: "invoices.invoice_type !='R' and invoices.treatment_id IN(select id from patient_treatments pt where patient_id = #{config[:patient_id]})"
    }
  end

  component :soc_chart do
    {
        class_name: "SocChart",
        lazy_loading: true,
        treatment_id: (config[:treatment_id] if config[:treatment_id]),
        treatment_request_id: config[:treatment_request_id],
        chart_episode_id: config[:episode_id]
    }
  end

  component :physicians do
    {
        class_name: "TreatmentPhysicians",
        lazy_loading: true,
        parent_id: config[:treatment_id],
        treatment_id: config[:treatment_id]
    }
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    result = super
    new_params.keys.each{|k| components[params[:name].to_sym].delete(k) }
    result
  end

  def tree_nodes(config)
    {text: "Dashboard", expanded: true,
     children: children(config)
    }
  end

  def children(config)
    if (User.current.field_staff? && User.current.clinical_staff.blank?)
      soc_nodes(config)
    elsif config[:record_type] == 2
      [patient_information_node(config)]
    else
      treatment_request = TreatmentRequest.find(config[:treatment_request_id])
      res = treatment_request.insurance_company.private_insurance? ? [patient_information_node(config)] : [patient_information_node(config), billing_node(config)]
      res  + soc_nodes(config)
    end
  end

  def billing_node(config)
    params = {treatment_id: config[:treatment_id], treatment_request_id: config[:treatment_request_id],
              patient_id: config[:patient_id], record_type: config[:record_type], episode_id: config[:episode_id]}
    {text: "Billing", component: :invoices, leaf: true, params: params}
  end

  def patient_information_node(config)
    params = {treatment_id: config[:treatment_id], treatment_request_id: config[:treatment_request_id],
              patient_id: config[:patient_id], record_type: config[:record_type], episode_id: config[:episode_id]}
    {text: "Patient Information", component: :patient_edit_form, leaf: true, params: params}
  end

  def soc_nodes(config)
    rec = @treatment || @referral
    return [] unless rec
    rec.patient.treatment_requests.collect{|tr|
      treatment = tr.patient_treatment
      params = {treatment_id: (treatment ? treatment.id : nil), treatment_request_id: tr.id, patient_id: tr.patient_id, record_type: config[:record_type]}
      if treatment.present?
        soc_text =  "SOC #{treatment.treatment_start_date.strftime("%m/%d/%Y")} <font color='#{PatientTreatment::STATUS_DISPLAY_COLOR[treatment.treatment_status]}'>(#{PatientTreatment::STATUS_DISPLAY[treatment.treatment_status]})</font>"
        if (User.current.field_staff? && User.current.clinical_staff.blank?)
          { text: soc_text, children: [] + [medications_node(params)] + individual_episode_nodes(treatment, params),
            expanded: (treatment == @treatment)
          }
        else
          {text: soc_text, component: :soc_chart, params: {treatment_id: treatment.id, treatment_request_id: tr.id},
           children: [referral_node(params), staffing_node(params), network_node(params)] +
               [medications_node(params)]  + individual_episode_nodes(treatment, params), expanded: (treatment == @treatment)
          }
        end
      else
        {text: "SOC <font color=gray>(NA)</font>", component: :soc_chart, params: {treatment_request_id: tr.id},
         children: [referral_node(params), referral_staffing_node(params), network_info(params)], expanded: true}
      end
    }
  end

  def referral_attachments_node(referral)
    {text: "Referral Attachments", component: :referral_attachments_list, leaf: true, params: {treatment_request_id: referral.id}}
  end

  def referral_node(params)
    {text: "Referral", component: :referral_edit_form, leaf: true, params: params}
  end

  def referral_staffing_node(params)
    {text: "Staffing", component: :staffing, leaf: true, params: params}
  end

  def network_info(params)
    {text: "Network Info", children: caregiver_node(params)}
  end

  def caregiver_node(params)
    {text: "Caregivers", component: :care_givers, leaf: true, params: params}
  end

  def staffing_node(params)
    {text: "Staffing", component: :treatment_staffing, leaf: true, params: params}
  end

  def network_node(params)
    {text: "Network", children: [{text: "Physicians", component: :physicians, leaf: true, params: params}]}
  end

  def medications_node(params)
    {text: "Medications", component: :medications_list, leaf: true, params: params}
  end

  def individual_episode_nodes(treatment, params)
    treatment.treatment_episodes.order('start_date DESC').collect{|e|
      params = params.merge({episode_id: e.id})
      {text: "Cert #{e.certification_period} (#{TreatmentEpisode::STATUS_DISPLAY[e.medicare_bill_status]})" ,
       component: :patient_dashboard, params: params,
       children: [schedule_node(params), visits_node(params), all_documents_node(params), discipline_node(params)],
       expanded: (e == @episode)
      }
    }
  end

  def schedule_node(params)
    {text: "Schedule", component: :schd_visit_exp, params: params, leaf: true}
  end

  def visits_node(params)
    {text: "Visits", component: :visit_docs_exp, children: [], params: params}
  end

  def discipline_node(params)
    {text: "Disciplines", component: :treatment_disciplines, children: [], params: params}
  end

  def all_documents_node(params)
    {text: "Documents", component: :all_documents, params: params, leaf: true}
  end

  def visit_document_nodes(visit)
    visit.documents.collect{|d|
      comp_name = "document_#{d.id}".to_sym
      self.class.component comp_name do
        {class_name: "Documents::#{d.document_form_template.document_class_name}",
         title: d.document_name,
         record_id: d.id
        }
      end
      {
          text: d.document_name,
          leaf: true,
          icon: uri_to_icon(:application_form),
          component: comp_name
      }
    }
  end

  def routesheet_node(url)
    {
        text: "Routesheet",
        icon: uri_to_icon(:attach),
        component: :asset_viewer,
        leaf: true,
        params: {url: url }
    }
  end

end
