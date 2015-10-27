class InsCompVisitRateList < Mahaswami::HasManyCollectionList

  def configuration
    c = super
    
    c.merge(
      model: 'InsuranceCompanyVisitTypeRate',
      title: 'Billable Rates',
      editOnDblClick: false,
      infinite_scroll: false,
      enable_pagination: false,
      columns: [
        {name: :visit_type__visit_type_display, label: "Visit Type", width: "25%", editable: false, scope: :org_scope},
        {name: :external_visit_type_code, label: "External Visit Code", width: "12%"},
        {name: :hcpcs_code, field_label: "HCPCS Code"},
        {name: :revenue_code, field_label: "Revenue Code"},
        {name: :visit_rate, label: "Visit Rate", width: "14%", align: 'right', renderer: :render_rate, editable: true},
        {name: :hourly_rate, label: "Hourly Rate", width: "15%", align: 'right', renderer: :render_rate, editable: true}
      ],
      scope: c[:scope].merge({:org_id => Org.current.id}),
      strong_default_attrs: {:org_id => Org.current.id}.merge(c[:strong_default_attrs])
    )
  end

  def default_bbar
    [:edit.action, :apply.action]
  end

  def default_context_menu
    [:edit.action, :apply.action]
  end
  
  js_method :init_component, <<-JS
    function(){
      this.callParent();
    }    
  JS

  js_method :render_rate,<<-JS
    function(value){
      return value.toFixed(2);
    }
  JS

end
