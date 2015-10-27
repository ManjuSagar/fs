class FilterAndSearchPanel < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
      layout: :hbox,
      items: search_items_based_on_context(s[:context])
    )
  end

  def search_items_based_on_context(context = "pending_payrolls")
    items = if context == "processed_payrolls"
      [item("Paid Date:", "payroll")].flatten
    elsif context == "active_patients"
      [item("SOC Date:", "soc")].flatten
    else
      [item("Date:", "activity"), item("Submitted:", "submission")].flatten
    end
    items << {margin: '0 5 5 5', xtype: :button, itemId: :apply_filter, text: "", icon: "/assets/icons/save_new.png"}
    items
  end

  def item(label_text, name, type = :datefield)
    from_name = "#{name}_from_date".to_sym
    to_name = "#{name}_to_date".to_sym
    [
        {xtype: :label, text: label_text, width: 70, margin: '3 5 5 5'},
        {name: from_name, item_id: from_name, xtype: type, field_label: "From", label_align: :right, margin: '0 5 5 5', label_width: 40},
        {name: from_name, item_id: to_name, xtype: type, field_label: "To", label_align: :right, margin: '0 5 5 5', label_width: 40}
    ]
  end

end