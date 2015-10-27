class WelcomeController < ApplicationController
  layout "application"
  before_filter :authenticate_user!, :except => [:login, :reset_password]
  auto_session_timeout_actions

  def index
    customized_transaction
    User.current = current_user
    @page_loading = true
    if params[:component].nil?
      session[:current_page] = session[:home_page_component]
    end
    render :inline => "<%= netzke :app%>", :layout => true
  end

  def collect_components(pages, components)
    pages.each {|page|
      if page.include?("children")
        collect_components(page["children"],components)
      else
        components << page['class_name']
      end

    }
    components
  end

  def component
    user_role = current_user.class.name
    @component_loading = true
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
    valid_pages = YAML::load(File.open("config/navigations/#{user_role}_pages.yml"))
    pages = valid_pages['pages']
    component = []
    components = collect_components(pages, component)
    customized_list = ["p_profile"]
    if components.reject{|a| a.nil?}.include?(params[:component])
      session[:current_page] = params[:component]
    elsif customized_list.include? params[:component]
      session[:current_page] = params[:component].camelize
    end
    customized_transaction
    User.current = current_user
    render :inline => "<%= netzke :app %>", :layout => true
  end

  def login
    customized_transaction
    render :inline => "<%= netzke :login %>", :layout => true
  end

  def reset_password
    customized_transaction
    render :inline => "<%=netzke :reset_password %>", :layout => true
  end

  def may_be_logging_out
    customized_transaction
    session[:auto_session_expires_at] = Time.now + 5
    session[:reset_session_time_expiry_on_next_request] = true
    render :text => 'ok', :layout => false
  end

  def switching_tabs
    render :text => 'ok', :layout => false
  end


  def assign_supervised_user
    user, visit_id = params[:id].split('-')
    visit = TreatmentVisit.find(visit_id)
    org = visit.treatment.patient.org
    visit.supervised_user = FieldStaff.org_scope(org).find(user)
    visit.save!(:validate => false)
    render :text => 'ok', :layout => false
  end

end
