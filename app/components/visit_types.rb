class VisitTypes < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge(
        model: 'VisitType',
        title: 'Visits',
        item_id: :visit_types,
        columns: [{name: :visit_type_code, label: "Code", editable: false, width: "15%"},
                  {name: :visit_type_description, label: "Description", editable: false, width: "30%"},
                  {name: :discipline__discipline_description, label: "Discipline", editable: false, width: "20%"},
                  {name: :optional_flag, label: "Optional?", editable: false, width: "10%"},
                  {name: :formatted_payable_rate, label: "Payable Rates", align: 'right', editable: false},
                  {name: :visit_type_status, label: "Status", align: 'right', editable: false, getter: lambda {|v| v.visit_type_status.to_s.titleize}},
                   action_column("visit_types")
        ],
        scope: (s[:scope] ?  s[:scope] : :org_scope),
        edit_form_window_config: {width: "50%", height: "80%"},
        add_form_window_config: {width: "50%", height: "60%"}
    )
  end

  def default_bbar
    ""
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action]
  end


  action :add_in_form, text: "", tooltip: "Add Visit Type"
  add_form_config class_name: "VisitTypeForm"
  action :edit_in_form, text: "", tooltip: "Edit Visit Type"
  edit_form_config class_name: "VisitTypeEditForm"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
        this.selectRecord({visit_type_id: record.get('id')});
      }, this);
    }
  JS

  endpoint :select_record do |params|
    session[:selected_visit_type_id] = params[:visit_type_id]
  end
end
