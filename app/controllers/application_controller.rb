class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "application"
  auto_session_timeout_ms 2.hours

  before_filter :reset_current_user, :set_current_user, :reset_events, :clear_temporary_session_expiry_time

  def customized_transaction
    agency = if (User.current and User.current.office_staff?)
                 User.current.orgs.first.to_s[0..2]
             end
    url = "#{request.params[:controller]}/#{request.params[:action]}"
    txn_name = agency.present? ? "#{agency}/#{url}" : url
    NewRelic::Agent.set_transaction_name txn_name
  end

  protected

  def clear_temporary_session_expiry_time
    if session[:reset_session_time_expiry_on_next_request]
      session[:auto_session_expires_at] = nil
      session.delete(:reset_session_time_expiry_on_next_request)
    end
  end

  private

  def set_current_user
    User.current = current_user
  end

  def reset_events
    Thread.current[:events] = {}
  end

  def reset_current_user
    Org.current = nil
    Thread.current[:user] = nil
  end

end
