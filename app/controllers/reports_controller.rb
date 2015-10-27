class ReportsController < ApplicationController

  respond_to :pdf

  def generate
    customized_transaction
    doc_id = params[:document_id]
    @document  = Document.find_by_id(doc_id)
    report_file_name = @document.document_form_template.report_file_name
    respond_with @document, :template => "#{report_file_name}/#{report_file_name}.jasper"
  end

  def generate_case_worksheet
    customized_transaction
    patient_id = params[:patient_id]
    @patient = Patient.find_by_id(patient_id)
    respond_with @patient, :template => "face_sheet/face_sheet.jasper"
  end

  def generate_medication_list
    customized_transaction
    date = params[:date].to_date
    treatment_id = params[:treatment_id]
    treatment = PatientTreatment.find(treatment_id)
    @tm = treatment.medications.first
    @tm.medication_list_date = date
    respond_with @tm, :template => "medication/medication.jasper"
  end

  # Using pre_generated action causing previous request value is stored in session. To prevent showing last patient data we are sending file name in url.
  def generated
    customized_transaction
    send_data  File.open("#{Rails.root}/tmp/" + params[:file_name]  + ".pdf").read, :type => Mime::PDF,
              :disposition => 'inline'
  end

  def pre_generated
    customized_transaction
    send_data  File.open(session[:pre_generated_file_name]).read, :type => Mime::PDF,
              :disposition => 'inline'
  end
end
