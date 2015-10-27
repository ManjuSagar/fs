class Reports < Mahaswami::Panel
  include Mahaswami::NetzkeBase

  def initialize(conf = {}, parent = nil)
    super
  end

  def configuration
    c = super
    c.merge({
                title: 'Reports',
                layout: :border,
                itemId: :reports,
                items: [
                  {
                    xtype: "treepanel",
                    item_id: :report_tree,
                    width: 300,
                    height: 150,
                    region: :west,
                    root_visible: false,
                    root: tree_nodes,
                    cls: :patient_tree
                  },
                  {
                      region: :center,
                      item_id: :main_panel,
                      frame: true,
                      border: true,
                      margin: 0,
                      layout: :fit,
                      items: []
                  }
                ]

            })
  end


  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.down('#report_tree').getView().on('itemclick', function(e,node,i){
        this.displayNodeBody(node);
      }, this);
    }
  JS

  js_method :display_node_body, <<-JS
    function(r){
        if (r.raw.component) {
          if (r.raw.component == 'cost_report'){
            this.viewCostReport({}, function(url){
              this.loadNetzkeComponent({name: 'asset_viewer', container: this.up().down("#main_panel"),
                  params: {component_params: {url: url, title: "Cost Report"}}},this);
            },this);
          }else if (r.raw.component == "credential_report"){
            this.setLoading(true);
            this.viewCredentialReport({}, function(url){
              this.setLoading(false);
              this.loadNetzkeComponent({name: 'asset_viewer', container: this.up().down("#main_panel"),
                  params: {component_params: {url: url, title: "Credential Report"}}});
            });
          }
          else if (r.raw.component == "expiring_raps"){
            this.setLoading(true);
            this.viewExpiringRaps({}, function(url){
              this.setLoading(false);
              if(url)
                this.loadNetzkeComponent({name: 'asset_viewer', container: this.up().down("#main_panel"),
                  params: {component_params: {url: url, title: "Expiring RAPs Report"}}});
              else
                Ext.Msg.alert("Message", "No Records Found.");
            }, this);
          }
          else
            this.loadNetzkeComponent({name: r.raw.component, container: this.up().down("#main_panel")});
        }else{
            Ext.Msg.alert("Message", "Coming soon...");
        }
    }
  JS

  endpoint :view_cost_report do |params|
    d = CostReportDataSource.new
    session[:pre_generated_file_name] = d.to_pdf
    {:set_result => "/reports/pre_generated"}
  end

  endpoint :view_credential_report do |params|
    d = CredentialReportDataSource.new
    session[:pre_generated_file_name] = d.combined_reports
    {:set_result => "/reports/pre_generated"}
  end

  endpoint :view_expiring_raps do |params|
    e = ExpiringExpiredRapsReportDataSource.new
    url = e.get_report_url
    if url
      session[:pre_generated_file_name] = url
      {:set_result => "/reports/pre_generated"}
    else
      {:set_result => url}
    end
  end

  #component :cost_report, lazy_loading: true
  component :cahps_data_export, lazy_loading: true
  component :billed_claims_report_filter_options, lazy_loading: true
  component :missing_frequency_form do
    {
      class_name: "ReportsFilterOptions",
      lazy_loading: true,
      missing_frequency: true,
      title: "Missing Frequencies",
      itemId: :missing_frequencies
    }
  end

  component :therapy_re_evaluation_form do
    {
        class_name: "ReportsFilterOptions",
        lazy_loading: true,
        title: "Therapy Re Evaluations"
    }
  end

  component :rc_dc_planning_form do
    {
        class_name: "RcDcPlanningFilterForm",
        lazy_loading: true,
        title: "RC/DC Planning"
    }
  end

  component :asset_viewer do
    {
        class_name: "AssetViewer",
        lazy_loading: true
    }
  end

  component :unverified_medication_filter_form do
    {
        class_name: "UnverifiedMedicationFilterForm",
        title: "Unverified Medications",
        lazy_loading: true
    }
  end

  component :census_report_form do
    {
        class_name: "CensusReportForm",
        reports_page: true,
        lazy_loading: true,
        title: "Census Report"
    }
    end
  component :patient_history_and_diagnosis_poc do
    {
        class_name: "Documents::Oasis::PatientHistoryAndDiagnosisPoc",

    }
  end

  component :visit_list_report_form do
    {
        class_name: "VisitListReportForm",
        lazy_loading: true
    }
  end

  component :alrits_form do
    {
        class_name: "AlirtsForm",
        lazy_loading: true
    }
  end

  component :cost_report_form do
    {
        class_name: "CostReportForm",
        lazy_loading: true
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

  def tree_nodes
    settings = YAML::load(File.open("config/navigations/Reports_pages.yml"))
    pages = settings['pages']
    { expanded: true,
     children: process_pages(pages)
    }
  end

  def process_pages(pages)
    pages.collect do |page|
      if page_has_children?(page)
        page["expanded"] = true
        page["children"] = process_pages(page["children"])
      else
        page["leaf"] = true
      end
    end
    pages
  end

  def page_has_children?(page)
    page.include?("children")
  end


end