docs = [741, 454, 599, 614, 590, 617, 457, 606, 589, 618, 583, 587, 584, 733,732,760,592,702,707,741,727,713,574,746,755,752,703,725,625,
727,747,761,734,789]
theraphy_needed = ["000", "17", "7", "000", "10", "001", "11", "000", 12, 6, 8, 7, 14, 0, 0, 8, 0, 0, 0, 0, 0, 9, 0, 0, 0, 7, 10, 0, 8, 0,
9, 0, 7, 4]

docs.each_with_index do |id, index|
  doc = Document.find(id)
  doc.m2200_ther_need_num = theraphy_needed[index]
  doc.save(:validate => false)
  score = doc.calculate_hipps_code
  episode = doc.treatment_episode
  debug_log doc.treatment.patient.full_name
  debug_log episode.id
  debug_log score
  if score.present?
    doc.subm_hipps_code = score.hipps_code
    doc.subm_hipps_version = score.hipps_code_version
    doc.save(:validate => false)
    episode_year = episode.start_date.year
    standard_rate = 2137.73
    standard_rural_rate = 2201.86
    labor_percent = 0.78535
    non_labor_percent = 0.21465
    episode.update_attributes({initial_hipps_code: score.hipps_code,
                               treatment_authorization: score.treatment_authorization_code, hipps_version: score.hipps_code_version})
    invoice = episode.invoices.where(invoice_type: '322').first
    hc = ProspectivePaymentSystem::HippsCode.find_by_hipps_code_and_calander_year(score.hipps_code, episode_year)
    if hc.present?
      patient = episode.treatment.patient
      zip = ZipCode.find_by_zip_code(patient.zip_code)
      cbsa =  ProspectivePaymentSystem::MedicareCoreStatArea.find_by_county_name_and_calander_year(zip.admin_name_2, episode_year)

      base_rate, supply_add_on_amount = if cbsa.cbsa_code.starts_with?("99")    #99 = Rural codes
                                          [standard_rural_rate, hc.rural_supply_add_on_amount]
                                        else
                                          [standard_rate, hc.supply_add_on_amount]
                                        end
      debug_log "HHRG Weight = #{hc.hhrg_weight}"
      debug_log "CBSA Code = #{cbsa.cbsa_code}"
      debug_log "CBSA Weight Index = #{cbsa.wage_index}"

      hhrg_weighted = (base_rate * hc.hhrg_weight).round(2)
      debug_log "HHRG Weighted = #{hhrg_weighted}"
      labor_part = (hhrg_weighted * labor_percent).round(2)
      debug_log "Labor Part = #{labor_part}"
      non_labor_part =  (hhrg_weighted * non_labor_percent).round(2)
      debug_log "Non Labor Part = #{non_labor_part}"

      geo_weight_adjustment_for_labor = (labor_part * cbsa.wage_index).round(2)
      debug_log "Labor Weight Index Adj = #{geo_weight_adjustment_for_labor}"
      debug_log "Supply Add-on = #{supply_add_on_amount}"
      bill_amount = (geo_weight_adjustment_for_labor + non_labor_part + supply_add_on_amount.to_f).round(2)
      debug_log "Total Amount = #{bill_amount}"

      invoice.update_column(:invoice_amount, bill_amount) if invoice
      receivable = invoice.receivables.first if invoice
      receivable.update_attributes(hcpcs_code: score.hipps_code, receivable_amount: bill_amount) if receivable
    end

  end

end


















