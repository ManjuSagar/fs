module OasisExtension
  include Wound
  include OasisPocField

  ICD10_PAYMENT_CODES = ["m1021_primary_diag_icd", "m1023_oth_diag1_icd",  "m1023_oth_diag2_icd", "m1023_oth_diag3_icd",
                         "m1023_oth_diag4_icd", "m1023_oth_diag5_icd"]

  ICD10_NON_PAYMENT_CODES = ["m1011_14_day_inp1_icd", "m1011_14_day_inp_na", "m1011_14_day_inp2_icd", "m1011_14_day_inp3_icd", "m1011_14_day_inp4_icd",
                   "m1011_14_day_inp5_icd", "m1011_14_day_inp6_icd", "m1017_chgreg_icd1", "m1017_chgreg_icd2", "m1017_chgreg_icd3",
                   "m1017_chgreg_icd4", "m1017_chgreg_icd5", "m1017_chgreg_icd6", "m1017_chgreg_icd_na",
                   "m1021_primary_diag_severity", "m1023_oth_diag1_severity", "m1023_oth_diag2_severity", "m1023_oth_diag3_severity",
                   "m1023_oth_diag4_severity", "m1023_oth_diag5_severity",
                   "m1025_opt_diag_icd_a3", "m1025_opt_diag_icd_a4", "m1025_opt_diag_icd_b3", "m1025_opt_diag_icd_b4", "m1025_opt_diag_icd_c3",
                   "m1025_opt_diag_icd_c4", "m1025_opt_diag_icd_d3", "m1025_opt_diag_icd_d4", "m1025_opt_diag_icd_e3",
                   "m1025_opt_diag_icd_e4", "m1025_opt_diag_icd_f3", "m1025_opt_diag_icd_f4"]

  ICD10_FIELDS = ICD10_PAYMENT_CODES + ICD10_NON_PAYMENT_CODES

  ICD9_PAYMENT_CODES = ["m1020_primary_diag_icd", "m1022_oth_diag1_icd", "m1022_oth_diag2_icd", "m1022_oth_diag3_icd",
                        "m1022_oth_diag4_icd", "m1022_oth_diag5_icd"]


  ICD9_NON_PAYMENT_CODES = ["m1010_14_day_inp1_icd", "m1010_14_day_inp2_icd", "m1010_14_day_inp3_icd", "m1010_14_day_inp4_icd",
                 "m1010_14_day_inp5_icd", "m1010_14_day_inp6_icd", "m1012_inp_na_icd", "m1012_inp_prcdr1_icd", "m1012_inp_prcdr2_icd",
                 "m1012_inp_prcdr3_icd", "m1012_inp_prcdr4_icd", "m1012_inp_uk_icd", "m1016_chgreg_icd1", "m1016_chgreg_icd2",
                 "m1016_chgreg_icd3", "m1016_chgreg_icd4", "m1016_chgreg_icd5", "m1016_chgreg_icd6", "m1016_chgreg_icd_na",
                 "m1020_primary_diag_severity", "m1022_oth_diag1_severity", "m1022_oth_diag2_severity", "m1022_oth_diag3_severity",
                 "m1022_oth_diag4_severity", "m1022_oth_diag5_severity", "m1024_pmt_diag_icd_a3", "m1024_pmt_diag_icd_a4",
                 "m1024_pmt_diag_icd_b3", "m1024_pmt_diag_icd_b4", "m1024_pmt_diag_icd_c3", "m1024_pmt_diag_icd_c4",
                 "m1024_pmt_diag_icd_d3", "m1024_pmt_diag_icd_d4", "m1024_pmt_diag_icd_e3", "m1024_pmt_diag_icd_e4",
                 "m1024_pmt_diag_icd_f3", "m1024_pmt_diag_icd_f4"]

  ICD9_FIELDS = ICD9_PAYMENT_CODES + ICD9_NON_PAYMENT_CODES

  ICD10_FIELDS_SET = ICD10_FIELDS + ["principal_icd10_1", "principal_icd10_2", "principal_icd10_3",
                      "principal_icd10_4", "principal_icd10_5", "principal_icd10_6", "pertinent_icd10_1", "pertinent_icd10_2", "pertinent_icd10_3", "pertinent_icd10_4",
                      "pertinent_icd10_5", "pertinent_icd10_6", "surgical_icd10_1","surgical_icd10_2","surgical_icd10_3","surgical_icd10_4"]

  def self.key_fields
    ["m0030_start_care_dt", "m0032_roc_dt", "m0032_roc_dt_na", "m0040_pat_fname", "m0040_pat_lname", "m0064_ssn", "m0064_ssn_uk", "m0066_pat_birth_dt",
     "m0069_pat_gender", "m0090_info_completed_dt", "m0100_assmt_reason", "m0906_dc_tran_dth_dt"]
  end

  def self.key_fields_original
    fields = key_fields
    fields.collect{|f| "#{f}_original" }
  end

  def self.oasis_fields
    ["patient_name",
     "mr",
     "physician_name",
     "treatment_episode_id",
     "field_staff_id",
     "supervised_user_id",
     "m0010_ccn",
     "m0014_branch_state",
     "m0016_branch_id",
     "m0018_physician_id",
     "m0018_physician_uk",
     "m0020_pat_id",
     "m0030_start_care_dt",
     "m0032_roc_dt",
     "m0032_roc_dt_na",
     "m0040_pat_fname",
     "m0040_pat_lname",
     "m0040_pat_mi",
     "m0040_pat_suffix",
     "m0050_pat_st",
     "m0060_pat_zip",
     "m0063_medicare_na",
     "m0063_medicare_num",
     "m0064_ssn",
     "m0064_ssn_uk",
     "m0065_medicaid_na",
     "m0065_medicaid_num",
     "m0066_pat_birth_dt",
     "m0069_pat_gender",
     "m0080_assessor_discipline",
     "m0090_info_completed_dt",
     "m0100_assmt_reason",
     "m0102_physn_ordrd_socroc_dt",
     "m0102_physn_ordrd_socroc_dt_na",
     "m0104_physn_rfrl_dt",
     "m0110_episode_timing",
     "m0140_ethnic_ai_an",
     "m0140_ethnic_asian",
     "m0140_ethnic_black",
     "m0140_ethnic_hisp",
     "m0140_ethnic_nh_pi",
     "m0140_ethnic_white",
     "m0150_cpay_mcaid_ffs",
     "m0150_cpay_mcaid_hmo",
     "m0150_cpay_mcare_ffs",
     "m0150_cpay_mcare_hmo",
     "m0150_cpay_none",
     "m0150_cpay_oth_govt",
     "m0150_cpay_other",
     "m0150_cpay_priv_hmo",
     "m0150_cpay_priv_ins",
     "m0150_cpay_selfpay",
     "m0150_cpay_titlepgms",
     "m0150_cpay_uk",
     "m0150_cpay_wrkcomp",
     "m0150_other_cpay",
     "m0903_last_home_visit",
     "m0906_dc_tran_dth_dt",
     "m1000_dc_ipps_14_da",
     "m1000_dc_irf_14_da",
     "m1000_dc_ltc_14_da",
     "m1000_dc_ltch_14_da",
     "m1000_dc_none_14_da",
     "m1000_dc_oth_14_da",
     "m1000_dc_psych_14_da",
     "m1000_dc_snf_14_da",
     "m1000_other_dc",
     "m1005_inp_discharge_dt",
     "m1005_inp_dschg_unknown",
     "m1010_14_day_inp1_icd",
     "m1010_14_day_inp2_icd",
     "m1010_14_day_inp3_icd",
     "m1010_14_day_inp4_icd",
     "m1010_14_day_inp5_icd",
     "m1010_14_day_inp6_icd",
     "m1012_inp_na_icd",
     "m1012_inp_prcdr1_icd",
     "m1012_inp_prcdr2_icd",
     "m1012_inp_prcdr3_icd",
     "m1012_inp_prcdr4_icd",
     "m1012_inp_uk_icd",
     "m1016_chgreg_icd1",
     "m1016_chgreg_icd2",
     "m1016_chgreg_icd3",
     "m1016_chgreg_icd4",
     "m1016_chgreg_icd5",
     "m1016_chgreg_icd6",
     "m1016_chgreg_icd_na",
     "m1018_prior_cath",
     "m1018_prior_disruptive",
     "m1018_prior_impr_decsn",
     "m1018_prior_intract_pain",
     "m1018_prior_mem_loss",
     "m1018_prior_nochg_14d",
     "m1018_prior_none",
     "m1018_prior_unknown",
     "m1018_prior_ur_incon",
     "m1018_prior_cath_icd10",
     "m1018_prior_disruptive_icd10",
     "m1018_prior_impr_decsn_icd10",
     "m1018_prior_intract_pain_icd10",
     "m1018_prior_mem_loss_icd10",
     "m1018_prior_nochg_14d_icd10",
     "m1018_prior_none_icd10",
     "m1018_prior_unknown_icd10",
     "m1018_prior_ur_incon_icd10",
     "m1020_primary_diag_icd",
     "m1020_primary_diag_severity",
     "m1022_oth_diag1_icd",
     "m1022_oth_diag1_severity",
     "m1022_oth_diag2_icd",
     "m1022_oth_diag2_severity",
     "m1022_oth_diag3_icd",
     "m1022_oth_diag3_severity",
     "m1022_oth_diag4_icd",
     "m1022_oth_diag4_severity",
     "m1022_oth_diag5_icd",
     "m1022_oth_diag5_severity",
     "m1024_pmt_diag_icd_a3",
     "m1024_pmt_diag_icd_a4",
     "m1024_pmt_diag_icd_b3",
     "m1024_pmt_diag_icd_b4",
     "m1024_pmt_diag_icd_c3",
     "m1024_pmt_diag_icd_c4",
     "m1024_pmt_diag_icd_d3",
     "m1024_pmt_diag_icd_d4",
     "m1024_pmt_diag_icd_e3",
     "m1024_pmt_diag_icd_e4",
     "m1024_pmt_diag_icd_f3",
     "m1024_pmt_diag_icd_f4",
     "m1021_primary_diag_severity",
     "m1023_oth_diag1_severity",
     "m1023_oth_diag2_severity",
     "m1023_oth_diag3_severity",
     "m1023_oth_diag4_severity",
     "m1023_oth_diag5_severity",
     "m1025_opt_diag_icd_a3",
     "m1025_opt_diag_icd_a4",
     "m1025_opt_diag_icd_b3",
     "m1025_opt_diag_icd_b4",
     "m1025_opt_diag_icd_c3",
     "m1025_opt_diag_icd_c4",
     "m1025_opt_diag_icd_d3",
     "m1025_opt_diag_icd_d4",
     "m1025_opt_diag_icd_e3",
     "m1025_opt_diag_icd_e4",
     "m1025_opt_diag_icd_f3",
     "m1025_opt_diag_icd_f4",
     "m1030_thh_ent_nutrition",
     "m1030_thh_iv_infusion",
     "m1030_thh_none_above",
     "m1030_thh_par_nutrition",
     "m1032_hosp_risk_5plus_mdctn",
     "m1032_hosp_risk_frailty",
     "m1032_hosp_risk_hstry_falls",
     "m1032_hosp_risk_mltpl_hospztn",
     "m1032_hosp_risk_none_above",
     "m1032_hosp_risk_othr",
     "m1032_hosp_risk_rcnt_dcln",
     "m1034_ptnt_ovral_stus",
     "m1036_rsk_alcoholism",
     "m1036_rsk_drugs",
     "m1036_rsk_none",
     "m1036_rsk_obesity",
     "m1036_rsk_smoking",
     "m1036_rsk_unknown",
     "m1040_inflnz_rcvd_agncy",
     "m1045_inflnz_rsn_not_rcvd",
     "m1050_ppv_rcvd_agncy",
     "m1055_ppv_rsn_not_rcvd_agncy",
     "m1100_ptnt_lvg_stutn",
     "m1200_vision",
     "m1210_hearg_ablty",
     "m1220_undrstg_verbal_cntnt",
     "m1230_speech",
     "m1240_frml_pain_asmt",
     "m1242_pain_freq_actvty_mvmt",
     "m1300_prsr_ulcr_risk_asmt",
     "m1302_risk_of_prsr_ulcr",
     "m1306_unhld_stg2_prsr_ulcr",
     "m1307_oldst_stg2_at_dschrg",
     "m1307_oldst_stg2_onst_dt",
     "m1308_nbr_prsulc_stg2",
     "m1308_nbr_prsulc_stg3",
     "m1308_nbr_prsulc_stg4",
     "m1308_nbr_stg2_at_soc_roc",
     "m1308_nbr_stg3_at_soc_roc",
     "m1308_nbr_stg4_at_soc_roc",
     "m1308_nstg_cvrg",
     "m1308_nstg_cvrg_soc_roc",
     "m1308_nstg_deep_tisue",
     "m1308_nstg_deep_tisue_soc_roc",
     "m1308_nstg_drsg",
     "m1308_nstg_drsg_soc_roc",
     "m1310_prsr_ulcr_lngth",
     "m1312_prsr_ulcr_wdth",
     "m1314_prsr_ulcr_depth",
     "m1320_stus_prblm_prsr_ulcr",
     "m1322_nbr_prsulc_stg1",
     "m1324_stg_prblm_ulcer",
     "m1330_stas_ulcr_prsnt",
     "m1332_nbr_stas_ulcr",
     "m1334_stus_prblm_stas_ulcr",
     "m1340_srgcl_wnd_prsnt",
     "m1342_stus_prblm_srgcl_wnd",
     "m1350_lesion_open_wnd",
     "m1400_when_dyspneic",
     "m1410_resptx_airpress",
     "m1410_resptx_none",
     "m1410_resptx_oxygen",
     "m1410_resptx_ventilator",
     "m1500_symtm_hrt_failr_ptnts",
     "m1510_hrt_failr_care_plan_chg",
     "m1510_hrt_failr_clncl_intrvtn",
     "m1510_hrt_failr_er_trtmt",
     "m1510_hrt_failr_no_actn",
     "m1510_hrt_failr_physn_cntct",
     "m1510_hrt_failr_physn_trtmt",
     "m1600_uti",
     "m1610_ur_incont",
     "m1615_incntnt_timing",
     "m1620_bwl_incont",
     "m1630_ostomy",
     "m1700_cog_function",
     "m1710_when_confused",
     "m1720_when_anxious",
     "m1730_phq2_dprsn",
     "m1730_phq2_lack_intrst",
     "m1730_stdz_dprsn_scrng",
     "m1740_bd_delusions",
     "m1740_bd_imp_decisn",
     "m1740_bd_mem_deficit",
     "m1740_bd_none",
     "m1740_bd_physical",
     "m1740_bd_soc_inappro",
     "m1740_bd_verbal",
     "m1745_beh_prob_freq",
     "m1750_rec_psych_nurs",
     "m1800_crnt_grooming",
     "m1810_crnt_dress_upper",
     "m1820_crnt_dress_lower",
     "m1830_crnt_bathg",
     "m1840_crnt_toiltg",
     "m1845_crnt_toiltg_hygn",
     "m1850_crnt_trnsfrng",
     "m1860_crnt_ambltn",
     "m1870_crnt_feeding",
     "m1880_crnt_prep_lt_meals",
     "m1890_crnt_phone_use",
     "m1900_prior_adliadl_ambltn",
     "m1900_prior_adliadl_hsehold",
     "m1900_prior_adliadl_self",
     "m1900_prior_adliadl_trnsfr",
     "m1910_mlt_fctr_fall_risk_asmt",
     "m2000_drug_rgmn_rvw",
     "m2002_mdctn_flwp",
     "m2004_mdctn_intrvtn",
     "m2010_high_risk_drug_edctn",
     "m2015_drug_edctn_intrvtn",
     "m2020_crnt_mgmt_oral_mdctn",
     "m2030_crnt_mgmt_injctn_mdctn",
     "m2040_prior_mgmt_injctn_mdctn",
     "m2040_prior_mgmt_oral_mdctn",
     "m2100_care_type_src_adl",
     "m2100_care_type_src_advcy",
     "m2100_care_type_src_equip",
     "m2100_care_type_src_iadl",
     "m2100_care_type_src_mdctn",
     "m2100_care_type_src_prcdr",
     "m2100_care_type_src_sprvsn",
     "m2110_adl_iadl_astnc_freq",
     "m2200_ther_need_na",
     "m2200_ther_need_nbr",
     "m2250_plan_smry_dbts_ft_care",
     "m2250_plan_smry_dprsn_intrvtn",
     "m2250_plan_smry_fall_prvnt",
     "m2250_plan_smry_pain_intrvtn",
     "m2250_plan_smry_prsulc_prvnt",
     "m2250_plan_smry_prsulc_trtmt",
     "m2250_plan_smry_ptnt_specf",
     "m2300_emer_use_aftr_last_asmt",
     "m2310_ecr_crdc_dsrthm",
     "m2310_ecr_cthtr_cmplctn",
     "m2310_ecr_dhydrtn_malntr",
     "m2310_ecr_dvt_pulmnry",
     "m2310_ecr_gi_prblm",
     "m2310_ecr_hrt_failr",
     "m2310_ecr_hypoglyc",
     "m2310_ecr_injry_by_fall",
     "m2310_ecr_medication",
     "m2310_ecr_mentl_bhvrl_prblm",
     "m2310_ecr_mi_chst_pain",
     "m2310_ecr_other",
     "m2310_ecr_othr_hrt_dease",
     "m2310_ecr_rsprtry_infctn",
     "m2310_ecr_rsprtry_othr",
     "m2310_ecr_stroke_tia",
     "m2310_ecr_uncntld_pain",
     "m2310_ecr_unknown",
     "m2310_ecr_uti",
     "m2310_ecr_wnd_infctn_dtrortn",
     "m2400_intrvtn_smry_dbts_ft",
     "m2400_intrvtn_smry_dprsn",
     "m2400_intrvtn_smry_fall_prvnt",
     "m2400_intrvtn_smry_pain_mntr",
     "m2400_intrvtn_smry_prsulc_prvn",
     "m2400_intrvtn_smry_prsulc_wet",
     "m2410_inpat_facility",
     "m2420_dschrg_disp",
     "m2430_hosp_crdc_dsrthm",
     "m2430_hosp_cthtr_cmplctn",
     "m2430_hosp_dhydrtn_malntr",
     "m2430_hosp_dvt_pulmnry",
     "m2430_hosp_gi_prblm",
     "m2430_hosp_hrt_failr",
     "m2430_hosp_hypoglyc",
     "m2430_hosp_injry_by_fall",
     "m2430_hosp_med",
     "m2430_hosp_mentl_bhvrl_prblm",
     "m2430_hosp_mi_chst_pain",
     "m2430_hosp_other",
     "m2430_hosp_othr_hrt_dease",
     "m2430_hosp_pain",
     "m2430_hosp_rsprtry_infctn",
     "m2430_hosp_rsprtry_othr",
     "m2430_hosp_schld_trtmt",
     "m2430_hosp_stroke_tia",
     "m2430_hosp_uk",
     "m2430_hosp_ur_tract",
     "m2430_hosp_wnd_infctn",
     "m2440_nh_hospice",
     "m2440_nh_other",
     "m2440_nh_permanent",
     "m2440_nh_respite",
     "m2440_nh_therapy",
     "m2440_nh_unknown",
     "m2440_nh_unsafe_home",
     "m1033_hosp_risk_weight_loss",
     "m1033_hosp_risk_mltpl_ed_visit",
     "m1033_hosp_risk_mntl_bhv_dcln",
     "m1033_hosp_risk_compliance",
     "m1033_hosp_risk_crnt_exhstn",
     "m1033_hosp_risk_othr_risk",
     "m1033_hosp_risk_hstry_falls",
     "m1033_hosp_risk_mltpl_hospztn",
     "m1033_hosp_risk_5plus_mdctn",
     "m1033_hosp_risk_none_above",
     "m2102_care_type_src_iadl",
     "m2102_care_type_src_adl",
     "m2102_care_type_src_mdctn",
     "m2102_care_type_src_prcdr",
     "m2102_care_type_src_equip",
     "m2102_care_type_src_sprvsn",
     "m2102_care_type_src_advcy",
     "m1041_in_inflnz_season",
     "m1046_inflnz_recd_crnt_season",
     "m1051_pvx_rcvd_agncy",
     "m1056_pvx_rsn_not_rcvd_agncy",
     "extended_oasis",
     "m1309_nbr_new_wrs_prsulc_stg2",
     "m1309_nbr_new_wrs_prsulc_stg3",
     "m1309_nbr_new_wrs_prsulc_stg4",
     "m1309_nbr_new_wrs_prsulc_nstg"
    ] + ICD10_FIELDS
  end

  def self.store_attr_accessor
    self.key_fields + self.key_fields_original + self.oasis_fields + Wound::WOUND_PRIMARY_ATTRS + Wound::WOUND_DESCRIPTION_ATTRS + OasisPocField::FIELDS
  end

  def self.included(klass)

    klass.validate :compare_document_hipps_code_with_rap, :unless => :new_record?

    klass.store :data, :accessors => self.store_attr_accessor

    def set_original_values
      OasisExtension.key_fields.each do |field|
        self.send("#{field}_original=", self.send(field))
      end
    end

    def pre_populate_patient_and_visit_info
      if treatment_visit
        self.field_staff = treatment_visit.visited_user if treatment_visit.visited_user.present?
        self.treatment_episode = treatment_visit.treatment_episode
      end
      if treatment
        org = treatment.patient.org
        self.m0010_ccn = org.health_agency_detail.cms_cert_number
        self.m0016_branch_id = (org.branch_id.present? ? org.branch_id : "P")
        self.m0014_branch_state = org.state unless ['N', 'P'].include?(self.m0016_branch_id)
        self.m0040_pat_fname = treatment.patient.first_name
        self.m0040_pat_mi = treatment.patient.middle_initials
        self.m0040_pat_lname = treatment.patient.last_name
        self.m0040_pat_suffix = treatment.patient.suffix
        self.m0064_ssn = treatment.patient.ssn.gsub("-","")
        self.m0064_ssn_uk = m0064_ssn.nil?
        self.m0065_medicaid_na = m0065_medicaid_num.nil?
        self.m0050_pat_st = treatment.patient.state
        self.m0060_pat_zip = treatment.patient.zip_code
        self.m0066_pat_birth_dt = treatment.patient.dob
        self.m0069_pat_gender = (treatment.patient.gender == 'M')? 1 : 2
        self.m0030_start_care_dt = treatment.treatment_start_date
        self.m0063_medicare_num = treatment.patient.medicare_number
        self.m0063_medicare_na = m0063_medicare_num.nil?
        self.m0020_pat_id = treatment.patient.patient_reference
        self.m0018_physician_id = treatment.primary_physician.npi_number if treatment.primary_physician.present?
        self.patient_name = treatment.patient.full_name
        self.mr = treatment.patient.patient_reference
        self.physician_name = treatment.primary_physician.full_name if treatment.primary_physician.present?
      end
      self.state_machine_id = '1'
      self.status = :draft
    end

    def hha_agency_id
      return unless treatment
      org = treatment.patient.org
      org.hha_agency_id
    end

    def natl_prov_id
      return unless treatment
      org = treatment.patient.org
      org.health_agency_detail.npi_number
    end

    def set_soc_roc_pressure_ulcer_values
      roc = treatment.first_episode.documents.order('document_date DESC').where("document_type IN (?) and status in (?)", ["OasisResumptionOfCare"],  ["C", "E"]).first if treatment
      soc = treatment.first_episode.documents.order('document_date DESC').where("document_type IN (?) and status in (?)", ["OasisEvaluation"], ["C", "E"]).first if treatment
      document = if roc
                   roc
                 elsif soc
                   soc
                 end
      if document
        self.m1308_nbr_stg2_at_soc_roc = document.m1308_nbr_prsulc_stg2
        self.m1308_nbr_stg3_at_soc_roc = document.m1308_nbr_prsulc_stg3
        self.m1308_nbr_stg4_at_soc_roc = document.m1308_nbr_prsulc_stg4
        self.m1308_nstg_cvrg_soc_roc = document.m1308_nstg_cvrg
        self.m1308_nstg_deep_tisue_soc_roc = document.m1308_nstg_deep_tisue
        self.m1308_nstg_drsg_soc_roc = document.m1308_nstg_drsg
      end
    end

    def compare_document_hipps_code_with_rap
      if (self.valid_document? and hipps_code_required_doc? and self.changed.include?("data"))
        rap = treatment_episode.rap_invoice
        service = rap.home_health_service if (rap and rap.can_update_hipps_code_and_amount? == false)
        return unless service
        score = self.calculate_hipps_code
        if service.hcpcs_code != score.hipps_code
         # errors.add(:base, "Document cannot be saved. Since document modification result in different HIPPS code than approved RAP Claim HIPPS code.")
        end
      end
    end

  end

  def asst_date_condition_required
    treatment_episode.start_date > Date.parse('05-10-2015') || treatment_episode.start_date < Date.parse('03-08-2015')
  end

  def icd9_or_icd10
    return if asst_date_condition_required.present?
    res = if (treatment_episode.start_date >= Date.parse('01-10-2015') || (m0090_info_completed_dt and Date.strptime(m0090_info_completed_dt, '%m/%d/%Y') >= Date.parse('20151001')))
      "0"
    elsif (treatment_episode.start_date <= Date.parse('03-08-2015') ||  (m0090_info_completed_dt and Date.strptime(m0090_info_completed_dt, '%m/%d/%Y') < Date.parse('20151001')))
      "9"
    #elsif (treatment_episode and icd_required_doc and treatment_episode.start_date < Date.parse('03-08-2015'))
    #  "9"
    #elsif (treatment_episode and icd_required_doc and treatment_episode.start_date >= Date.parse('05-10-2015'))
    #  "0"
    end
    debug_log res
    res
  end


  def reset_values_based_on_info_completed_date?
    if self.new_record? and self.m0090_info_completed_dt.present?
      reset_values(icd9_or_icd10)
    elsif self.changes.present? and self.changes["data"].present?
      old_value = self.changes["data"][0]["m0090_info_completed_dt"]
      new_value = self.m0090_info_completed_dt
      if(old_value.present? and new_value.present? and old_value != new_value)
        reset_values(icd9_or_icd10)
      end
    end
    nil
  end

  def reset_values(icd_code)
    res = if icd_code == "0"
            rap_approved? ? ICD9_NON_PAYMENT_CODES : ICD9_FIELDS
          elsif icd_code == "9"
            final_claim_approved? ? ICD10_NON_PAYMENT_CODES : ICD10_FIELDS
          end
    reset_the_fields(res)
  end

  def reset_the_fields(fields)
    if fields.present?
      fields.each do |attribute|
        self.send("#{attribute}=", nil)
      end
    end
  end

 def rap_approved?
   treatment_episode.rap_approved?
 end

  def final_claim_approved?
    treatment_episode.final_claim_approved?
  end

end