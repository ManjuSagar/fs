class MobileController < ApplicationController
  ActiveRecord::Base.include_root_in_json = true
  MAX_ITEMS_SERVER_LIMIT = 50

  skip_before_filter :verify_authenticity_token

  before_filter :check_credentials, :except => [:authenticate]
  after_filter :set_content_type
  skip_filter :require_user

  def authenticate
    if authenticate_and_create_user_session(params[:user][:username], params[:user][:password])
			render :json => {:status => "success"}, :callback => params[:callback]
		else
			render :json => {:error => "Invalid User Name or password."}, :callback => params[:callback]
		end
  end

  def sync
    #debug_log params.inspect
    e = ElectronicRoutesheet.new(:visit_type_id => params[:visit_type_id], :location_latitude => params[:latitude], :location_longitude => params[:longitude])
    e.visit_start_time = params[:start_time].to_time.strftime("%I:%M %p") if params[:start_time]
    e.visit_end_time = params[:end_time].to_time.strftime("%I:%M %p") if params[:end_time]
    e.frequency_string = "2wk1"
    e.treatment_episode = params[:episode_id]
    e.treatment_id = params[:treatment_id]
    e.systolic_bp = 90
    e.diastolic_bp = 120
    e.heart_rate = 72
    e.respiration_rate = 92
    e.temperature_in_fht = 96
    e.bp_read_location = "L"
    e.bp_read_position = "S"
    e.patient_signature_data = params[:patient_signature]['data:image/png;base64,'.length .. -1]
    begin
      e.save!
      render :json => {:status => "success"}
    rescue
      puts "ERROR"
      puts e.errors.full_messages
      render :json => {:status => "failure", :message => e.errors.full_messages.join("\n")}
    end
   end

  def patients
    treatments = PatientTreatment.fs_treatment_scope.where(["patient_treatments.treatment_status IN ('A')"])
    results = treatments.reject{|t| t.current_episode.nil?}.collect{|treatment|
                patient = treatment.patient
                episode = treatment.current_episode
                fields_hash = {}
                patients_list_fields.each{|field|
                  attr = field.keys.first
                  puts "Attr = #{attr}"
                  puts episode.inspect                  
                  fields_hash[attr] = if attr == :visit_types
                                        visit_types_for_patient(treatment)
                                      elsif attr == :treatment_id
                                        treatment.id
                                      elsif attr == :episode_id and episode
                                        episode.id
                                      elsif attr == :episode and episode
                                        episode.to_s
                                      else
                                        patient.send(attr) rescue nil
                                      end
                }
                {patient: fields_hash}
              }
              puts results.as_json(root: true)

    render :json => results.as_json(root: true), :callback => params[:callback]
  end

  def data_version
    render :json => {:version => "1234"}.to_json, :callback => params[:callback]
  end

  private

  def check_credentials
    unless authenticate_and_create_user_session(params[:username], params[:password])
      render :json => {:error => "Invalid User Name or password."}, :callback => params[:callback]
      false
    else
      User.current = @user
      true
    end

  end

  def authenticate_and_create_user_session(username, password)
    @user = User.find_by_email username
    return false unless @user.present?
    @user.valid_password?(password)
  end

  def remove_current_user_instance_variables
    remove_instance_variable(:@current_user)
    remove_instance_variable(:@current_user_session)    
  end
  
  def set_content_type
    response.headers["Content-Type"] = "text/javascript"
  end

  def patients_list_fields
    [
        {:id => "Id"},
        {:full_name => "Full Name"},
        {:phone_number => "Phone Number"},
        {:location => "Location"},
        {:age => "Age"},
        {:gender => "Gender"},
        {:visit_types => "Visit Types"},
        {:treatment_id => "Treatment Id"},
        {:episode_id => "Episode Id"},
        {:episode => "Episode"},
    ]
  end

  def route_sheet_fields
    [{:id => "Id"},
    {:visit_date => "Visit Date"},
    {:start_time => "Start Time"},
    {:end_time => "End Time"},
    {:latitude => "Latitude"},
    {:longitude => "Longitude"},
    {:visit_type_id => "Visit Type Id"},
    {:episode_id => "Episode Id"},
    {:patient_signature => "Patient Signature"},
    {:treatment_id => "Treatment Id"},
    {:patient_id => "Patient Id"},
    {:remarks => "Remarks"},
    {:patient_name => "Patient Name"}
    ]
  end

  def visit_types_for_patient(treatment)
    episode = treatment.current_episode if treatment
    return [[]] if episode.nil?
    treatment_staffs = treatment.treatment_staffs.staffed.where({:staff_type => "User", :staff_id => @user.id})
    org = treatment.patient.org
    list = []
    treatment_staffs.each do |ts|
      if ts.visit_type.present? and ts.discipline.present?
        list << ["#{ts.discipline_id}__#{ts.visit_type_id}", ts.visit_type.visit_type_description] if visit_type_allowed?(treatment, episode, ts.visit_type, ts.discipline)
      elsif ts.discipline.present?
        ts.discipline.visit_types.where(["org_id = ?", org.id ]).each{|vt|
          unless treatment_staffs.any?{|x| x.discipline == ts.discipline and x.visit_type == vt}
            list << ["#{ts.discipline_id}__#{vt.id}", vt.visit_type_description] if visit_type_allowed?(treatment, episode, vt, ts.discipline)
          end
        }
      else
        list << ["__#{ts.visit_type.id}", ts.visit_type.visit_type_description] if visit_type_allowed?(treatment, episode, ts.visit_type)
      end
    end
    list.to_json
  end

  def visit_type_allowed?(treatment, episode, visit_type, discipline = nil)
    context =  discipline.present? ? episode.treatment_disciplines.find_by_discipline_id(discipline.id) : treatment
    visit_type.allowed_for?(context) and visit_type.license_types.include?(User.current.license_type)
  end


end
