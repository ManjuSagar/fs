class StaffingCompanyList < Mahaswami::GridPanel

  def initialize(conf = {}, parent_id = nil)
    super
    org = StaffingCompany.find_by_id_and_draft_status(component_session[:sample_company_id], true)
    component_session[:sample_company_id] = if org
                                              org.id
                                            else
                                              sample_org = StaffingCompany.new
                                              sample_org.draft_status = true
                                              sample_org.save(:validate => false)
                                              sample_org.id
                                            end

    components[:add_staffing_company][:items].first.merge!(:record_id => component_session[:sample_company_id])
  end


  def configuration
    super.merge(
      model: "StaffingCompany",
      title: "Staffing Companies",
      item_id: "staffing_companies_list",
      #infinite_scroll: true,
      columns: [
        {name: :org_name, label: "Name", editable: false, width: "15%", addHeaderFilter: true},
        {name: :email, label: "Email", editable: false, width: "20%", addHeaderFilter: true},
        {name: :phone_number, label: "Phone Number", editable: false, width: "20%", addHeaderFilter: false},
        {name: :fax_number, label: "Fax Number", editable: false, width: "20%", addHeaderFilter: false}
      ],
      scope: :org_scope
    )
  end

  edit_form_config class_name: "StaffingCompanyEditForm"
  edit_form_window_config title: "Edit Staffing Company", width: "50%", height: "88%"

  action :add_company, text: "", tooltip: "Add Staffing Company", icon: :add_new, item_id: 'add_staffing_company_button'
  action :edit_in_form, text: "", tooltip: "Edit Staffing Company", item_id: 'edit_staffing_company_button'

  def default_bbar
    [:add_company.action, :edit_in_form.action]
  end

  def default_context_menu
    [:add_company.action, :edit_in_form.action]
  end

  js_method :on_add_company,<<-JS
    function(){
      this.loadNetzkeComponent({name: "add_staffing_company", callback: function(w){
        w.show();
        w.on('close', function(){
          if (w.closeRes === "ok") {
            this.store.load();
          }
        }, this);
      }, scope: this});
    }
  JS

  component :add_staffing_company do
    form_config = {
        :class_name => "StaffingCompanyEditForm",
        :border => true,
        :bbar => false,
        :is_sample_patient => true,
        :prevent_header => true,
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :width => "50%",
        :height => "88%",
        :title => "Add Staffing Company",
        :button_align => "right",
        :items => [form_config]
    }
  end
end