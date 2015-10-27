class MedicareRemittanceSummaryDetails < Mahaswami::Panel
  def configuration
    s = super
    remittance = MedicareRemittance.find(s[:remittance_id])
    s.merge(
        auto_scroll: true,
        layout: {
            type: 'vbox',
        },
        defaults: {
            label_align: "right",
            label_width:  300,
            margin: '5px'
        },
        items: item_list(remittance)

    )
  end

  def item_list(remittance)
    labels = ["Total Number of Claims","Check Date","Check Number","Total Billed Amount","Total Reason Code Adjustment Amount","Total Allowed Amount","Total Co-Insurance Amount","Total Deductible Amount","Total Paid to Provider","Total Interest Amount","Total CHECK/EFT Amount"]
    value_fields = ["total_no_of_claims","check_eft_date_display","check_eft_number","total_billed_amount","total_adjusted_amount","total_allowed_amount","total_co_ins_amount","total_deductible_amount","total_paid_amount","total_interest_amount","check_eft_amount"]
    list = []
    labels.each_with_index do |label, index|
      list << {
          layout: :hbox,
          border: false,
          items: [{
                      xtype: 'label',
                      text: label,
                      width: 300,
                  }, {
                      xtype: "label",
                      text: ":",
                      width: 20

                  },{
                      xtype: 'label',
                      width: 120,
                      text: (value_fields[index].include?('amount') ? remittance.formatted_amount(remittance.send(value_fields[index])) : remittance.send(value_fields[index])),
                      style: 'text-align:right;'
                  }]
      }
    end
    list
  end



end
