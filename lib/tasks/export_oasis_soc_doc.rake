desc "Export OASIS SOC Document, EX: rake export_oasis_soc_doc hipps_code='1BGKS'"
task :export_oasis_soc_doc => [:environment] do
  raise "Please provide year in 'hipps_code' argument" unless ENV['hipps_code']
  require 'csv'
  require 'yaml'
  fields = YAML.load_file("#{Rails.root}/oasis_example_sample.yml")
  #"1CGKV"

  position1 = {"1" => ["early", [0, 13]], "2" => ["early", [14, 19]], "3" => ["later", [0,13]], "4" => ["later", [14, 19]],
               "5" => ["Any", [20]]}

  position2_score_range = {"1" => {"A" => [0, 4], "B" => [5, 8], "C" => [9]}, "2" => {"A" => [0, 6], "B" => [7, 14], "C" => [15]},
              "3" => {"A" => [0, 2], "B" => [3, 5], "C" => [6]}, "4" => {"A" => [0, 8], "B" => [9, 16], "C" => [17]},
              "5" => {"A" => [0, 7], "B" => [8, 14], "C" => [15]}}

  position3_score_range = {"1" => {"F" => [0, 5], "G" => [6], "H" => [7]}, "2" => {"F" => [0, 6], "G" => [7], "H" => [8]},
              "3" => {"F" => [0, 8], "G" => [9], "H" => [10]}, "4" => {"F" => [0, 7], "G" => [8], "H" => [9]},
              "5" => {"A" => [0, 6], "B" => [7], "C" => [8]}}

  position4_score_range = {"1" => {"K" => [0, 5], "L" => [6], "M" => [7, 9], "N" => [10], "P" => [11, 13]},
              "2" => {"K" => [14, 15], "L" => [16, 17], "M" => [18, 19]},
              "3" => {"K" => [0, 5], "L" => [6], "M" => [7, 9], "N" => [10], "P" => [11, 13]},
              "4" => {"K" => [14, 15], "L" => [16, 17], "M" => [18, 19]},
              "5" => {"K" => [20]}}

  position5_score_range = {"S" => [0], "T" => [1, 14], "U" => [15, 27], "V" => [28, 48], "W" => [49, 98], "X" => [99]}

  hipps_code = ENV['hipps_code']

  episode_type = hipps_code[0]
  clinical_score_char = hipps_code[1]
  functional_score_char = hipps_code[2]
  no_of_visits_char = hipps_code[3]
  nrs_score_char = hipps_code[4]

  pos2_required_score_range = position2_score_range[episode_type][clinical_score_char]
  pos3_required_score_range = position3_score_range[episode_type][functional_score_char]
  pos4_required_score_range = position4_score_range[episode_type][no_of_visits_char]
  pos5_required_score_range = position5_score_range[nrs_score_char]

  pos_2_fields = ["m1020_primary_diag_icd", "m1024_pmt_diag_icd_a3", "m1024_pmt_diag_icd_a4",
                  "m1022_oth_diag1_icd", "m1024_pmt_diag_icd_b3", "m1024_pmt_diag_icd_b4",
                  "m1022_oth_diag2_icd", "m1024_pmt_diag_icd_c3", "m1024_pmt_diag_icd_c4",
                  "m1022_oth_diag3_icd", "m1024_pmt_diag_icd_d3", "m1024_pmt_diag_icd_d4",
                  "m1022_oth_diag4_icd", "m1024_pmt_diag_icd_e3", "m1024_pmt_diag_icd_e4",
                  "m1022_oth_diag5_icd", "m1024_pmt_diag_icd_f3", "m1024_pmt_diag_icd_f4",
                  "m1030_thh_iv_infusion", "m1030_thh_par_nutrition", "m1030_thh_ent_nutrition", "m1030_thh_none_above",
                  "m1200_vision", "m1242_pain_freq_actvty_mvmt", "m1308_nbr_prsulc_stg2", "m1308_nbr_prsulc_stg3",
                  "m1308_nbr_prsulc_stg4", "m1308_nstg_drsg", "m1308_nstg_cvrg", "m1322_nbr_prsulc_stg1", "m1324_stg_prblm_ulcer",
                  "m1330_stas_ulcr_prsnt", "m1332_nbr_stas_ulcr", "m1334_stus_prblm_stas_ulcr", "m1342_stus_prblm_srgcl_wnd",
                  "m1400_when_dyspneic", "m1610_ur_incont", "m1620_bwl_incont", "m1630_ostomy", "m2030_crnt_mgmt_injctn_mdctn"
                  ]

  pos_3_fields = ["m1810_crnt_dress_upper", "m1820_crnt_dress_lower", "m1830_crnt_bathg", "m1840_crnt_toiltg",
                  "m1850_crnt_trnsfrng", "m1860_crnt_ambltn"
                 ]

  pos_5_fields = ["m1030_thh_iv_infusion", "m1030_thh_par_nutrition", "m1030_thh_ent_nutrition", "m1030_thh_none_above",
                  "m1308_nbr_prsulc_stg2", "m1308_nbr_prsulc_stg3", "m1308_nbr_prsulc_stg4", "m1308_nstg_drsg", "m1308_nstg_cvrg",
                  "m1322_nbr_prsulc_stg1", "m1330_stas_ulcr_prsnt", "m1332_nbr_stas_ulcr", "m1334_stus_prblm_stas_ulcr",
                  "m1342_stus_prblm_srgcl_wnd", "m1610_ur_incont", "m1620_bwl_incont", "m1630_ostomy", "m1020_primary_diag_icd", "m1020_oth_diag1_icd",
                  "m1020_oth_diag2_icd", "m1020_oth_diag3_icd", "m1020_oth_diag4_icd", "m1020_oth_diag5_icd", "m1020_primary_diag_severity",
                   "m1022_oth_diag1_severity", "m1022_oth_diag2_severity", "m1022_oth_diag3_severity", "m1022_oth_diag4_severity", "m1022_oth_diag5_severity"
                 ]

 pos_2_field_values = {"1" => {"A" => {"m1030_thh_none_above" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '03',
                                      "m1324_stg_prblm_ulcer" => 'NA', "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil,
                                     "m1400_when_dyspneic" => '01', "m1620_bwl_incont" => '02', "m1630_ostomy" => '00', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                               },
                               "B" => {"m1030_thh_ent_nutrition" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '03',
                                       "m1324_stg_prblm_ulcer" => '02', "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil,
                                        "m1400_when_dyspneic" => '01', "m1620_bwl_incont" => '03', "m1630_ostomy" => '00', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                              },
                               "C" => {"m1030_thh_ent_nutrition" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '01',
                                       "m1324_stg_prblm_ulcer" => '02', "m1334_stus_prblm_stas_ulcr" => nil,
                                       "m1342_stus_prblm_srgcl_wnd" => nil, "m1400_when_dyspneic" => '01', "m1620_bwl_incont" => 'NA',
                                       "m1630_ostomy" => '01', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                              }
                              },
                        "2" => {"A" => {"m1030_thh_none_above" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '03',
                                       "m1324_stg_prblm_ulcer" => 'NA', "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil,
                                      "m1400_when_dyspneic" => '01', "m1620_bwl_incont" => '02', "m1630_ostomy" => '00', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                                },
                               "B" => {"m1030_thh_ent_nutrition" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '03',
                                        "m1324_stg_prblm_ulcer" => 'NA', "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil,
                                        "m1400_when_dyspneic" => '01', "m1620_bwl_incont" => '01', "m1630_ostomy" => '00', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                                },
                                "C" => {"m1030_thh_ent_nutrition" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '01',
                                    "m1324_stg_prblm_ulcer" => '03', "m1334_stus_prblm_stas_ulcr" => nil,
                                    "m1342_stus_prblm_srgcl_wnd" => nil, "m1400_when_dyspneic" => '02', "m1620_bwl_incont" => 'NA',
                                    "m1630_ostomy" => '01', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                                }
                              },
                        "3" => {"A" => {"m1030_thh_none_above" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '03',
                                       "m1324_stg_prblm_ulcer" => 'NA', "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil,
                                      "m1400_when_dyspneic" => '00', "m1620_bwl_incont" => '00', "m1630_ostomy" => '00', "m2030_crnt_mgmt_injctn_mdctn" => 'NA'
                                },
                               "B" => {"m1030_thh_ent_nutrition" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '03',
                                        "m1324_stg_prblm_ulcer" => 'NA', "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil,
                                        "m1400_when_dyspneic" => '01', "m1620_bwl_incont" => '03', "m1630_ostomy" => '00', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                                },
                                "C" => {"m1030_thh_ent_nutrition" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '03',
                                    "m1324_stg_prblm_ulcer" => '03', "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil,
                                    "m1400_when_dyspneic" => '02', "m1620_bwl_incont" => 'NA', "m1630_ostomy" => '01', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                                }
                              },
                        "4" => {"A" => {"m1030_thh_none_above" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '03',
                                       "m1324_stg_prblm_ulcer" => 'NA', "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil,
                                      "m1400_when_dyspneic" => '01', "m1620_bwl_incont" => '02', "m1630_ostomy" => '00', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                                },
                               "B" => {"m1030_thh_ent_nutrition" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '03',
                                        "m1324_stg_prblm_ulcer" => '02', "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil,
                                        "m1400_when_dyspneic" => '01', "m1620_bwl_incont" => '03', "m1630_ostomy" => '00', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                                },
                                "C" => {"m1030_thh_ent_nutrition" => '1', "m1200_vision" => '01', "m1242_pain_freq_actvty_mvmt" => '01',
                                    "m1324_stg_prblm_ulcer" => '02', "m1334_stus_prblm_stas_ulcr" => nil,
                                    "m1342_stus_prblm_srgcl_wnd" => nil, "m1400_when_dyspneic" => '01', "m1620_bwl_incont" => 'NA',
                                    "m1630_ostomy" => '01', "m2030_crnt_mgmt_injctn_mdctn" => '00'
                                }
                              }
                      }

  pos_3_field_values = {"1" => {
                                "F" => {"m1810_crnt_dress_upper" => "01", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "02",
                                 "m1840_crnt_toiltg" => "00", "m1850_crnt_trnsfrng" => "00", "m1860_crnt_ambltn" => "00"
                                 },
                                 "G" => {"m1810_crnt_dress_upper" => "01", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "03",
                                  "m1840_crnt_toiltg" => "01", "m1850_crnt_trnsfrng" => "04", "m1860_crnt_ambltn" => "03"
                                  },
                                "H" => {"m1810_crnt_dress_upper" => "01", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "03",
                                 "m1840_crnt_toiltg" => "02", "m1850_crnt_trnsfrng" => "02", "m1860_crnt_ambltn" => "03" }
                              },
                         "2" => {"F" => {"m1810_crnt_dress_upper" => "00", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "02",
                                         "m1840_crnt_toiltg" => "02", "m1850_crnt_trnsfrng" => "00", "m1860_crnt_ambltn" => "00"
                                        },
                                  "G" => {"m1810_crnt_dress_upper" => "01", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "02",
                                           "m1840_crnt_toiltg" => "00", "m1850_crnt_trnsfrng" => "00", "m1860_crnt_ambltn" => "00"
                                  },
                                "H" => {"m1810_crnt_dress_upper" => "01", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "02",
                                 "m1840_crnt_toiltg" => "02", "m1850_crnt_trnsfrng" => "02", "m1860_crnt_ambltn" => "03" }
                              },
                         "3" => {"F" => {"m1810_crnt_dress_upper" => "00", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "00",
                                          "m1840_crnt_toiltg" => "02", "m1850_crnt_trnsfrng" => "00", "m1860_crnt_ambltn" => "00"
                                         },
                                   "G" => {"m1810_crnt_dress_upper" => "01", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "02",
                                            "m1840_crnt_toiltg" => "00", "m1850_crnt_trnsfrng" => "00", "m1860_crnt_ambltn" => "01"
                                   },
                                 "H" => {"m1810_crnt_dress_upper" => "01", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "02",
                                  "m1840_crnt_toiltg" => "02", "m1850_crnt_trnsfrng" => "02", "m1860_crnt_ambltn" => "03" }
                               },
                         "4" => {"F" => {"m1810_crnt_dress_upper" => "00", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "00",
                                       "m1840_crnt_toiltg" => "02", "m1850_crnt_trnsfrng" => "00", "m1860_crnt_ambltn" => "00"
                                      },
                                "G" => {"m1810_crnt_dress_upper" => "01", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "02",
                                         "m1840_crnt_toiltg" => "00", "m1850_crnt_trnsfrng" => "00", "m1860_crnt_ambltn" => "00"
                                },
                              "H" => {"m1810_crnt_dress_upper" => "01", "m1820_crnt_dress_lower" => "00", "m1830_crnt_bathg" => "02",
                               "m1840_crnt_toiltg" => "02", "m1850_crnt_trnsfrng" => "02", "m1860_crnt_ambltn" => "04" }
                            }
                       }

  pos_5_field_values = {"S" => {"m1322_nbr_prsulc_stg1" => '00', "m1332_nbr_stas_ulcr" => nil, "m1330_stas_ulcr_prsnt" => '00', "m1630_ostomy" => "00",
                                  "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil, "m1030_thh_ent_nutrition" => "1", "m1610_ur_incont" => "00",
                                   "m1620_bwl_incont" => '03'
                                 },
                                 "T" => {"m1322_nbr_prsulc_stg1" => '01', "m1332_nbr_stas_ulcr" => nil, "m1330_stas_ulcr_prsnt" => '00', "m1630_ostomy" => "00",
                                   "m1334_stus_prblm_stas_ulcr" => nil, "m1342_stus_prblm_srgcl_wnd" => nil, "m1030_thh_ent_nutrition" => "1", "m1610_ur_incont" => "00",
                                    "m1620_bwl_incont" => '03'
                                 },
                                 "U" => {"m1322_nbr_prsulc_stg1" => '03', "m1330_stas_ulcr_prsnt" => '00', "m1630_ostomy" => "00", "m1610_ur_incont" => "02"},
                                  "V" => {"m1322_nbr_prsulc_stg1" => '03', "m1330_stas_ulcr_prsnt" => '01', "m1630_ostomy" => "00", "m1610_ur_incont" => "02",
                                  "m1332_nbr_stas_ulcr" => '04', "m1334_stus_prblm_stas_ulcr" => '00'
                                  },
                                  "W" => {"m1322_nbr_prsulc_stg1" => '03', "m1330_stas_ulcr_prsnt" => '01', "m1630_ostomy" => "00", "m1610_ur_incont" => "02",
                                   "m1332_nbr_stas_ulcr" => '04', "m1334_stus_prblm_stas_ulcr" => '01'
                                  },
                                  "X" => {"m1030_thh_none_above" => '1', "m1242_pain_freq_actvty_mvmt" => '01', "m1322_nbr_prsulc_stg1" => '03', "m1330_stas_ulcr_prsnt" => '01', "m1630_ostomy" => "00", "m1610_ur_incont" => "02",
                                   "m1306_unhld_stg2_prsr_ulcr" => '1', "m1308_nbr_prsulc_stg2" => '4', "m1308_nbr_prsulc_stg3" => '0', "m1308_nbr_prsulc_stg4" => '0',
                                   "m1308_nstg_drsg" => '2', "m1308_nstg_cvrg" => '2', "m1308_nstg_deep_tisue" => '0', "m1310_prsr_ulcr_lngth" => '0',
                                   "m1312_prsr_ulcr_wdth" => '0', "m1314_prsr_ulcr_depth" => '0', "m1320_stus_prblm_prsr_ulcr" => '03', "m1332_nbr_stas_ulcr" => '04', "m1334_stus_prblm_stas_ulcr" => '01'
                                  }
                       }

  episode_timing = case position1[episode_type][0]
                   when 'early'
                     '01'
                   when 'later'
                     '02'
                   else
                     '01'
                   end

  episode_type = (episode_type == '5') ? '3' : episode_type
  fields.merge!({"m0110_episode_timing" => episode_timing})
  fields.merge!(pos_2_field_values[episode_type][clinical_score_char])
  fields.merge!(pos_3_field_values[episode_type][functional_score_char])
  fields.merge!({"m2200_ther_need_nbr" => pos4_required_score_range[0]})
  fields.merge!(pos_5_field_values[nrs_score_char])

  deletable_fields = ((pos_2_fields + pos_3_fields + pos_5_fields).uniq - (pos_2_field_values[episode_type][clinical_score_char].keys +
                          pos_3_field_values[episode_type][functional_score_char].keys + pos_5_field_values[nrs_score_char].keys))
  deletable_fields = deletable_fields.uniq
  fields = fields.delete_if{|k, v| deletable_fields.include?(k) }

    debug_log "Fields .................................................."
    debug_log fields
  File.open("#{Rails.root}/oasis_example.yml", 'w') do |f|
    YAML.dump(fields, f)
  end

end
