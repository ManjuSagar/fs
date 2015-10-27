require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class UserSettingController < Rho::RhoController
  include BrowserHelper

  # GET /UserSetting
  def index
    @user_settings = ::JSON.generate(UserSetting.find(:first))
    @response['headers']['Content-Type']='application/json; charset=utf-8' 
	  render :string => @user_settings, :back => "callback:" + url_for(:controller => "Main", :action => "back_callback")
  end

  # GET /UserSetting/{1}
  def show
    @user_setting = UserSetting.find(@params['id'])
    if @user_setting
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /UserSetting/new
  def new
    @user_setting = UserSetting.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /UserSetting/{1}/edit
  def edit
    @user_setting = UserSetting.find(@params['id'])
    if @user_setting
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /UserSetting/create
  def create
  	UserSetting.delete_all
  	p = Rho::JSON.parse(@request["request-body"])
  	@user_setting = UserSetting.create(p)
    redirect :action => :index
  end

  # POST /UserSetting/{1}/update
  def update
    p = Rho::JSON.parse(@request["request-body"])
    puts "INPUT-#{p.inspect}"
    @user_setting = UserSetting.find({"id" => p["id"]})[0] rescue nil
    @user_setting.update_attributes(p) if @user_setting
    redirect :action => :index
  end

  # POST /UserSetting/{1}/delete
  def delete
    p = Rho::JSON.parse(@request["request-body"])
    @user_setting = UserSetting.find({"id" => p["id"]})[0] rescue nil
    @user_setting.destroy if @user_setting
    redirect :action => :index  
  end
end
