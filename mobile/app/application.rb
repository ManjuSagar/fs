require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    #To remove default toolbar uncomment next line:
    @@toolbar = nil
    super
    @default_menu = {"View Log" => :log, "Close" => :close}
    #check_network
		build_version = Rho::RhoConfig.build_version
		WebView.execute_js("BUILD_VERSION='#{build_version}';")
    # Uncomment to set sync notification callback to /app/Settings/sync_notify.
    # SyncEngine::set_objectnotify_url("/app/Settings/sync_notify")
    # SyncEngine.set_notification(-1, "/app/Settings/sync_notify", '')
  end

  def on_activate_app
  	#check_network
  	WebView.execute_js("activateApp();")
  end

	def check_network
  	if System.get_property("has_network") == false
  		Alert.show_popup({:title => "Application requires Internet connection.  Please check your network settings.", 
  		:callback => "/app/Main/exit_app", :buttons => ["OK"]})
  	end

	end  
end
