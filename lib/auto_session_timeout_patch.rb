module AutoSessionTimeoutMS

  def self.included(controller)
    controller.extend ClassMethods
  end

  module ClassMethods
    def auto_session_timeout_ms(seconds=nil)
      prepend_before_filter do |c|
        if c.session[:auto_session_expires_at] && c.session[:auto_session_expires_at] < Time.now
          c.send :reset_session
        else
          unless c.url_for(c.params).start_with?(c.send(:active_url))
            #Don't reset auto session time out if user is logout.
            return unless current_user.present?
            offset = seconds || (current_user.respond_to?(:auto_timeout) ? current_user.auto_timeout : nil)
            c.session[:auto_session_expires_at] = Time.now + offset if offset && offset > 0
          end
        end
      end
    end
  end

end

ActionController::Base.send :include, AutoSessionTimeoutMS