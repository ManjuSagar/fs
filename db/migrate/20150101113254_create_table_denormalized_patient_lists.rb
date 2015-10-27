class CreateTableDenormalizedPatientLists < ActiveRecord::Migration
  def self.up
    create_table :denormalized_patient_lists do |t|
      
      t.integer :patient_id 
      
      t.string :first_name 
      
      t.string :last_name 
      
      t.string :patient_reference 
      
      t.string :full_name 
      
      t.integer :org_id 
      
      t.string :p_eligibility_flag 
      
      t.string :p_staffing_flag 
      
      t.string :p_referral_flag 
      
      t.string :p_oasis_flag 
      
      t.string :p_poc_flag 
      
      t.string :p_dc_flag 
      
      t.string :p_fc_flag 
      
      t.string :p_rap_flag 
      
      t.string :p_doc_flag 
      
      t.string :p_mo_flag 
      
      t.string :patient_status 
      
      t.integer :patient_record_type 
      
      t.integer :treatment_request_id 
      
      t.string :treatment_request_events 
      
      t.string :treatment_request_staffing_flag 
      
      t.string :treatment_request_ref_received_flag 
      
      t.string :treatment_request_eligibility_flag 
      
      t.string :treatment_request_disciplines_display 
      
      t.string :treatment_request_oasis_flag 
      
      t.string :treatment_request_poc_flag 
      
      t.string :treatment_request_dc_flag 
      
      t.string :treatment_request_fc_flag 
      
      t.string :treatment_request_rap_flag 
      
      t.string :treatment_request_doc_flag 
      
      t.string :treatment_request_mo_flag 
      
      t.string :treatment_request_status 
      
      t.integer :treatment_request_record_type 
      
      t.integer :patient_treatment_id 
      
      t.string :patient_treatment_treatment_status 
      
      t.string :patient_treatment_soc_date 
      
      t.string :patient_treatment_treatment_status_display 
      
      t.integer :patient_treatment_record_type 
      
      t.integer :e_id 
      
      t.date :e_start_date 
      
      t.date :e_end_date 
      
      t.string :e_episode_status 
      
      t.string :e_certification_period 
      
      t.string :e_staffing_flag 
      
      t.string :e_eligibility_check_flag 
      
      t.string :e_referral_received_flag 
      
      t.string :e_oasis_document_completed_flag 
      
      t.string :e_plan_of_care_completed_flag 
      
      t.string :e_discharged_flag 
      
      t.string :e_final_claim_sent_flag 
      
      t.string :e_disciplines_display 
      
      t.string :e_rap_status 
      
      t.string :e_documents_status 
      
      t.string :e_medical_orders_status 
      
      t.string :e_events 
      
      t.timestamps
    end
  end
  def self.down
    drop_table :denormalized_patient_lists
  end
end
