class ComponentsController < ApplicationController



  # This is useful for individual component testing
  def index
    if params[:component]
      component_name = params[:component].gsub("::", "_").underscore
      render :inline => "<%= netzke :#{component_name}, :class_name => '#{params[:component]}', :height => 400 %>", :layout => true
    else
      redirect_to root_path
    end
  end

  # This is mapped to "/"
  def home
    if Netzke::Core.current_user.role == "Admin" then
      render :inline => "<%= netzke :admin_application %>", :layout => true
    elsif Netzke::Core.current_user.role == "Client"  then
      render :inline => "<%= netzke :client_application %>", :layout => true
    else
      redirect_to "/log_in"
    end
  end
end
