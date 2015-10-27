class MedicareRemittanceSummary < Netzke::Basepack::Panel
  def configuration
    c = super
    c.merge(
      layout: {
        type: 'vbox',
        align: :stretch,
      },
      header: false,
      title:false,
      item_id: :remittance_summary,
      items: [
        :medicare_remittance_summary_details.component,
        :provider_adjustment_details.component
      ]
    )
  end

  component :medicare_remittance_summary_details do
    {
      class_name: "MedicareRemittanceSummaryDetails",
      header: false,
      title: false,
      remittance_id: config[:medicare_remittance_id]
    }
  end

  component :provider_adjustment_details do
    {
      class_name: "ProviderAdjustmentDetails",
      title: "Provider Adjustment Details",
      flex: 1,
      scope: {medicare_remittance_id: config[:medicare_remittance_id]},
    }
  end
end

