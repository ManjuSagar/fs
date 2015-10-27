class DenormalizedPatientList < ActiveRecord::Base
  include FlattenRecord::Flattener

  scope :org_scope, lambda{where(org_id: Org.current.id)}
  scope :denormalize_filter, lambda {|treatment_status_arr| org_scope.where(["(patient_treatment_record_type = ?
               and patient_treatment_treatment_status_display in
                (?)) or (patient_record_type = ? and patient_status in
                (?)) or (treatment_request_record_type = ? and treatment_request_status in
                (?))", 1, treatment_status_arr, 2,  treatment_status_arr, 3, treatment_status_arr]).order(:patient_treatment_record_type, :patient_record_type, :treatment_request_record_type, :last_name, :first_name)}

  denormalize :patient,{
      include: {
          treatment_requests: {
              prefix: 'treatment_request_',
              only: [:id],
              methods: {
                  events: :string,
                  staffing_flag: :string,
                  ref_received_flag: :string,
                  eligibility_flag: :string,
                  disciplines_display: :string,
                  oasis_flag: :string,
                  poc_flag: :string,
                  dc_flag: :string,
                  fc_flag: :string,
                  rap_flag: :string,
                  doc_flag: :string,
                  mo_flag: :string,
                  status: :string,
                  record_type: :integer
              },

          include: {
              patient_treatment: {
                  include: {
                      treatment_episodes: {
                          prefix: 'e_',
                          only: [:id, :episode_status, :start_date, :end_date],
                          methods: {
                              certification_period: :string,
                              staffing_flag: :string,
                              eligibility_check_flag: :string,
                              referral_received_flag: :string,
                              oasis_document_completed_flag: :string,
                              plan_of_care_completed_flag: :string,
                              discharged_flag: :string,
                              final_claim_sent_flag: :string,
                              disciplines_display: :string,
                              rap_status: :string,
                              documents_status: :string,
                              medical_orders_status: :string,
                              events: :string
                          }
                      },
                  },
                  prefix: "patient_treatment_",
                  only: [:id, :treatment_status],
                  methods: {
                      soc_date:  :string,
                      treatment_status_display: :string,
                      record_type: :integer
                  },
              },

          }
          },

      },
      only: [:id, :last_name, :first_name],
      methods: {
        patient_reference: :string,
        full_name: :string,
        org_id: :integer,
        p_eligibility_flag: :string,
        p_staffing_flag: :string,
        p_referral_flag: :string,
        p_oasis_flag: :string,
        p_poc_flag: :string,
        p_dc_flag: :string,
        p_fc_flag: :string,
        p_rap_flag: :string,
        p_doc_flag: :string,
        p_mo_flag: :string,
        patient_status: :string,
        patient_record_type: :integer
      },
  }

end