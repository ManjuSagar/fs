class AuditDetails < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge(
      model: "Audit",
      title: "Details",
      editOnDblClick: false,
      columns:[
          {name: :field, label: "Field", editable: false},
          {name: :old_value, label: "Old Value", editable: false},
          {name: :new_value, label: "New Value", editable: false}
      ]
    )
  end

  def default_bbar
    []
  end

  def default_context_menu
    []
  end

  def get_data(*args)
    res = {}
    start, limit = if args.empty?
                     [0, 30]
                   else
                     [args[0][:start].to_i, (args[0][:page].to_i * args[0][:limit].to_i) - 1]
                   end
    res[:data] = config[:audit_id] ? Audit.get_data(config[:audit_id])[start..limit]: []
    res[:total] = res[:data].size
    res
  end

end