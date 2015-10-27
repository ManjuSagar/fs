if Rails.env == "production"
  Rails.configuration.to_prepare do
    load 'netzke_basepack_patch.rb'
    load 'auto_session_timeout_patch.rb'
  end
else
  require 'netzke_basepack_patch'
  require 'auto_session_timeout_patch'
end