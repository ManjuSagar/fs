class ProcessedPayrolls < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
      title: "History",
      layout: :border,
      items: [
          :search_panel.component,
          :payroll_list.component
      ]
    )
  end

  component :search_panel do
    {
        class_name: "FilterAndSearchPanel",
        region: :north,
        xtype: :fieldset,
        margin: 5,
        title: "Filter",
        context: "processed_payrolls"
    }
  end

  component :payroll_list do
    {
        class_name: "Payrolls",
        region: :center,
        margin: 5,
        header: false,
        scope: payroll_scope(component_session[:scope])
    }
  end

  def payroll_scope(scope)
    return :org_scope if scope.nil?
    if scope.empty?
      return :org_scope
    else
      sql_string = ["org_id = #{Org.current.id} AND " + scope[0]]
      args = scope - [scope[0]]
      return sql_string + args
    end
  end

  js_method :init_component,<<-JS
    function(){
      this.resetSessionContext();
      this.callParent();
      this.down('#apply_filter').on('click', function( ele, e, eOpts){
        var payrollFromDate = this.down('#payroll_from_date').value;
        var payrollToDate = this.down('#payroll_to_date').value;
        var canSend = false;
        if(payrollFromDate != null && payrollToDate != null){
          canSend = true;
        } else if(payrollFromDate == null && payrollToDate == null){
          canSend = true;
        }
        if(canSend){
            this.filterProcessedPayrolls({payroll_from_date: payrollFromDate, payroll_to_date: payrollToDate}, function(){
              this.down('#payroll_grid').store.load();
            }, this);
        }else{
          Ext.MessageBox.alert("Status", "Both <b>From</b> and <b>To</b> dates are required to filter.");
        }
      }, this);
    }
  JS

  endpoint :reset_session_context do |params|
    component_session[:scope] = nil
    {}
  end

  endpoint :filter_processed_payrolls do |params|
    sql_string = ""
    args = []
    if params[:payroll_from_date] and params[:payroll_to_date]
      sql_string += "date(payroll_date) BETWEEN ? AND ?"
      args << params[:payroll_from_date]
      args << params[:payroll_to_date]
    end
    component_session[:scope] = sql_string.empty?? [] : ["#{sql_string}"] + args
    {}
  end

end