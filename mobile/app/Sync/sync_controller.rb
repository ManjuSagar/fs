require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'net/http'

class SyncController < Rho::RhoController
  include BrowserHelper

  def sync
  	routesheets = Routesheet.find(:all)
  	user_setting = UserSetting.find(:first)
  	server_url = user_setting.server_url
  	puts UserSetting.find(:first).inspect
	url = URI.parse(server_url + "/mobile/sync")
	
	http = Net::HTTP.new(url.host, url.port)
	#https.use_ssl = true

	request = Net::HTTP::Post.new(url.path)
	request["Content-Type"] = "application/json"
	encoded_user_name = Rho::RhoSupport.url_encode(user_setting.username)
	encoded_password = Rho::RhoSupport.url_encode(user_setting.password)
	success_ids = []
	failure_ids = []
	Routesheet.find(:all).each do |routesheet|
		route_sheet_json_string = routesheet.to_json
		route_sheet_json = Rho::JSON.parse(route_sheet_json_string)
		route_sheet_json[:username] = user_setting.username
		route_sheet_json[:password] = user_setting.password
		request.body =  ::JSON.generate(route_sheet_json)
		response = http.request(request)
		response_json = Rho::JSON.parse(response.body)
		if response_json["status"] == "success"
			success_ids << routesheet.id
		else
			failure_ids << {routesheet_id: routesheet.id, error_message: response_json["message"]}
		end
	end
	render :string => ::JSON.generate({success_ids: success_ids, failure_ids: failure_ids})
  end

end

