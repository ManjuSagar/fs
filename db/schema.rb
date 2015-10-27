# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150914075559) do

  create_table "all_documents", :force => true do |t|
    t.string   "documentable_type",    :null => false
    t.integer  "documentable_id",      :null => false
    t.integer  "lock_version",         :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "treatment_episode_id", :null => false
    t.string   "category"
    t.string   "staff"
    t.string   "description"
    t.string   "status"
    t.date     "document_date"
  end

  create_table "attachment_types", :force => true do |t|
    t.string   "attachment_code",        :limit => 50,                    :null => false
    t.string   "attachment_description", :limit => 100,                   :null => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.integer  "org_id"
    t.boolean  "system_required",                       :default => true, :null => false
    t.string   "type_status",            :limit => 1,                     :null => false
    t.date     "disabled_date"
  end

  create_table "audit_logs", :force => true do |t|
    t.string   "log_type",     :limit => 50,                :null => false
    t.integer  "lock_version",               :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
    t.integer  "org_id",                         :null => false
    t.datetime "updated_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "authorization_trackings", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "treatment_episode_id"
    t.integer  "insurance_company_id"
    t.integer  "discipline_id"
    t.integer  "field_staff_id"
    t.integer  "insurance_case_manager_id"
    t.string   "visit_count"
    t.string   "patient_number"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "authorization_number"
    t.text     "special_instructions"
    t.text     "internal_comments"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.boolean  "reported",                  :default => false
    t.boolean  "evaluation_sent",           :default => false
    t.boolean  "approval_received",         :default => false
    t.boolean  "visit_done",                :default => false
  end

  create_table "communication_notes", :force => true do |t|
    t.integer  "treatment_id",                                               :null => false
    t.integer  "treatment_episode_id",                                       :null => false
    t.integer  "physician_id",                                               :null => false
    t.date     "note_date_time",                                             :null => false
    t.text     "note_content"
    t.string   "note_status",                    :limit => 1,                :null => false
    t.integer  "created_user_id",                                            :null => false
    t.integer  "lock_version",                                :default => 0
    t.string   "printable_content_file_name"
    t.string   "printable_content_content_type"
    t.integer  "printable_content_file_size"
    t.datetime "printable_content_updated_at"
    t.integer  "medical_order_id"
    t.integer  "field_staff_id"
    t.integer  "note_type_id",                                               :null => false
    t.date     "created_user_sign_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consulting_company_health_agencies", :force => true do |t|
    t.integer  "consulting_company_id",                    :null => false
    t.integer  "health_agency_id",                         :null => false
    t.boolean  "active",                :default => false, :null => false
    t.integer  "lock_version"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "contact_types", :force => true do |t|
    t.string   "type_name",    :limit => 50,                :null => false
    t.integer  "lock_version",               :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "denormalized_patient_lists", :force => true do |t|
    t.integer  "patient_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "patient_reference"
    t.string   "full_name"
    t.integer  "org_id"
    t.string   "p_eligibility_flag"
    t.string   "p_staffing_flag"
    t.string   "p_referral_flag"
    t.string   "p_oasis_flag"
    t.string   "p_poc_flag"
    t.string   "p_dc_flag"
    t.string   "p_fc_flag"
    t.string   "p_rap_flag"
    t.string   "p_doc_flag"
    t.string   "p_mo_flag"
    t.string   "patient_status"
    t.integer  "patient_record_type"
    t.integer  "treatment_request_id"
    t.string   "treatment_request_events"
    t.string   "treatment_request_staffing_flag"
    t.string   "treatment_request_ref_received_flag"
    t.string   "treatment_request_eligibility_flag"
    t.string   "treatment_request_disciplines_display"
    t.string   "treatment_request_oasis_flag"
    t.string   "treatment_request_poc_flag"
    t.string   "treatment_request_dc_flag"
    t.string   "treatment_request_fc_flag"
    t.string   "treatment_request_rap_flag"
    t.string   "treatment_request_doc_flag"
    t.string   "treatment_request_mo_flag"
    t.string   "treatment_request_status"
    t.integer  "treatment_request_record_type"
    t.integer  "patient_treatment_id"
    t.string   "patient_treatment_treatment_status"
    t.string   "patient_treatment_soc_date"
    t.string   "patient_treatment_treatment_status_display"
    t.integer  "patient_treatment_record_type"
    t.integer  "e_id"
    t.date     "e_start_date"
    t.date     "e_end_date"
    t.string   "e_episode_status"
    t.string   "e_certification_period"
    t.string   "e_staffing_flag"
    t.string   "e_eligibility_check_flag"
    t.string   "e_referral_received_flag"
    t.string   "e_oasis_document_completed_flag"
    t.string   "e_plan_of_care_completed_flag"
    t.string   "e_discharged_flag"
    t.string   "e_final_claim_sent_flag"
    t.string   "e_disciplines_display"
    t.string   "e_rap_status"
    t.string   "e_documents_status"
    t.string   "e_medical_orders_status"
    t.string   "e_events"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "disciplines", :force => true do |t|
    t.string   "discipline_code",        :limit => 15,                 :null => false
    t.string   "discipline_description", :limit => 100,                :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.integer  "lock_version",                          :default => 0
    t.integer  "sort_order",                                           :null => false
  end

  create_table "doc_form_tpl_set_details", :force => true do |t|
    t.integer  "document_form_tpl_set_id",                 :null => false
    t.integer  "document_form_template_id",                :null => false
    t.integer  "lock_version",              :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_definitions", :force => true do |t|
    t.string   "document_code",             :limit => 20,                                                   :null => false
    t.string   "document_name",             :limit => 100,                                                  :null => false
    t.integer  "document_form_template_id",                                                                 :null => false
    t.boolean  "tied_to_visit_flag",                                                     :default => false
    t.string   "defn_status",               :limit => 2,                                                    :null => false
    t.boolean  "system_supplied_flag",                                                   :default => false
    t.integer  "org_id",                                                                                    :null => false
    t.boolean  "active_flag",                                                            :default => false
    t.decimal  "payable_rate",                             :precision => 8, :scale => 2
    t.integer  "lock_version",                                                           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_defn_set_details", :force => true do |t|
    t.integer  "document_defn_set_id",                  :null => false
    t.integer  "document_definition_id",                :null => false
    t.integer  "lock_version",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_defn_sets", :force => true do |t|
    t.string   "set_name",        :limit => 50,                 :null => false
    t.string   "set_description", :limit => 100,                :null => false
    t.string   "remarks",         :limit => 200
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "lock_version",                   :default => 0
  end

  create_table "document_form_templates", :force => true do |t|
    t.string   "template_name",           :limit => 30,                     :null => false
    t.string   "template_description"
    t.string   "document_class_name",     :limit => 100,                    :null => false
    t.text     "input_template_content"
    t.text     "report_template_content"
    t.string   "status",                  :limit => 2,                      :null => false
    t.string   "report_file_name",        :limit => 100
    t.integer  "lock_version",                           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "oasis",                                  :default => false
    t.string   "document_type"
  end

  create_table "document_form_tpl_sets", :force => true do |t|
    t.string   "set_name",        :limit => 50,                 :null => false
    t.string   "set_description", :limit => 100,                :null => false
    t.string   "remarks",         :limit => 200
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "lock_version",                   :default => 0
  end

  create_table "document_notes", :force => true do |t|
    t.integer  "document_id",                             :null => false
    t.datetime "note_date",                               :null => false
    t.text     "notes"
    t.integer  "created_user_id",                         :null => false
    t.integer  "treatment_episode_id",                    :null => false
    t.boolean  "event_changed"
    t.boolean  "archived",             :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.integer  "document_definition_id",                                   :null => false
    t.string   "document_type",                                            :null => false
    t.integer  "document_form_template_id",                                :null => false
    t.date     "document_date"
    t.text     "data"
    t.string   "status",                    :limit => 2,                   :null => false
    t.integer  "treatment_id",                                             :null => false
    t.integer  "treatment_episode_id"
    t.integer  "physician_id"
    t.integer  "visit_id"
    t.integer  "lock_version",                           :default => 0
    t.integer  "created_user_id",                                          :null => false
    t.boolean  "fs_sign_required"
    t.boolean  "supervisor_sign_required"
    t.boolean  "os_sign_required"
    t.integer  "agency_approved_user_id"
    t.integer  "field_staff_id"
    t.integer  "supervised_user_id"
    t.date     "fs_sign_date"
    t.date     "supervised_user_sign_date"
    t.date     "os_sign_date"
    t.integer  "correction_num"
    t.string   "unlock_reason",             :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "signed_user"
    t.string   "state_machine_id"
    t.boolean  "draft_flag",                             :default => true
  end

  create_table "dosage_forms", :force => true do |t|
    t.string   "form",         :null => false
    t.integer  "lock_version"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "drug_companies", :force => true do |t|
    t.string   "name",           :null => false
    t.text     "app_nos_string"
    t.integer  "lock_version"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "electronic_routesheets", :force => true do |t|
    t.integer  "visit_id",                            :null => false
    t.string   "location_latitude"
    t.string   "location_longitude"
    t.string   "signature_file_name",                 :null => false
    t.string   "signature_content_type",              :null => false
    t.integer  "signature_file_size",                 :null => false
    t.datetime "signature_updated_at",                :null => false
    t.string   "generated_status",       :limit => 2, :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "ethnicities", :id => false, :force => true do |t|
    t.string   "id",          :limit => 2,   :null => false
    t.string   "description", :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "export_batch_files", :force => true do |t|
    t.string   "oasis_export_file_name"
    t.string   "oasis_export_content_type"
    t.integer  "oasis_export_file_size"
    t.datetime "oasis_export_updated_at"
    t.integer  "lock_version"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "fda_drug_libraries", :force => true do |t|
    t.string   "drug_name",          :null => false
    t.string   "strength"
    t.string   "active_ingredients"
    t.string   "marketing_status",   :null => false
    t.integer  "form_id",            :null => false
    t.integer  "company_id",         :null => false
    t.integer  "lock_version"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "fda_drug_libraries", ["drug_name", "strength"], :name => "drug_name_and_strength_index"

  create_table "field_staff_credential_types", :force => true do |t|
    t.string   "ct_code",        :limit => 15,                 :null => false
    t.string   "ct_description", :limit => 100,                :null => false
    t.boolean  "expiry_flag",                                  :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "lock_version",                  :default => 0
    t.integer  "discipline_id"
  end

  create_table "field_staff_credentials", :force => true do |t|
    t.integer  "field_staff_id",                       :null => false
    t.integer  "credential_type_id",                   :null => false
    t.date     "expiry_date"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "comments"
    t.string   "credential_status",       :limit => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_staff_details", :force => true do |t|
    t.integer  "field_staff_id",                                              :null => false
    t.integer  "license_type_id",                                             :null => false
    t.integer  "lock_version",                             :default => 0
    t.string   "license_number",             :limit => 10
    t.text     "coverage_areas"
    t.boolean  "review_agency_changes_flag",               :default => false
    t.boolean  "clinical_staff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_library", :force => true do |t|
    t.string   "form_name",                 :limit => 50, :null => false
    t.string   "form_description",                        :null => false
    t.string   "form_content_file_name"
    t.string   "form_content_content_type"
    t.integer  "form_content_file_size"
    t.datetime "form_content_updated_at"
    t.string   "scope",                     :limit => 2
    t.integer  "org_id",                                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "free_form_templates", :force => true do |t|
    t.string   "template_short_description", :limit => 100,                :null => false
    t.text     "template_narrative"
    t.string   "template_category",          :limit => 100
    t.integer  "org_id",                                                   :null => false
    t.integer  "lock_version",                              :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ha_insurance_companies", :force => true do |t|
    t.string   "provider_number",      :limit => 15,                :null => false
    t.integer  "health_agency_id",                                  :null => false
    t.integer  "insurance_company_id",                              :null => false
    t.integer  "lock_version",                       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ha_sc_contract_details", :force => true do |t|
    t.integer  "contract_id"
    t.integer  "discipline_id"
    t.integer  "visit_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ha_sc_contract_doc_defn_rates", :force => true do |t|
    t.integer  "contract_id",                                                         :null => false
    t.integer  "document_definition_id",                                              :null => false
    t.decimal  "chargeable_rate",        :precision => 8, :scale => 2
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.integer  "lock_version",                                         :default => 0, :null => false
  end

  create_table "ha_sc_contract_vt_rates", :force => true do |t|
    t.integer  "contract_id",                                                :null => false
    t.integer  "visit_type_id",                                              :null => false
    t.decimal  "visit_rate",    :precision => 8, :scale => 2
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "lock_version",                                :default => 0, :null => false
    t.decimal  "hourly_rate",   :precision => 8, :scale => 2
  end

  create_table "ha_sc_contracts", :force => true do |t|
    t.integer  "health_agency_id",    :null => false
    t.integer  "staffing_company_id", :null => false
    t.datetime "contract_date",       :null => false
    t.date     "effective_from_date"
    t.date     "effective_to_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "health_agencies", :force => true do |t|
    t.string   "agency_name",          :limit => 100,                :null => false
    t.string   "agency_type",          :limit => 1,                  :null => false
    t.string   "provider_number",      :limit => 100,                :null => false
    t.string   "week_start_day",       :limit => 3,                  :null => false
    t.string   "suite_number",         :limit => 15
    t.string   "street_address",       :limit => 50,                 :null => false
    t.string   "city",                 :limit => 50,                 :null => false
    t.string   "state",                :limit => 2,                  :null => false
    t.string   "zip_code",             :limit => 10,                 :null => false
    t.string   "email",                :limit => 100,                :null => false
    t.string   "preferred_alert_mode", :limit => 1,                  :null => false
    t.text     "notes"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.integer  "lock_version",                        :default => 0
  end

  create_table "health_agency_details", :force => true do |t|
    t.string   "provider_number",                :limit => 100
    t.string   "agency_type",                    :limit => 1
    t.integer  "health_agency_id"
    t.integer  "document_form_tpl_set_id"
    t.integer  "document_defn_set_id"
    t.integer  "lock_version",                                  :default => 0
    t.string   "cms_cert_number"
    t.string   "npi_number"
    t.text     "data"
    t.string   "mr_num_start_with"
    t.string   "certificate_alias_name"
    t.string   "certificate_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "clm_billing_cert_alias_name",    :limit => 150
    t.string   "clm_billing_cert_password",      :limit => 150
    t.string   "submitter_id",                   :limit => 25
    t.boolean  "claims_electronic_transmission",                :default => false
    t.boolean  "print_insurance_address",                       :default => false
    t.boolean  "co_signature_optional",                         :default => false
  end

  create_table "hhrg_weights", :force => true do |t|
    t.integer  "hipps_code_id", :null => false
    t.decimal  "weight",        :null => false
    t.integer  "calender_year", :null => false
    t.integer  "lock_version"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "hipps_codes", :force => true do |t|
    t.string   "code",         :null => false
    t.string   "description"
    t.integer  "lock_version"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "icd10cm_to_icd9_gems", :force => true do |t|
    t.string   "icd10_code",    :limit => 10
    t.string   "icd9_code",     :limit => 10
    t.string   "approximation", :limit => 1
    t.string   "no_map",        :limit => 1
    t.string   "combination",   :limit => 1
    t.string   "scenario",      :limit => 3
    t.string   "choice_list",   :limit => 3
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "icd9_to_icd10_cm_gems", :force => true do |t|
    t.string   "icd9_code",     :limit => 10
    t.string   "icd10_code",    :limit => 10
    t.string   "approximation", :limit => 1
    t.string   "no_map",        :limit => 1
    t.string   "combination",   :limit => 1
    t.string   "scenario",      :limit => 3
    t.string   "choice_list",   :limit => 3
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "icd9_to_icd10_pcs_gems", :force => true do |t|
    t.string   "icd9_code",     :limit => 10
    t.string   "icd10_code",    :limit => 10
    t.string   "approximation", :limit => 1
    t.string   "no_map",        :limit => 1
    t.string   "combination",   :limit => 1
    t.string   "scenario",      :limit => 3
    t.string   "choice_list",   :limit => 3
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "icd_10_diagnostic_codes", :force => true do |t|
    t.string   "icd_code",          :limit => 10, :null => false
    t.string   "short_description"
    t.string   "long_description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "icd_10_diagnostic_codes", ["icd_code"], :name => "index_icd_10_diagnostic_codes_on_icd_code", :unique => true

  create_table "icd_10_procedure_codes", :force => true do |t|
    t.string   "icd_code",          :limit => 10, :null => false
    t.string   "short_description"
    t.string   "long_description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "icd_10_procedure_codes", ["icd_code"], :name => "index_icd_10_procedure_codes_on_icd_code", :unique => true

  create_table "icd_9_codes", :force => true do |t|
    t.string   "icd_code",          :limit => 10,  :null => false
    t.string   "short_description", :limit => 100, :null => false
    t.string   "long_description",                 :null => false
    t.string   "code_type",         :limit => 1,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "icd_9_codes", ["icd_code"], :name => "index_icd_9_codes_on_icd_code", :unique => true

  create_table "icd_9_diagnostic_codes", :force => true do |t|
    t.string   "icd_code",          :limit => 7,   :null => false
    t.string   "short_description", :limit => 100
    t.string   "long_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "icd_9_diagnostic_codes", ["icd_code"], :name => "index_icd_9_diagnostic_codes_on_icd_code", :unique => true

  create_table "icd_9_procedure_codes", :force => true do |t|
    t.string   "icd_code",          :limit => 7,   :null => false
    t.string   "short_description", :limit => 100
    t.string   "long_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "icd_9_procedure_codes", ["icd_code"], :name => "index_icd_9_procedure_codes_on_icd_code", :unique => true

  create_table "insurance_case_managers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.integer  "insurance_company_id", :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "insurance_companies", :force => true do |t|
    t.string   "company_name"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.integer  "lock_version",                               :default => 0
    t.integer  "certification_period",                       :default => 0
    t.boolean  "co_pay_applicable"
    t.string   "company_code"
    t.integer  "org_id"
    t.string   "claim_street_address",       :limit => 1000
    t.string   "claim_suite_number",         :limit => 10
    t.string   "claim_zip_code",             :limit => 10
    t.string   "claim_city",                 :limit => 50
    t.string   "claim_state",                :limit => 2
    t.string   "claim_phone_number",         :limit => 15
    t.string   "authorization_phone_number", :limit => 15
    t.integer  "claim_submission_due_days"
    t.boolean  "draft_status",                               :default => false
    t.integer  "claim_payment_due_days",                     :default => 0
    t.string   "claim_form_type",            :limit => 2
    t.string   "billing_flow",               :limit => 5
    t.string   "payer_id",                   :limit => 25
  end

  create_table "insurance_company_visit_type_rates", :force => true do |t|
    t.integer  "org_id",                                                                              :null => false
    t.integer  "insurance_company_id",                                                                :null => false
    t.integer  "visit_type_id",                                                                       :null => false
    t.decimal  "visit_rate",                             :precision => 8, :scale => 2
    t.string   "external_visit_type_code", :limit => 20
    t.integer  "lock_version",                                                         :default => 0
    t.string   "hcpcs_code"
    t.string   "revenue_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "hourly_rate",                            :precision => 8, :scale => 2
  end

  add_index "insurance_company_visit_type_rates", ["org_id", "insurance_company_id", "visit_type_id"], :name => "indexes_for_insurance_company_visit_type_rates", :unique => true

  create_table "invoice_packages", :force => true do |t|
    t.integer  "invoice_id"
    t.integer  "insurance_company_id"
    t.string   "package_number"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "org_id"
  end

  create_table "invoice_payments", :force => true do |t|
    t.integer  "invoice_id",                                                          :null => false
    t.integer  "org_id",                                                              :null => false
    t.date     "payment_date",                                                        :null => false
    t.string   "payer_type",                                                          :null => false
    t.integer  "payer_id",                                                            :null => false
    t.decimal  "payment_amount",                        :precision => 8, :scale => 2, :null => false
    t.string   "payment_status",           :limit => 1,                               :null => false
    t.text     "payment_description"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "payment_reference_number",                                            :null => false
  end

  create_table "invoices", :force => true do |t|
    t.integer  "invoice_number",                                                  :null => false
    t.date     "invoice_date",                                                    :null => false
    t.integer  "org_id",                                                          :null => false
    t.string   "payer_type",                                                      :null => false
    t.integer  "payer_id",                                                        :null => false
    t.decimal  "invoice_amount",                    :precision => 8, :scale => 2, :null => false
    t.string   "invoice_status",       :limit => 1,                               :null => false
    t.text     "invoice_description"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.string   "invoice_type",         :limit => 5,                               :null => false
    t.integer  "treatment_id",                                                    :null => false
    t.integer  "treatment_episode_id",                                            :null => false
    t.date     "sent_date"
    t.string   "transmission_status"
    t.datetime "next_check_time"
    t.integer  "retry_count"
    t.text     "transmission_note"
    t.string   "claim_control_number"
    t.text     "additional_fields"
    t.date     "status_date"
  end

  create_table "languages", :force => true do |t|
    t.string   "language_code",        :limit => 2,                 :null => false
    t.string   "language_description", :limit => 50,                :null => false
    t.integer  "lock_version",                       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "license_types", :force => true do |t|
    t.integer  "discipline_id",                                         :null => false
    t.string   "license_type_code",        :limit => 5,                 :null => false
    t.string   "license_type_description", :limit => 50,                :null => false
    t.boolean  "independent_flag"
    t.integer  "lock_version",                           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "license_types_visit_types", :force => true do |t|
    t.integer  "license_type_id",                :null => false
    t.integer  "visit_type_id",                  :null => false
    t.integer  "lock_version",    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_equipments", :force => true do |t|
    t.string   "equipment_name", :limit => 50,                :null => false
    t.integer  "lock_version",                 :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_order_attached_docs", :force => true do |t|
    t.integer  "medical_order_id", :null => false
    t.integer  "document_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_orders", :force => true do |t|
    t.date     "order_date",                                                   :null => false
    t.text     "order_content"
    t.integer  "treatment_id",                                                 :null => false
    t.integer  "order_type_id",                                                :null => false
    t.integer  "treatment_episode_id",                                         :null => false
    t.integer  "physician_id",                                                 :null => false
    t.integer  "created_user_id",                                              :null => false
    t.integer  "signed_user_id"
    t.string   "order_status",                 :limit => 2,                    :null => false
    t.integer  "lock_version",                               :default => 0
    t.string   "printable_order_file_name"
    t.string   "printable_order_content_type"
    t.integer  "printable_order_file_size"
    t.datetime "printable_order_updated_at"
    t.string   "signed_order_file_name"
    t.string   "signed_order_content_type"
    t.integer  "signed_order_file_size"
    t.datetime "signed_order_updated_at"
    t.string   "order_reference",              :limit => 20,                   :null => false
    t.integer  "attachment_type_id"
    t.integer  "field_staff_id"
    t.date     "os_sign_date"
    t.integer  "treatment_visit_id"
    t.boolean  "mo_editable",                                :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medicare_areas_wage_indices", :force => true do |t|
    t.integer  "cbsa_code_id",  :null => false
    t.decimal  "wage_index"
    t.integer  "calender_year", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "medicare_claim_transmission_logs", :force => true do |t|
    t.string   "claim_edi_file_name"
    t.string   "claim_edi_content_type"
    t.integer  "claim_edi_file_size"
    t.datetime "claim_edi_updated_at"
    t.string   "transmission_status"
    t.integer  "invoice_id"
    t.integer  "claim_start_line_number"
    t.integer  "claim_end_line_number"
    t.string   "type_of_response"
    t.datetime "transmission_time"
    t.string   "type_of_file"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "response_file_name"
    t.string   "uuid"
  end

  create_table "medicare_core_stat_areas", :force => true do |t|
    t.string   "cbsa_code"
    t.string   "county_code"
    t.string   "county_name"
    t.string   "state_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calender_year"
    t.string   "area_type"
  end

  create_table "medicare_labor_percentages", :force => true do |t|
    t.integer  "calender_year",    :null => false
    t.decimal  "labor_percentage", :null => false
    t.integer  "lock_version"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "medicare_lupa_rates", :force => true do |t|
    t.integer  "calender_year",   :null => false
    t.string   "discipline_code", :null => false
    t.decimal  "base_amt",        :null => false
    t.integer  "lock_version"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "medicare_nrs_rates", :force => true do |t|
    t.integer  "calender_year", :null => false
    t.string   "nrs_score",     :null => false
    t.decimal  "nrs_amt",       :null => false
    t.integer  "lock_version"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "medicare_remittance_adjustments", :force => true do |t|
    t.string   "group_code"
    t.string   "reason_code"
    t.string   "reason_description"
    t.decimal  "amount"
    t.integer  "adjustment_id",      :null => false
    t.string   "adjustment_type",    :null => false
    t.string   "adjusted_quantity"
    t.integer  "lock_version"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "medicare_remittance_claim_line_items", :force => true do |t|
    t.integer  "medicare_remittance_claim_id", :null => false
    t.string   "internal_control_number"
    t.decimal  "line_item_billed_amount"
    t.decimal  "line_item_paid_amount"
    t.decimal  "line_item_coinsurance_amount"
    t.decimal  "line_item_deductible_amount"
    t.decimal  "line_item_allowed_amount"
    t.decimal  "line_item_adjustment_amount"
    t.string   "paid_no_of_services"
    t.string   "submitted_no_of_services"
    t.string   "procedure_codes"
    t.string   "submitted_procedure_codes"
    t.string   "procedure_code_modifiers"
    t.date     "service_from_date"
    t.date     "service_to_date"
    t.integer  "lock_version"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "receivable_id"
  end

  create_table "medicare_remittance_claims", :force => true do |t|
    t.integer  "invoice_id",                           :null => false
    t.integer  "medicare_remittance_id",               :null => false
    t.string   "account_number"
    t.string   "internal_control_number"
    t.decimal  "claim_billed_amount"
    t.decimal  "claim_adjusted_amount"
    t.decimal  "claim_allowed_amount"
    t.decimal  "claim_co_ins_amount"
    t.decimal  "claim_deductible_amount"
    t.decimal  "provider_paid_amount"
    t.string   "claim_assignment",        :limit => 1
    t.date     "service_from_date"
    t.date     "service_to_date"
    t.string   "patient_name"
    t.decimal  "claim_interest_amount"
    t.decimal  "late_filling_charge"
    t.integer  "lock_version"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "medicare_remittance_provider_adjustments", :force => true do |t|
    t.integer  "medicare_remittance_id",   :null => false
    t.string   "reason_code"
    t.string   "financial_control_number"
    t.decimal  "amount"
    t.integer  "lock_version"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "medicare_remittances", :force => true do |t|
    t.string   "medicare_remittance_file_name"
    t.string   "medicare_remittance_content_type"
    t.integer  "medicare_remittance_file_size"
    t.datetime "medicare_remittance_updated_at"
    t.date     "check_eft_date"
    t.decimal  "check_eft_amount"
    t.string   "check_eft_type"
    t.string   "check_eft_number"
    t.string   "total_no_of_claims"
    t.decimal  "total_billed_amount"
    t.decimal  "total_adjusted_amount"
    t.decimal  "total_allowed_amount"
    t.decimal  "total_co_ins_amount"
    t.decimal  "total_deductible_amount"
    t.decimal  "total_paid_amount"
    t.decimal  "total_interest_amount"
    t.integer  "lock_version"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "org_id"
  end

  create_table "medicare_standard_rates", :force => true do |t|
    t.integer  "calender_year",    :null => false
    t.decimal  "base_amt",         :null => false
    t.decimal  "rural_percentage", :null => false
    t.integer  "lock_version"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "medication_libraries", :force => true do |t|
    t.string   "drug_name"
    t.string   "dosage"
    t.string   "dosage_form"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medications", :force => true do |t|
    t.string   "drug_name",          :limit => 100,                :null => false
    t.string   "dosage",             :limit => 100,                :null => false
    t.string   "active_ingredients", :limit => 200,                :null => false
    t.string   "status",             :limit => 1,                  :null => false
    t.string   "ndu_code",           :limit => 15,                 :null => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "lock_version",                      :default => 0
  end

  create_table "netzke_component_states", :force => true do |t|
    t.string   "component"
    t.integer  "user_id"
    t.integer  "role_id"
    t.text     "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "netzke_component_states", ["component"], :name => "index_netzke_component_states_on_component"
  add_index "netzke_component_states", ["role_id"], :name => "index_netzke_component_states_on_role_id"
  add_index "netzke_component_states", ["user_id"], :name => "index_netzke_component_states_on_user_id"

  create_table "npi_registry_physicians", :force => true do |t|
    t.string  "npi_number"
    t.string  "last_name"
    t.string  "first_name"
    t.string  "middle_name"
    t.string  "suffix"
    t.string  "prefix"
    t.string  "credential_text"
    t.string  "address_line1"
    t.string  "address_line2"
    t.string  "city"
    t.string  "state"
    t.string  "zip_code"
    t.string  "country_code"
    t.string  "phone_number"
    t.string  "fax_number"
    t.date    "deactivation_date"
    t.date    "reactivation_date"
    t.string  "deactivation_reason_code"
    t.string  "gender"
    t.string  "taxanomy_code"
    t.string  "license_number"
    t.string  "license_number_state"
    t.boolean "pecos_verification",       :default => false
  end

  add_index "npi_registry_physicians", ["npi_number"], :name => "index_physicians_on_npi_number"

  create_table "oasis_export_batches", :force => true do |t|
    t.integer  "oasis_export_id",      :null => false
    t.integer  "export_batch_file_id", :null => false
    t.integer  "lock_version"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "oasis_exports", :force => true do |t|
    t.integer  "document_id",                                        :null => false
    t.string   "export_status",        :limit => 1, :default => "R", :null => false
    t.datetime "exported_date_time"
    t.integer  "exported_user_id"
    t.string   "export_reference"
    t.string   "record_type"
    t.integer  "correction_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "insurance_company_id"
  end

  create_table "oasis_field_specs", :force => true do |t|
    t.integer  "field_sequence"
    t.string   "field_name",                      :limit => 100, :null => false
    t.integer  "length"
    t.integer  "start_position"
    t.integer  "end_position"
    t.boolean  "rfa_1"
    t.boolean  "rfa_2"
    t.boolean  "rfa_3"
    t.boolean  "rfa_4"
    t.boolean  "rfa_5"
    t.boolean  "rfa_6"
    t.boolean  "rfa_7"
    t.boolean  "rfa_8"
    t.boolean  "rfa_9"
    t.boolean  "rfa_10"
    t.string   "record_type",                     :limit => 1
    t.string   "default_value"
    t.string   "data_type",                       :limit => 20
    t.string   "field_description"
    t.text     "consistency"
    t.text     "applicable_condition_expression"
    t.string   "display_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oasis_spec_version"
  end

  create_table "order_types", :force => true do |t|
    t.string   "type_description", :limit => 50,                   :null => false
    t.integer  "lock_version",                   :default => 0
    t.string   "type_code",                                        :null => false
    t.integer  "org_id"
    t.boolean  "system_required",                :default => true, :null => false
    t.string   "type_status",      :limit => 1,                    :null => false
    t.date     "disabled_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "org_contacts", :force => true do |t|
    t.string   "contact_first_name", :limit => 100,                :null => false
    t.string   "contact_last_name",  :limit => 100,                :null => false
    t.string   "phone_number",       :limit => 15,                 :null => false
    t.string   "extension",          :limit => 10
    t.string   "email",              :limit => 100,                :null => false
    t.integer  "org_id",                                           :null => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "contact_type_id",                                  :null => false
    t.integer  "lock_version",                      :default => 0
  end

  create_table "org_field_staff_visit_types", :force => true do |t|
    t.integer  "org_user_id",                                 :null => false
    t.integer  "visit_type_id",                               :null => false
    t.decimal  "visit_rate",    :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "hourly_rate",   :precision => 8, :scale => 2
  end

  create_table "org_physicians", :force => true do |t|
    t.integer  "org_id",                                :null => false
    t.integer  "physician_id",                          :null => false
    t.string   "personal_phone_number_1"
    t.string   "personal_phone_number_2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "fax_number",              :limit => 15
    t.string   "suite_number",            :limit => 15
    t.string   "street_address",          :limit => 50
    t.string   "city",                    :limit => 50
    t.string   "state",                   :limit => 2
    t.string   "zip_code",                :limit => 10
    t.string   "phone_number",            :limit => 15
    t.string   "suffix",                  :limit => 10
  end

  create_table "org_users", :force => true do |t|
    t.integer  "org_id",                                   :null => false
    t.integer  "user_id",                                  :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "lock_version",              :default => 0
    t.string   "user_status",  :limit => 1,                :null => false
    t.string   "verify_token", :limit => 6
    t.string   "role_type",    :limit => 1
  end

  create_table "orgs", :force => true do |t|
    t.string   "org_name",             :limit => 100
    t.string   "org_type",             :limit => 50,                     :null => false
    t.string   "org_package",          :limit => 2,                      :null => false
    t.string   "week_start_day",       :limit => 3,                      :null => false
    t.string   "suite_number",         :limit => 15
    t.string   "street_address",       :limit => 50
    t.string   "city",                 :limit => 50
    t.string   "state",                :limit => 2
    t.string   "zip_code",             :limit => 10
    t.string   "email",                :limit => 100
    t.string   "preferred_alert_mode", :limit => 1,                      :null => false
    t.text     "notes"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.string   "phone_number",         :limit => 15
    t.string   "fax_number",           :limit => 15
    t.integer  "lock_version",                        :default => 0
    t.string   "fed_tax_number",       :limit => 100
    t.string   "branch_id",            :limit => 10
    t.boolean  "draft_status",                        :default => false
    t.string   "npi_number"
    t.boolean  "active",                              :default => true
    t.string   "zip_code_part2",       :limit => 4
    t.string   "building_name",        :limit => 40
  end

  create_table "patient_caregivers", :force => true do |t|
    t.integer  "patient_id",                                       :null => false
    t.integer  "caregiver_id",                                     :null => false
    t.string   "relation_to_patient", :limit => 50,                :null => false
    t.boolean  "primary_flag",                                     :null => false
    t.integer  "lock_version",                      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_details", :force => true do |t|
    t.string   "medicare_number",    :limit => 50
    t.integer  "height"
    t.string   "height_unit",        :limit => 1
    t.integer  "weight"
    t.string   "weight_unit",        :limit => 1
    t.date     "dob"
    t.string   "ssn"
    t.string   "marital_status",     :limit => 1
    t.string   "gender",             :limit => 1,                   :null => false
    t.integer  "patient_id",                                        :null => false
    t.integer  "org_id"
    t.integer  "lock_version",                     :default => 0
    t.string   "patient_reference",                                 :null => false
    t.string   "dnr",                :limit => 1,  :default => "3", :null => false
    t.string   "dni",                :limit => 1,  :default => "3", :null => false
    t.string   "acuity_level",       :limit => 1,  :default => "4", :null => false
    t.string   "advanced_directive", :limit => 1,  :default => "3", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_insurance_companies", :force => true do |t|
    t.integer  "patient_id",                                  :null => false
    t.integer  "insurance_company_id"
    t.integer  "lock_version",                                :null => false
    t.string   "patient_insurance_number"
    t.date     "effective_date"
    t.date     "termination_date"
    t.text     "coverage_details"
    t.boolean  "primary_insurance_flag",   :default => false
    t.string   "relation_to_insured"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_treatments", :force => true do |t|
    t.integer  "treatment_request_id"
    t.string   "treatment_status",       :limit => 1, :default => "N", :null => false
    t.integer  "agency_contact_user_id"
    t.date     "treatment_start_date"
    t.date     "treatment_end_date"
    t.integer  "patient_id",                                           :null => false
    t.integer  "lock_version",                        :default => 0
    t.string   "treatment_reference",                                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payables", :force => true do |t|
    t.date     "visit_date",                                                   :null => false
    t.string   "payable_type",    :limit => 2,                                 :null => false
    t.string   "source_type",     :limit => 50
    t.integer  "source_id"
    t.string   "payable_status",  :limit => 2,                                 :null => false
    t.integer  "org_id",                                                       :null => false
    t.string   "payee_type",      :limit => 50,                                :null => false
    t.integer  "payee_id",                                                     :null => false
    t.decimal  "payable_amount",                 :precision => 8, :scale => 2, :null => false
    t.integer  "payroll_id"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.string   "purpose",         :limit => 100
    t.date     "submission_date"
    t.integer  "treatment_id",                                                 :null => false
    t.integer  "field_staff_id"
    t.decimal  "adjusted_rate",                  :precision => 8, :scale => 2, :null => false
    t.string   "unit",            :limit => 2
    t.decimal  "rate",                           :precision => 8, :scale => 2
    t.decimal  "no_of_units",                    :precision => 8, :scale => 2
  end

  add_index "payables", ["org_id"], :name => "index_payables_on_org_id"

  create_table "payment_sources", :id => false, :force => true do |t|
    t.string   "id",          :limit => 2,   :null => false
    t.string   "description", :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payrolls", :force => true do |t|
    t.date     "payroll_date",                                                  :null => false
    t.integer  "org_id",                                                        :null => false
    t.string   "payee_type",        :limit => 50,                               :null => false
    t.integer  "payee_id",                                                      :null => false
    t.decimal  "payroll_amount",                  :precision => 8, :scale => 2, :null => false
    t.date     "paid_date"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.string   "payroll_reference", :limit => 20,                               :null => false
    t.integer  "office_staff_id",                                               :null => false
  end

  create_table "phone_numbers", :force => true do |t|
    t.string   "phone_type",     :limit => 1,                     :null => false
    t.string   "phone_number",   :limit => 15,                    :null => false
    t.string   "extension",      :limit => 10
    t.boolean  "default_number",               :default => false, :null => false
    t.integer  "org_id",                                          :null => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "lock_version",                 :default => 0
  end

  create_table "physician_details", :force => true do |t|
    t.string   "npi_number",   :limit => 15,                :null => false
    t.integer  "physician_id"
    t.integer  "lock_version",               :default => 0
    t.string   "fax_number",   :limit => 15
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receivables", :force => true do |t|
    t.string   "payer_type",                                                        :null => false
    t.integer  "payer_id",                                                          :null => false
    t.integer  "org_id",                                                            :null => false
    t.integer  "invoice_id"
    t.integer  "invoice_payment_id"
    t.string   "receivable_status",    :limit => 1,                                 :null => false
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "purpose",              :limit => 100
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.date     "receivable_date",                                                   :null => false
    t.decimal  "receivable_amount",                   :precision => 8, :scale => 2, :null => false
    t.string   "receivable_type",      :limit => 1,                                 :null => false
    t.integer  "treatment_id"
    t.string   "hcpcs_code"
    t.string   "revenue_code"
    t.integer  "treatment_episode_id"
    t.integer  "service_units",                                                     :null => false
    t.date     "due_date"
    t.decimal  "received_amount",                     :precision => 8, :scale => 2
    t.string   "reference_number",     :limit => 75
    t.decimal  "visit_type_rate",                     :precision => 8, :scale => 2
    t.date     "payment_due_date"
    t.integer  "invoice_package_id"
  end

  create_table "reference_numbers", :force => true do |t|
    t.integer  "org_id",                        :null => false
    t.date     "reference_date",                :null => false
    t.integer  "sequence",       :default => 0, :null => false
    t.string   "reference_type",                :null => false
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scheduled_visits", :force => true do |t|
    t.date     "scheduled_date",                    :null => false
    t.string   "start_time",           :limit => 4
    t.string   "end_time",             :limit => 4
    t.integer  "visit_type_id",                     :null => false
    t.integer  "field_staff_id",                    :null => false
    t.integer  "visit_id"
    t.integer  "treatment_episode_id",              :null => false
    t.integer  "treatment_id",                      :null => false
    t.integer  "lock_version"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.date     "scheduled_end_date"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id",                  :null => false
    t.integer  "lock_version", :default => 0, :null => false
    t.text     "data"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "staffing_company_credential_types", :force => true do |t|
    t.string   "ct_code",        :limit => 15,                 :null => false
    t.string   "ct_description", :limit => 100,                :null => false
    t.boolean  "expiry_flag",                                  :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "lock_version",                  :default => 0
  end

  create_table "staffing_company_details", :force => true do |t|
    t.integer  "staffing_company_id",                :null => false
    t.integer  "created_org_id",                     :null => false
    t.integer  "lock_version",        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffing_masters", :force => true do |t|
    t.string   "staffable_type",    :limit => 100,                :null => false
    t.integer  "staffable_id",                                    :null => false
    t.datetime "created_date_time",                               :null => false
    t.string   "staffing_status",   :limit => 1,                  :null => false
    t.text     "narrative"
    t.integer  "lock_version",                     :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffing_request_visit_types", :force => true do |t|
    t.integer  "staffing_request_id",                               :null => false
    t.integer  "visit_type_id",                                     :null => false
    t.string   "request_status",      :limit => 1, :default => "N", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffing_requests", :force => true do |t|
    t.string   "staff_type",               :limit => 100,                :null => false
    t.integer  "staff_id",                                               :null => false
    t.datetime "requested_date_time",                                    :null => false
    t.string   "request_status",           :limit => 1,                  :null => false
    t.integer  "lock_version",                            :default => 0
    t.integer  "staffing_requirement_id",                                :null => false
    t.integer  "discipline_id"
    t.integer  "visit_type_id"
    t.string   "apply_patient_preference", :limit => 1
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffing_requirements", :force => true do |t|
    t.integer  "staffing_master_id",                             :null => false
    t.integer  "discipline_id"
    t.integer  "visit_type_id"
    t.string   "staffing_status",    :limit => 1,                :null => false
    t.integer  "lock_version",                    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string   "state_code",        :limit => 2,                 :null => false
    t.string   "state_description", :limit => 50,                :null => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.integer  "lock_version",                    :default => 0
  end

  create_table "supplies", :force => true do |t|
    t.string   "supply_hcpcs_code",  :limit => 10,                                 :null => false
    t.string   "supply_description", :limit => 4000,                               :null => false
    t.integer  "supply_quantity"
    t.decimal  "supply_price",                       :precision => 8, :scale => 2
    t.integer  "org_id",                                                           :null => false
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  create_table "treat_req_disciplines", :force => true do |t|
    t.integer  "request_id",                   :null => false
    t.integer  "discipline_id",                :null => false
    t.integer  "lock_version",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treat_req_med_equipments", :force => true do |t|
    t.integer  "request_id",           :null => false
    t.integer  "medical_equipment_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treat_req_visit_types", :force => true do |t|
    t.integer  "request_id",                   :null => false
    t.integer  "visit_type_id",                :null => false
    t.integer  "lock_version",  :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treat_staffing_companies", :force => true do |t|
    t.integer  "treatment_id",                       :null => false
    t.integer  "staffing_company_id",                :null => false
    t.integer  "lock_version",        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_activities", :force => true do |t|
    t.integer  "treatment_id",                      :null => false
    t.integer  "discipline_id"
    t.date     "activity_date",                     :null => false
    t.integer  "created_user_id",                   :null => false
    t.string   "activity_reason_code"
    t.text     "activity_details"
    t.integer  "lock_version"
    t.string   "activity_type",        :limit => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_attachments", :force => true do |t|
    t.integer  "treatment_id",                           :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "attachment_name",         :limit => 100
    t.datetime "created_at"
    t.integer  "attachment_type_id",                     :null => false
    t.integer  "treatment_episode_id",                   :null => false
    t.date     "attachment_date"
    t.datetime "updated_at"
  end

  create_table "treatment_disciplines", :force => true do |t|
    t.integer  "treatment_id",                                       :null => false
    t.integer  "discipline_id",                                      :null => false
    t.string   "treatment_status",     :limit => 1, :default => "N", :null => false
    t.integer  "lock_version",                      :default => 0
    t.integer  "treatment_episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_episodes", :force => true do |t|
    t.integer  "treatment_id",                                        :null => false
    t.date     "start_date",                                          :null => false
    t.date     "end_date",                                            :null => false
    t.integer  "lock_version",                         :default => 0
    t.string   "initial_hipps_code"
    t.string   "treatment_authorization"
    t.string   "medicare_bill_status",    :limit => 1,                :null => false
    t.string   "final_hipps_code"
    t.string   "hipps_version"
    t.string   "episode_type",            :limit => 5
    t.string   "episode_status",          :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rap_generated_document"
  end

  add_index "treatment_episodes", ["treatment_id", "start_date", "end_date"], :name => "treatment_episode_dates", :unique => true

  create_table "treatment_field_staffs", :force => true do |t|
    t.integer  "treatment_id",                  :null => false
    t.integer  "field_staff_id",                :null => false
    t.integer  "lock_version",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_medications", :force => true do |t|
    t.integer  "treatment_id",                        :null => false
    t.integer  "treatment_episode_id",                :null => false
    t.string   "medication_name",                     :null => false
    t.string   "medication_code",        :limit => 1
    t.string   "dosage"
    t.string   "frequency"
    t.string   "purpose"
    t.text     "potential_side_effects"
    t.date     "start_date",                          :null => false
    t.date     "discontinued_date"
    t.string   "medication_status",      :limit => 1, :null => false
    t.date     "end_date"
    t.integer  "visit_id"
    t.date     "assessment_date",                     :null => false
    t.string   "dosage_form"
    t.integer  "created_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_physicians", :force => true do |t|
    t.integer  "treatment_id",                         :null => false
    t.integer  "physician_id",                         :null => false
    t.boolean  "primary_referral_flag"
    t.boolean  "require_cc_flag"
    t.integer  "lock_version",          :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_request_attachments", :force => true do |t|
    t.integer  "request_id",                             :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "attachment_name",         :limit => 100
    t.datetime "created_at"
    t.integer  "attachment_type_id",                     :null => false
    t.date     "attachment_date"
    t.datetime "updated_at"
  end

  create_table "treatment_request_payment_sources", :force => true do |t|
    t.integer  "request_id",                       :null => false
    t.string   "payment_source_id",                :null => false
    t.integer  "lock_version",      :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_request_staffs", :force => true do |t|
    t.integer  "request_id",                                             :null => false
    t.string   "staff_type",               :limit => 100
    t.integer  "staff_id"
    t.integer  "discipline_id"
    t.integer  "visit_type_id"
    t.integer  "lock_version",                            :default => 0, :null => false
    t.string   "apply_patient_preference", :limit => 1
    t.integer  "staffing_requirement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_requests", :force => true do |t|
    t.integer  "patient_id",                                                      :null => false
    t.date     "request_date",                                                    :null => false
    t.string   "request_status",                  :limit => 1, :default => "N",   :null => false
    t.integer  "health_agency_id",                                                :null => false
    t.integer  "created_user_id",                                                 :null => false
    t.boolean  "lang_mandatory_flag"
    t.text     "special_instructions"
    t.boolean  "si_mandatory_flag"
    t.text     "reason_for_therapy"
    t.text     "restrictions"
    t.integer  "agency_contact_user_id"
    t.integer  "approved_agency_user_id"
    t.datetime "approved_date_time"
    t.integer  "referred_physician_id"
    t.integer  "lock_version",                                 :default => 0
    t.boolean  "broadcast_staffing_request_flag",              :default => false
    t.boolean  "referral_received_flag",                       :default => false
    t.string   "preferred_gender",                :limit => 1
    t.date     "referral_received_date"
    t.boolean  "eligibility_check_flag",                       :default => false
    t.integer  "insurance_company_id"
    t.integer  "certification_period"
    t.string   "point_of_origin",                 :limit => 2,                    :null => false
    t.integer  "insurance_case_manager_id"
    t.string   "transfer_from_hha",               :limit => 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "insurance_bill_type",             :limit => 2, :default => "V"
    t.string   "field_staff_bill_type",           :limit => 2, :default => "V"
  end

  create_table "treatment_staffs", :force => true do |t|
    t.integer  "treatment_id",                                                                             :null => false
    t.string   "staff_type",               :limit => 100
    t.integer  "staff_id"
    t.integer  "discipline_id"
    t.integer  "visit_type_id"
    t.integer  "lock_version",                                                          :default => 0,     :null => false
    t.string   "apply_patient_preference", :limit => 1
    t.integer  "staffing_requirement_id"
    t.decimal  "co_pay_amt",                              :precision => 8, :scale => 2
    t.boolean  "system_assigned",                                                       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_visit_types", :force => true do |t|
    t.integer  "treatment_id",                 :null => false
    t.integer  "visit_type_id",                :null => false
    t.integer  "lock_version",  :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_visits", :force => true do |t|
    t.integer  "discipline_id"
    t.integer  "treatment_episode_id",                                        :null => false
    t.integer  "visited_user_id"
    t.datetime "visit_start_time",                                            :null => false
    t.datetime "visit_end_time",                                              :null => false
    t.integer  "visit_type_id"
    t.string   "visit_status",              :limit => 1
    t.string   "frequency_string",          :limit => 100
    t.integer  "lock_version",                             :default => 0
    t.integer  "treatment_id",                                                :null => false
    t.integer  "supervised_user_id"
    t.string   "visited_staff_type"
    t.integer  "visited_staff_id"
    t.integer  "created_user_id"
    t.string   "visit_entry_type",          :limit => 1,   :default => "E",   :null => false
    t.boolean  "count_for_frequency_flag",                 :default => true
    t.boolean  "fs_sign_required"
    t.boolean  "supervisor_sign_required"
    t.boolean  "os_sign_required"
    t.integer  "agency_approved_user_id"
    t.date     "fs_sign_date"
    t.date     "supervised_user_sign_date"
    t.date     "os_sign_date"
    t.boolean  "draft_status",                             :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_vitals", :force => true do |t|
    t.integer  "systolic_bp"
    t.integer  "diastolic_bp"
    t.string   "bp_read_position",   :limit => 1
    t.integer  "heart_rate"
    t.integer  "respiration_rate"
    t.float    "temperature_in_fht"
    t.integer  "blood_sugar"
    t.string   "sugar_read_period",  :limit => 1
    t.integer  "weight_in_lbs"
    t.integer  "oxygen_saturation"
    t.integer  "treatment_id",                    :null => false
    t.integer  "visit_id"
    t.datetime "recorded_date_time"
    t.integer  "recorded_user_id",                :null => false
    t.string   "bp_read_location",   :limit => 1
    t.text     "remarks"
    t.integer  "pain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_ethnicities", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.string   "ethnicity_id",                :null => false
    t.integer  "lock_version", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_languages", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.integer  "language_id",                 :null => false
    t.integer  "lock_version", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",                    :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "suite_number",            :limit => 15
    t.string   "street_address",          :limit => 50
    t.string   "city",                    :limit => 50
    t.string   "state",                   :limit => 2
    t.string   "zip_code",                :limit => 10
    t.string   "phone_number",            :limit => 15
    t.string   "user_type",               :limit => 50
    t.integer  "lock_version",                          :default => 0
    t.boolean  "approved",                              :default => false, :null => false
    t.string   "gender"
    t.string   "signature_file_name"
    t.string   "signature_content_type"
    t.integer  "signature_file_size"
    t.datetime "signature_updated_at"
    t.string   "middle_initials",         :limit => 2
    t.string   "suffix",                  :limit => 10
    t.string   "ethnicity",               :limit => 20
    t.string   "encrypted_sign_password"
    t.string   "phone_number_2",          :limit => 15
    t.string   "fax_number",              :limit => 15
    t.boolean  "draft_status",                          :default => false
    t.string   "npi_number",              :limit => 15
    t.boolean  "pecos_verification",                    :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "visit_attachments", :force => true do |t|
    t.integer  "visit_id",                               :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "attachment_name",         :limit => 100
    t.datetime "created_at"
    t.integer  "attachment_type_id",                     :null => false
    t.integer  "document_definition_id"
    t.date     "attachment_date"
    t.datetime "updated_at"
  end

  create_table "visit_frequencies", :force => true do |t|
    t.integer  "discipline_id",                                         :null => false
    t.integer  "treatment_episode_id",                                  :null => false
    t.integer  "medical_order_id",                                      :null => false
    t.string   "frequency_string",     :limit => 10,                    :null => false
    t.integer  "unit_count",                                            :null => false
    t.string   "frequency_unit",       :limit => 1,                     :null => false
    t.integer  "visits_per_unit",                                       :null => false
    t.string   "frequency_status",                                      :null => false
    t.integer  "lock_version",                       :default => 0
    t.integer  "treatment_id",                                          :null => false
    t.date     "frequency_start_date",                                  :null => false
    t.date     "frequency_end_date",                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visits_count",                       :default => 0
    t.boolean  "cancelled",                          :default => false
  end

  create_table "visit_frequency_details", :force => true do |t|
    t.integer  "frequency_id",                                    :null => false
    t.integer  "visit_id"
    t.string   "detail_status",      :limit => 1,                 :null => false
    t.integer  "detail_sequence"
    t.string   "detail_description", :limit => 20
    t.integer  "lock_version",                     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visit_frequency_field_staffs", :force => true do |t|
    t.integer  "frequency_id",                  :null => false
    t.integer  "field_staff_id",                :null => false
    t.integer  "lock_version",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visit_type_document_defns", :force => true do |t|
    t.boolean  "mandatory_flag",         :default => false
    t.integer  "visit_type_id",                             :null => false
    t.integer  "document_definition_id",                    :null => false
    t.integer  "lock_version",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visit_type_state_transitions", :force => true do |t|
    t.integer  "visit_type_id",              :null => false
    t.string   "from_state",    :limit => 1, :null => false
    t.string   "to_state",      :limit => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visit_types", :force => true do |t|
    t.string   "visit_type_code",        :limit => 20,                                                  :null => false
    t.string   "visit_type_description", :limit => 50,                                                  :null => false
    t.integer  "org_id",                                                                                :null => false
    t.decimal  "payable_rate",                         :precision => 8, :scale => 2
    t.integer  "lock_version",                                                       :default => 0
    t.integer  "discipline_id"
    t.boolean  "optional_flag",                                                      :default => false
    t.integer  "sort_order",                                                                            :null => false
    t.string   "visit_type_status",      :limit => 1,                                                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vitals_reference_ranges", :force => true do |t|
    t.integer  "org_id",                :null => false
    t.string   "vital_sign",            :null => false
    t.float    "minimum_value"
    t.float    "maximum_value"
    t.datetime "last_updated_datetime", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_queue", :force => true do |t|
    t.string   "workable_type",       :limit => 50,                :null => false
    t.integer  "workable_id",                                      :null => false
    t.integer  "assigned_by_user_id"
    t.integer  "assigned_to_user_id"
    t.datetime "created_date_time"
    t.datetime "due_date_time"
    t.datetime "completed_date_time"
    t.string   "work_status",         :limit => 2,                 :null => false
    t.string   "work_scopeable_type", :limit => 50
    t.integer  "work_scopeable_id"
    t.text     "comments"
    t.integer  "org_id",                                           :null => false
    t.string   "work_type",           :limit => 20,                :null => false
    t.integer  "lock_version",                      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zip_codes", :force => true do |t|
    t.string   "locality",     :limit => 50,                                               :null => false
    t.string   "zip_code",     :limit => 10,                                               :null => false
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
    t.integer  "lock_version",                                              :default => 0
    t.string   "admin_name_1"
    t.string   "admin_code_1"
    t.string   "admin_name_2"
    t.string   "admin_code_2"
    t.decimal  "lat",                        :precision => 10, :scale => 6
    t.decimal  "lng",                        :precision => 10, :scale => 6
  end

end
