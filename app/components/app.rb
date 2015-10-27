class App < Netzke::Basepack::SimpleApp
  js_include :app

  def context_specific_display
    if User.current.user_profile_completed?
      "#{construct_menus}</div><br/>"
    else
      "<br/><div style='margin:5px 5px 5px 20px;font-size:18px;color:red;'><b>#{profile_setup_msg}</b></div>"
    end
  end

  # Initial layout of the app.
  # <tt>status_bar_config</tt>, <tt>menu_bar_config</tt>, and <tt>main_panel_config</tt> are defined in SimpleApp.
  def configuration

    #page_loading = Netzke::Core.controller.instance_variable_get(:@page_loading)
    component_loading = Netzke::Core.controller.instance_variable_get(:@component_loading)
    reset_previous_page_session(component_loading)
    #return {} unless (page_loading.present? or component_loading.present?)
    sup = super

    debug_log "**** PARAMS from Controller"
    sup.merge(
        name: :app,
        padding: "20px",
        style: {
            border: "5px solid #A4A6A9",
            "-o-border-radius" => "10px",
            "-ms-border-radius" => "10px",
            "-moz-border-radius" => "10px",
            "-webkit-border-radius" => "30px",
            "border-radius" => "8px"
        },
        :items =>  [{
                        :region => :north,
                        :border => false,
                        :height => 70,
                        :items => [{
                            xtype: 'panel',
                            frame: false,
                            header: false,
                            height: 70,
                            :layout => :hbox,
                            border: 0,
                            items: [
                                {
                                    xtype: 'panel',
                                    flex: 0.8,
                                    frame: false,
                                    header: false,
                                    height: 70,
                                    border: 0,
                                    items: [
                                        {
                                            xtype: 'label',
                                            html: "<img  class='main_logo'/>"
                                        }
                                    ]

                                },
                                {
                                    xtype: 'panel',
                                    flex: 1,
                                    frame: false,
                                    header: false,
                                    border: 0,
                                    layout: {
                                        type: 'vbox',
                                        align:'right'
                                    },
                                    items: [
                                        {
                                            xtype: 'panel',
                                            frame: false,
                                            header: false,
                                            border: 0,
                                            items: [
                                                {
                                                    xtype: 'label',
                                                    :html => "<div id='test-lbl-text-align' width = 100%
                                                            style=margin-bottom:4px;text-align:right;color:grey;>
                                                              #{display_user_name} <span style='color:#2A81C9'>
                                                                #{org_info}</span>&nbsp;&nbsp;&nbsp;
                                                    <a style='color:grey;' href='/signout'>Logout</a></div>"
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            frame: false,
                                            header: false,
                                            border: 0,
                                            items: [
                                                {
                                                    xtype: 'label',
                                                    html: "<div width = 100% > #{context_specific_display}</div>"
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]}
                        ]
                    },
                    {
                        :region => :center,
                        :layout => :border,
                        :border => false,
                        :items => [status_bar_config, {
                            :region => :center,
                            :layout => :border,
                            :items => [main_panel_config(border: false)]
                        }]
                    }]
    )
  end

  def main_panel_config(overrides = {})
    component_class_name = if (not User.current.super_admin?) and (not User.current.consultant?) and (User.current.encrypted_sign_password.nil? or (not User.current.signature?))
                    session[:profile_not_completed] = true
                    session[:current_page] = if User.current.office_staff?
                                               "HaProfileSetting"
                                             elsif User.current.field_staff?
                                               "FieldStaffProfile"
                                             else
                                               nil
                                             end
                  else
                    session[:current_page] || session[:home_page_component]
                  end
    {
        :itemId => 'main_panel',
        :region => 'center',
        :layout => 'fit',
        :items => [:class_name =>  component_class_name, treatment_id: component_session[:treatment_id],
                   episode_id: component_session[:episode_id], record_type: component_session[:record_type],
                   patient_id: component_session[:patient_id], treatment_request_id: component_session[:treatment_request_id] ]
    }.merge(overrides)
  end

  def profile_setup_msg
    if User.current.office_staff?
      "Please complete your Profile Setup by setting Sign Password and Signature."
    else
      "Please complete your Profile Setup by setting Sign Password, Signature and Service Areas."
    end
  end

  def reset_previous_page_session(component_loading)
    if (component_loading.present?)
      session.keys.select{|k| k.starts_with?("#{self.global_id}__")}.each {|k| (session.delete(k))}
    end
  end

  def display_user_name
    "#{User.current.full_name(false)}"
  end

  def org_info
    " #{Org.current.to_s}" if User.current.office_staff? or User.current.consultant?
  end

  def app_title
    if User.current.super_admin?
      "Fasternotes Admin Console"
    elsif User.current.field_staff?
      "Fasternotes Field Staff Console"
    else
      Org.current.to_s || "Fasternotes"
    end
  end

  def construct_menus
    user_role = Netzke::Core.current_user.class.name
    user_role = case user_role
                  when 'SuperAdmin'
                    "SA"
                  when 'OrgStaff'
                    if User.current.orgs.first.is_a? HealthAgency
                      org_user = Org.current.org_users.detect{|ou| ou.user == User.current}
                      if org_user and org_user.role_type == "A"
                        "HA_admin"
                      else
                        "HA_staff"
                      end
                    else
                      "SC"
                    end
                  when 'FieldStaff'
                    if User.current.clinical_staff
                      "HA_staff"
                    else
                      "FS"
                    end

                  when 'Consultant'
                    "Consultant"
                end
    settings = YAML::load(File.open("config/navigations/#{user_role}_pages.yml"))
    session[:home_page_component] = settings['default']
    pages = settings['pages']
    out =[]
    out << "<div id=menu_container>"
    out << "<ul id=dropline>"
    out += construct_menu(pages)
    out << "</ul>"
    out << "</div>"
    out.join("\n")
  end

  def construct_menu(pages)
    user_profile_completed = User.current.user_profile_completed?
    return [] unless user_profile_completed
    pages.inject([]){|out, page|
      if page_has_children?(page)
        out << "<li><a class='down' tabindex=1 style='cursor:pointer;'>#{page["text"]}</a>"
        out << "<ul>"
        out += construct_menu(page["children"])
        out << "</ul>"
        out << "</li>"
      else
        clicker = if page_has_url(page)
                    "class='mainMenu' href=\"#{page['url']}\" target='_blank'"
                  else
                    page["class_name"].blank? ? "" : "onclick=\"window.location='/#{page["class_name"]}'\"   "
                  end
        out << "<li><a #{clicker} style='cursor:pointer;'>#{page["text"]}</a></li>"
      end
    }
  end


  def page_has_url(page)
    page.include?("url")
  end

  def get_children_pages
    user_role = Netzke::Core.current_user.class.name
    user_role = case user_role
                  when 'SuperAdmin'
                    "SA"
                  when 'OrgStaff'
                    if User.current.orgs.first.is_a? HealthAgency
                      "HA"
                    else
                      "SC"
                    end
                  when 'FieldStaff'
                    org_user = Org.current.org_users.detect{|ou| ou.user == User.current}
                    if User.current.clinical_staff
                      "HA_staff"
                    else
                      "FS"
                    end
                end
    settings = YAML::load(File.open("config/navigations/#{user_role}_pages.yml"))
    pages = settings['pages']
    process_pages(pages)
  end

  def navigation_title
    "#{Netzke::Core.current_user.to_s} - #{app_title}"
  end

  def process_pages(pages)
    pages.collect do |page|
      page["icon"] = get_icon_path(page)
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

  def get_icon_path(page)
    uri_to_icon(page["icon"])
  end

  #

  ## Components
  component :health_agency_explorer,
            :class_name => "HealthAgencyForm", lazy_loading: true

  component :health_agency,
            :class_name => "HealthAgencyGrid", lazy_loading: true

  component :client_list,
            :class_name => "OrgList", lazy_loading: true

  component :field_staff_list,
            :class_name => "FieldStaffList", lazy_loading: true

  component :associated_field_staff_list,
            :class_name => "AssociatedFieldStaffList", lazy_loading: true

  component :fs_ct,
            class_name: "FieldStaffCredentialTypeList", lazy_loading: true

  component :sf_ct,
            class_name: "StaffingCompanyCredentialTypeList", lazy_loading: true

  component :medication ,
            class_name: "MedicationList", lazy_loading: true

  component :physician,
            class_name: "PhysicianList", lazy_loading: true

  component :insurance_company,
            class_name: "InsuranceCompanyList", lazy_loading: true

  component :supplies_list, lazy_loading: true

  component :global_insurance_company,
            class_name: "GlobalInsuranceCompanyList", lazy_loading: true

  component :ins_comp_visit_rate,
            class_name: "InsCompVisitRateList", lazy_loading: true

  component :zip_code,
            class_name: "ZipCodesList", lazy_loading: true

  component :states,
            class_name: "StatesList", lazy_loading: true

  component :admins,
            :class_name => "AdminList", lazy_loading: true

  component :document_templates,
            class_name: "DocumentTemplates", lazy_loading: true

  component :sc_users_list,
            class_name: "OrganizationUsersList", lazy_loading: true, org_id: Org.current.id

  component :document_definitions,
            class_name: "DocumentDefinitions", lazy_loading: true

  component :documents,
            class_name: "Documents", lazy_loading: true

  component :payrolls, lazy_loading: true

  component :payrolls_explorer, class_name: "PayrollsExplorer", lazy_loading: true

  component :invoice_list, lazy_loading: true

  component :receivable_list, lazy_loading: true

  component :invoice_payment_list, lazy_loading: true

  component :payables,
            class_name: "PayableList", lazy_loading: true

  component :audits, lazy_loading: true

  component :pending_payrolls, class_name: "PendingPayrolls", lazy_loading: true
  
  component :consltnt_claims, class_name: "ConsltntClaims", lazy_loading: true

  component :ha_users_list do
    {
        class_name: "OrganizationUsersList",
        lazy_loading: true,
        model: "OrgStaff",
        org_id: Org.current.id
    }
  end

  component :communication_notes, lazy_loading: true

  component :staffing_requests, lazy_loading: true


  component :staffing_company_contracts, lazy_loading: true

  component :field_staff_staffing_request_list, lazy_loading: true

  component :vital_signs_reference_range_list, lazy_loading: true

  component :field_staff_patients, lazy_loading: true

  component :field_staff_treatment_visits, lazy_loading: true

  component :visit_types, lazy_loading: true

  component :patients, lazy_loading: true

  component :patient_referrals, lazy_loading: true

  component :medical_equipments, lazy_loading: true

  component :field_staff_patient_list_explorer, lazy_loading: true

  component :visit_frequencies, lazy_loading: true

  component :visits, lazy_loading: true

  component :patient_window, lazy_loading: true

  component :medical_orders, lazy_loading: true

  component :order_types, lazy_loading: true

  component :health_agency_profile, lazy_loading: true

  component :staffing_requirements, lazy_loading: true

  component :field_staff_credentials, lazy_loading: true


  component :field_staff_profile, lazy_loading: true

  component :oasis_documents, lazy_loading: true

  component :health_agency_user_profile, lazy_loading: true

  component :patients_list_explorer, lazy_loading: true


  component :staffing, lazy_loading: true

  component :cahps_data_export, lazy_loading: true

  component :episodes_list, lazy_loading: true

  component :patient_schedule_container do
    {
        class_name: "PatientScheduleContainer",
        lazy_loading: true,
        treatment_id: component_session[:treatment_id]
    }
  end

  component :medicare_bills, lazy_loading: true

  component :oasis_field_spec_list, lazy_loading: true

  component :all_documents, lazy_loading: true

  component :episodes_list_explorer, lazy_loading: true

  component :p_profile do
    {
        class_name: "PProfile",
        lazy_loading: true,
        treatment_id: component_session[:treatment_id],
        episode_id: component_session[:episode_id],
        record_type: component_session[:record_type],
        patient_id: component_session[:patient_id],
        treatment_request_id: component_session[:treatment_request_id]
    }
  end

  component :patient_schedules_with_patient_details do
    {
        class_name: "PatientSchedulesWithPatientDetails",
        treatment_id: component_session[:treatment_id],
        episode_id: component_session[:episode_id],
        record_type: component_session[:record_type]
    }
  end

  component :patient_schedule_container_new do
    {
        class_name: "PatientScheduleContainerNew",
        lazy_loading: true,
        treatment_id: component_session[:treatment_id],
        episode_id: component_session[:episode_id],
        record_type: component_session[:record_type]
    }
  end

  component :patient_profile do
    {
        class_name: "PatientProfile",
        lazy_loading: true,
        treatment_id: component_session[:treatment_id]
    }
  end

  component :soc_chart do
    {
        class_name: "SocChart",
        lazy_loading: true,
        treatment_id: component_session[:treatment_id],
        treatment_request_id: component_session[:treatment_request_id]
    }
  end


  action :about, :icon => :information
  action :sign_out, :icon => :application_go

  # Overrides SimpleApp#menu
  def menu
    ["->", :sign_out.action]
  end

  js_method :on_sign_out, <<-JS
    function() {
      window.location="/signout"
    }
  JS

  js_method :on_about, <<-JS
    function(e){
      var msg = [
        '',
        "&copy; Copyright FasterNotes 2012.  All rights reserved."
      ].join("<br/>");

      Ext.Msg.show({
        width: 300,
         title:'About',
         msg: msg,
         buttons: Ext.Msg.OK,
         animEl: e.getId()
      });
    }
  JS


  endpoint :load_home_page_component do |params|
    if (not User.current.super_admin?) and (User.current.encrypted_sign_password.nil? or (not User.current.signature?))
      session[:profile_not_completed] = true
      session[:current_page] = if User.current.office_staff?
                                 "ha_profile_setting"
                               elsif User.current.consultant?
                                  "consltnt_claims"
                               elsif User.current.field_staff?
                                 "field_staff_profile"
                               else
                                 nil
                               end
    end
    home_page = session[:current_page] || session[:home_page_component]
    if home_page
      {set_result: [home_page.camelize, home_page]}
    else
      {}
    end
  end
  # Overrides SimpleApp#process_history, to initially select the node in the navigation tree
  js_method :process_history, <<-JS
    function(token){
    return true;
      if (token) {
        var node = this.navigation.getStore().getRootNode().findChildBy(function(n){
          return n.raw.component == token;
        }, this, true);

        if (node) this.navigation.getView().select(node);
      }

      this.callParent([token]);
    }
  JS

  js_method :load_patients_list,<<-JS
    function(){
      var main_app = this;
      this.clearPatientProfileInformation({}, function(){
        this.setContext({}, function(){
          main_app.loadNetzkeComponent({name: "EpisodesListExplorer", container: main_app.mainPanel, params: {}});
        }, this);
      }, this);
    }
  JS

  endpoint :clear_patient_profile_information do |params|
    session.keys.select{|k| k.starts_with?("app__p_profile")}.each {|k| session.delete(k)}
    session.delete("app__p_profile")
    {}
  end

  endpoint :set_context do |params|
    params.each {|k,v| component_session[k.to_s.underscore.to_sym] = v}
    session_attrs = ["record_type", "patient_id", "treatment_request_id", "treatment_id", "episode_id"]
    resetable_attrs = session_attrs - params.keys.collect{|k| k.to_s.underscore}
    resetable_attrs.each{|attr| component_session[attr.to_sym] = nil}
    {}
  end

  def deliver_component_endpoint(params)
    debug_log params
    #session[:current_page] = params[:name]
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end

end
