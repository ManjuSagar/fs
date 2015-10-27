class PayableForm < Mahaswami::FormPanel

  def configuration
    super.merge(
        model: "Payable",
        items: [
            {name: :payee__full_name, item_id: :payee_id, field_label: "Payee", defaultIfSingleItem: false},
            {name: :payable_type, width: 165, editable: false, xtype: 'combo', store: Payable::PAYABLE_TYPES},
            {name: :purpose, width: 165},
            {name: :payable_amount, label: "Amount", width: 165}
        ]
    )
  end
  
  def payee__full_name_combobox_options(params)
    users = Org.current.users - [User.current]
	users.collect!{|x| ["#{x.class.name}_#{x.id}", x.full_name]}
	{:data => users}  
  end  

end
