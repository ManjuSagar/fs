class PendingPayrolls < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
      title: "Pending",
      layout: :border,
      items: [
        :search_panel.component,
        :payable_list_explorer.component
      ]
    )
  end

  component :search_panel do
    {
      class_name: "FilterAndSearchPanel",
      region: :north,
      xtype: :fieldset,
      margin: 5,
      title: "Filter"
    }
  end

  component :payable_list_explorer do
    {
        class_name: "PayableListExplorer",
        region: :center,
        margin: 5,
        header: false,
        scope: payable_scope(component_session[:scope])
    }
  end

  def payable_scope(scope)
    return :not_in_queue if scope.nil?
    if scope.empty?
      return :not_in_queue
    else
      sql_string = ["org_id = #{Org.current.id} AND payable_status = 'U' AND " + scope[0]]
      args = scope - [scope[0]]
      return sql_string + args
    end
  end

  js_method :init_component,<<-JS
    function(){
      this.resetSessionContext();
      this.callParent();
      this.down('#apply_filter').on('click', function( ele, e, eOpts){
        var activityFromDate = this.down('#activity_from_date').value;
        var activityToDate = this.down('#activity_to_date').value;
        var submissionFromDate = this.down('#submission_from_date').value;
        var submissionToDate = this.down('#submission_to_date').value;
        var canSend = false;
        if(activityFromDate != null && activityToDate != null && submissionFromDate == null && submissionToDate == null){
          canSend = true;
        } else if(activityFromDate == null && activityToDate == null && submissionFromDate != null && submissionToDate != null){
          canSend = true;
        } else if(activityFromDate != null && activityToDate != null && submissionFromDate != null && submissionToDate != null){
          canSend = true;
        } else if(activityFromDate == null && activityToDate == null && submissionFromDate == null && submissionToDate == null){
          canSend = true;
        }
        if(canSend){
          this.filterPendingPayrolls({activity_from_date: activityFromDate, activity_to_date: activityToDate,
                                  submission_from_date: submissionFromDate, submission_to_date: submissionToDate}, function(){
            this.down('#unpaid_payable_lst').store.load();
          }, this);
        }else{
          Ext.MessageBox.alert("Status", "Both <b>From</b> and <b>To</b> dates are required to filter.");
        }
      }, this);
    }
  JS

  endpoint :reset_session_context do |params|
    component_session[:scope] = nil
    total_number_of_pending_payrolls = Org.current.payables.unpaid_payables.size
    {}
  end

  endpoint :filter_pending_payrolls do |params|
    sql_string = ""
    args = []
    if params[:activity_from_date] and params[:activity_to_date]
      sql_string += "date(visit_date) BETWEEN ? AND ?"
      args << params[:activity_from_date]
      args << params[:activity_to_date]
    end
    if params[:submission_from_date] and params[:submission_to_date]
      sql_string += "AND " unless sql_string.empty?
      sql_string += "date(submission_date) BETWEEN ? AND ?"
      args << params[:submission_from_date]
      args << params[:submission_to_date]
    end
    component_session[:scope] = sql_string.empty?? [] : ["#{sql_string}"] + args
    {}
  end

end