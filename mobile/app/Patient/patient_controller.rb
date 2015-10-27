require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class PatientController < Rho::RhoController
  include BrowserHelper

  # GET /Patient
  def index
    puts "Count of Patients@@@@@@@-#{Patient.find(:all).size}"
    @patients = ::JSON.generate(Patient.find(:all))
    @response['headers']['Content-Type']='application/json; charset=utf-8' 
    render :string => @patients, :back => "callback:" + url_for(:controller => "Main", :action => "back_callback")
  end

  # GET /Patient/{1}
  def show
    @patient = Patient.find(@params['id'])
    if @patient
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Patient/new
  def new
    @patient = Patient.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Patient/{1}/edit
  def edit
    @patient = Patient.find(@params['id'])
    if @patient
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Patient/create
  def create
    p = Rho::JSON.parse(@request["request-body"])
    @patient = Patient.create(p)
    
    redirect :action => :index
  end

  # POST /Patient/{1}/update
  def update
    @patient = Patient.find(@params['id'])
    @patient.update_attributes(@params['patient']) if @patient
    redirect :action => :index
  end

  # POST /Patient/{1}/delete
  def delete
    p = Rho::JSON.parse(@request["request-body"])
    @patient = Patient.find({"id" => p["id"]})[0] rescue nil
    @patient.destroy if @patient
    redirect :action => :index  
  end
end
