require 'rubygems'
require 'sinatra'
require 'sinatra/jsonp'
require 'webrick'
require 'yaml'

class FasterNotes  < Sinatra::Base
  helpers Sinatra::Jsonp

  get '/mobile/version' do
		JSONP({version: 100}, params[:callback])
  end  

  get '/mobile/authenticate' do
  	@logged_in = (params["user"]["password"] == "test")
		JSONP erb(:login_response), params[:callback]
  end

  get '/mobile/sync' do
    JSONP erb(:login_response), params[:callback]
  end

  get '/mobile/patients' do
    #This should return a json of all patient fields with a nested collection of "visit_types"
    #visit type entity should contain visit_type_id and visit_type_description
    JSONP erb(:patients_list), params[:callback]
  end

end

webrick_options = {
  :Port               => 8080,
  :Logger             => WEBrick::Log::new($stderr, WEBrick::Log::DEBUG),
  :DocumentRoot       => "/ruby/htdocs",
  :SSLEnable          => false,
  :app                => FasterNotes
}

Rack::Server.start webrick_options
