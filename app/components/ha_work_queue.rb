class HaWorkQueue < Mahaswami::GridPanel
  include ToDoListHelper
  def configuration
    super.merge(
        {
            model: "Org", #Org model is used since grid panel requires model name, but model is not required for this grid
            title: "To Do",
            edit_on_dbl_click: false,
            sortable: false,
            item_id: :ha_work_queue,
            infinite_scroll: false,
            enable_pagination: false,
            rowsPerPage: 5000,
            columns: [
                {name: :record_type, hidden: true},
                {name: :action_type, hidden: true},
                {name: :item_date, label: "Date", xtype: :datecolumn, editable: false},
                {name: :category, width: "12%", filter1: {xtype: 'combo', store: ["---", "Visit", "Document", "Communication", "Order"]}},
                {name: :field_staff, label: "Field Staff", width: "15%", addHeaderFilter: true},
                {name: :patient, width: "13%", addHeaderFilter: true},
                {name: :item_description, label: "Description", width: "20%", addHeaderFilter: true},
                {name: :action_required, label: "Pending", width: "15%", addHeaderFilter: true},
                {name: :aging, addHeaderFilter: true}
            ]
        }
    )
  end

  js_method :add_row_color, <<-JS
    function(){
      Ext.each(this.store.data.items, function(item, index){
				if (item.data.aging > 5){
					$('#app__ha_work_queue-body tr:nth-child(' + (index + 1) + ')')[0].style.color = 'red';
				}
			});
		}
  JS

  def default_bbar
    []
  end

  def default_context_menu
    []
  end

  def get_data(*args)
    res = {}
    start, limit, filter = if args.empty?
                     [0, 30, nil]
                   else
                     [args[0][:start].to_i, (args[0][:page].to_i * args[0][:limit].to_i) - 1, args[0][:filter1]]
                   end
    work_queues = HealthAgencyWorkQueue.data(User.current, filter)
    res[:data] = work_queues #[start..limit]
    res[:total] = work_queues.size
    res
  end

end