class ReplaceFrequencyForm < Mahaswami::Panel

  def configuration
    c = super
    c.merge(
      header: false,
      items: [
        {name: :frequency_string, field_label: "Frequency", item_id: :new_frequency, xtype: :textfield, margin: 10},
        {name: :frequency_start_date, field_label: "Start Date", item_id: :start_date, margin: 10, xtype: :datefield, value: last_visited_detail_end_date(c[:frequency_id]), dateFormat: 'm-d-Y'}
      ]
    )
  end
  
  def last_visited_detail_end_date(freq_id)
    VisitFrequency.find(freq_id).last_visited_detail_end_date if freq_id.present?
  end
end
