class PayableListExplorer < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
        layout: :border,
        item_id: :payable_list_explorer,
        items: [
            :pending_payrolls_buttons.component,
            :unpaid_payable_lst.component,
            :need_to_pay_payable_lst.component
        ]
    )
  end

  component :pending_payrolls_buttons do
    {
        class_name: "PendingPayrollsButtons",
        region: :south,
        height: 35
    }
  end

  component :unpaid_payable_lst do
    {
        class_name: "PayableList",
        region: :north,
        item_id: :unpaid_payable_lst,
        bbar: [],
        height: "50%",
        margin: '0 0 5 0',
        action_column_width: 50,
        header: false,
        scope: config[:scope]
    }
  end

  component :need_to_pay_payable_lst do
    {
        class_name: "PayableList",
        region: :center,
        item_id: :need_to_pay_payable_lst,
        bbar: [],
        action_column_width: 86,
        scope: :items_in_queue,
        title: "To Pay",
        bbar: []
    }
  end

end