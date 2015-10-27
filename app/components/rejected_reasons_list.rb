class RejectedReasonsList < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge(
        header: false,
        model: "Invoice",
        editOnDblClick: false,
        bbar: false,
        context_menu: false,
        columns: [
        {
        id: 'rejected_reason',
        name: 'rejected_reason',
        header: 'Rejected Reason',
        flex: 1,
        sortable: true,
        dataIndex: 'transmission_note',
        tdCls: 'wrap'
    }
    ],
        rejected_reasons: s[:rejected_reasons],
        layout:'fit',
        viewConfig: {forceFit: true}
    )
  end

  def get_data(*args)
    res = {}
    rejected_reasons_hash = config[:rejected_reasons]
    reasons_list = []
    rejected_reasons_hash = [rejected_reasons_hash]
=begin
    c = EdiParsers::Edi277Parser.allocate
    patient_hash_info = rejected_reasons_hash
    debug_log("@@@@@@@@@@@@@@@@@@ #{patient_hash_info}..........#{patient_hash_info.class}")
    rejected_reasons= patient_hash_info[:patient_claim_information]
    debug_log "rejected_reasons............#{rejected_reasons.inspect}"
    rejected_reasons_array = rejected_reasons[:reject_or_accepted_reasons]
    rejected_reasons_array.each do |ele|
      stat1 = ele.to_s.split(" : ")
      debug_log("@@@@@@@@@@@@@@@@@@@ #{stat1}")
    end
    reasons_list = []
    x = rejected_reasons
    reasons = x.flatten
    reasons.first.split(",").each_with_index do |reason, index|
      reasons_list <<  [index,reason]
    end
=end
    rejected_reasons_hash.first.split(",").each_with_index do |reason, index|
      debug_log("@@@@@@@@@@@@@@@@@@ #{index} - #{reason}")
      reasons_list <<  [index,reason]
    end
    res[:data] = reasons_list
  end
end