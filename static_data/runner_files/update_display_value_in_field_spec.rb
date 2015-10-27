icd10 = ["m1011_14_day_inp1_icd", "m1011_14_day_inp_na", "m1011_14_day_inp2_icd", "m1011_14_day_inp3_icd", "m1011_14_day_inp4_icd",
                    "m1011_14_day_inp5_icd", "m1011_14_day_inp6_icd", "m1017_chgreg_icd1", "m1017_chgreg_icd2", "m1017_chgreg_icd3",
                    "m1017_chgreg_icd4", "m1017_chgreg_icd5", "m1017_chgreg_icd6", "m1017_chgreg_icd_na", "m1021_primary_diag_icd",
                    "m1023_oth_diag1_icd",  "m1023_oth_diag2_icd", "m1023_oth_diag3_icd", "m1023_oth_diag4_icd", "m1023_oth_diag5_icd",
                    "m1025_opt_diag_icd_a3", "m1025_opt_diag_icd_a4", "m1025_opt_diag_icd_b3", "m1025_opt_diag_icd_b4",
                    "m1025_opt_diag_icd_c3",
                    "m1025_opt_diag_icd_c4", "m1025_opt_diag_icd_d3", "m1025_opt_diag_icd_d4", "m1025_opt_diag_icd_e3",
                    "m1025_opt_diag_icd_e4", "m1025_opt_diag_icd_f3", "m1025_opt_diag_icd_f4"]
values = ['a', 'NA', 'b', 'c', 'd', 'e', 'f', 'a', 'b', 'c', 'd', 'e', 'f', 'NA', 'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'a3',
          'a4', 'b3', 'b4', 'c3', 'c4', 'd3', 'd4', 'e3', 'e4', 'f3', 'f4' ]
icd10.each_with_index do |item, i|
OasisFieldSpec.where(field_name: item.upcase).update_all(display_value: values[i])
end

['M1005_INP_DISCHARGE_DT', 'M1005_INP_DSCHG_UNKNOWN'].each do |field|
  OasisFieldSpec.where(field_name: field, oasis_spec_version: '02.12.0').update_all(rfa_4: false, rfa_5: false)
end

