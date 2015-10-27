require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class RoutesheetController < Rho::RhoController
  include BrowserHelper

  # GET /Routesheet
  def index
    @routesheets = ::JSON.generate(Routesheet.find(:all))
    @response['headers']['Content-Type']='application/json; charset=utf-8' 
	  render :string => @routesheets, :back => "callback:" + url_for(:controller => "Main", :action => "back_callback")
  end

  # GET /Routesheet/{1}
  def show
    @routesheet = Routesheet.find(@params['id'])
    if @routesheet
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Routesheet/new
  def new
    @routesheet = Routesheet.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Routesheet/{1}/edit
  def edit
    @routesheet = Routesheet.find(@params['id'])
    if @routesheet
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Routesheet/create
  def create
  	#Routesheet.delete_all
  	p = Rho::JSON.parse(@request["request-body"])
    puts p.inspect
  	@routesheet = Routesheet.create(p)
    redirect :action => :index
  end

  # POST /Routesheet/{1}/update
  def update
    @routesheet = Routesheet.find(@params['id'])
    @routesheet.update_attributes(@params['routesheet']) if @routesheet
    redirect :action => :index
  end

  # POST /Routesheet/{1}/delete
  def delete
    p = Rho::JSON.parse(@request["request-body"])
    @routesheet = Routesheet.find({"id" => p["id"]})[0] rescue nil
    @routesheet.destroy if @routesheet
    redirect :action => :index  
  end
end
