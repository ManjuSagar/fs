class FasternotesMailer < ActionMailer::Base
  default from: "fnpublic@gmail.com"

  def staffing_invitation(staffing_request, office_staff)
    debug_log "Sending staffing invitation..."
    @staffing_request = staffing_request
    @office_staff = office_staff
    mail(to: @staffing_request.staff.email, subject: "Staffing Request from #{@staffing_request.provider_name}")
  end

  def profile_access_request(org_user, office_staff)
    debug_log "Sending Profile Access Request"
    @org_user = org_user
    @office_staff = office_staff
    mail(to: @org_user.user.email, subject: "#{@org_user.org.to_s} wants to work with you!")
  end

  def fasternotes_user_access_information(user)
    debug_log "Sending Password Information"
    @user = user
    mail(to: @user.email, subject: "Welcome to FasterNotes!")
  end


  def user_password_reset_information(user)
    debug_log "Sending Reset Password Information"
    @user = user
    mail(to: @user.email, subject: "New password request")
  end

  def send_fda_library_import_notification(msg)
    debug_log "Sending FDA Library Import Notification"
    @msg = msg
    mail(to: "fnnotification@gmail.com", subject: "FasterNotes: FDA Library Import Notification")
  end

  def medical_order(medical_order, physician, office_staff)
    debug_log "Sending Medical Order "
    @medical_order = medical_order
    @physician = physician
    @office_staff = office_staff
    file_name = "#{@medical_order.treatment.patient.first_name}_#{@medical_order.treatment.patient.last_name}_medical_order.pdf"
    attachments[file_name] = File.read(@medical_order.printable_order.path)
    mail(to: @physician.email, subject: "MD Orders for Signature from #{@medical_order.agency_name}")
  end

  def batch_medical_order(medical_order, physician, pdf, office_staff)
    debug_log "Sending Batch Medical Orders"
    @medical_order = medical_order
    @physician = physician
    @office_staff = office_staff
    file_name = "#{@medical_order.treatment.patient.first_name}_#{@medical_order.treatment.patient.last_name}_medical_order.pdf"
    attachments[file_name] = File.read(pdf)
    mail(to: @physician.email, subject: "Batch of MD orders for Signature #{@medical_order.agency_name}")
  end

  def field_staff_profile_changes(params)
    @field_staff = params[:field_staff]
    @office_staff = params[:os]
    @name = params[:name]
    @org = params[:org]
    @edited_information = params[:edited_information]
    @added_credential = params[:added_credential]
    @removed_credential = params[:removed_credential]
    @updated_credential = params[:updated_credential]
    subject = "#{@office_staff.full_name} at #{@org.org_name} has made edits to your profile"
    mail(to: @field_staff.email, subject: subject)
  end

  def send_electronic_claim_transmission_status(params)
    debug_log "Sending Electronic Claim transmission status"
    @failure_reasons = ((params[:errors].is_a? Array) ? params[:errors].join(', ') : params[:errors])
    @status = params[:transmission_status]
    @transmission_status = MedicareClaimTransmissionLog.transmission_status @status
    @claim = params[:claim]
    @agency = params[:org]
    mail(to: "fnnotification@gmail.com", subject: "#{@agency.to_s} Electronic Claims Submission Status")
  end

  def send_era_file_download_status(params)
    debug_log "Sending ERA file download status"
    @status = params[:file_status]
    @agency = params[:org]
    @exceptions = params[:errors]
    @file_names = params[:file_names]
    mail(to: "fnnotification@gmail.com", subject: "#{@agency.to_s} ERA File Status")
  end
end
