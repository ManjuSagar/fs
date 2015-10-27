class ErrorList < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge(
        header: false,
        model: "User",
        editOnDblClick: false,
        bbar: false,
        context_menu: false,
        columns: [
            {
                id:'row_num',
                header: 'Record #',
                width: 100,
                name: "row_num",
                sortable: true,
                dataIndex: 'row_num',
                tdCls: 'wrap'
            },{
                id: 'msg',
                name: 'msg',
                header: 'Error Message',
                flex: 1,
                sortable: true,
                dataIndex: 'msg',
                tdCls: 'wrap'
            }
        ],
        errors: s[:errors],
        layout:'fit',
        viewConfig: {forceFit: true}
    )
  end

  def get_data(*args)
    res = {}
    errors = config[:errors]
    new_errors_list = []
    errors.each_with_index do |error, index|
      new_errors_list << [nil] + error
    end
    res[:data] = new_errors_list
    res[:total] = new_errors_list.size
    res
  end

end