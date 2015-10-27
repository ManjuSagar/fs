class VisitTypesExplorer < Mahaswami::Panel

  def configuration
    s = super
    component_session[:visit_type_status_arr] ||= ['A']
    s.merge({
                title: "Visits",
                layout: :border,
                item_id: :visits_list_explorer,
                items: [
                    :search_panel.component,
                    :visit_types_list.component
                ]
            })
  end

  component :search_panel do
    {
        class_name: "Mahaswami::Panel",
        region: :north,
        border: false,
        header: false,
        layout: :hbox,
        items: [
            {
                class_name: "VisitTypesFilter",
                border: false,
                header: false,
                item_id: :visit_types_filter,
                flex: 1,
                visit_type_status_arr: component_session[:visit_type_status_arr]
            },
            {
                class_name: "VisitTypesButtons",
                flex: 1,
                border: false,
                header: false
            }
        ]
    }
  end

  component :visit_types_list do
    {
        class_name: "VisitTypes",
        item_id: :visit_types,
        region: :center,
        border: true,
        header: false,
        scope: visit_types_scope(component_session[:visit_type_status_arr])
    }
  end

  def visit_types_scope(visit_type_status_arr)
    visit_type_status_arr = (visit_type_status_arr and visit_type_status_arr.include?("display_none"))? [] : visit_type_status_arr
    visit_types_scope = ['A'] if visit_type_status_arr.nil?
    #Its patch added for scope: it will skip word 'scope_with_params' and uses filter_based_on_treatment_status as scope name
    # and remaining items as parameters
    ["scope_with_params,filter_based_on_visit_type_status"] + visit_type_status_arr
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      checkBoxList = this.down("#visit_types_filter").query("checkboxfield");
      Ext.each(checkBoxList, function(checkBox, index){
        checkBox.on('change', function(ele){
          var visitTypeStatus = checkBox.up('checkboxgroup').getValue().visit_type_status;
          this.setVisitTypeStatus({visit_type_status: visitTypeStatus});
        }, this);
      }, this);
    }
  JS

  endpoint :set_visit_type_status do |params|
    visit_type_status_arr = if params[:visit_type_status].nil?
                             ["display_none"]
                           elsif params[:visit_type_status].is_a? String
                             [params[:visit_type_status]]
                           else
                             params[:visit_type_status]
                           end
    component_session[:visit_type_status_arr] = visit_type_status_arr
    {refresh_grids: true}
  end

  js_method :refresh_grids,<<-JS
    function(){
      this.down("#visit_types").store.load();
    }
  JS

end