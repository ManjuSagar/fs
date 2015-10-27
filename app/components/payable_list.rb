class PayableList < Mahaswami::GridPanel
  
  def configuration
    c = super
      c.merge(
      auto_scroll: true,
      model: 'Payable',
      editOnDblClick: false,
      infinite_scroll: false,
      enable_pagination: false,
      bbar: (c[:bbar] ? c[:bbar] : []),
      columns: [{name: :field_staff_name, editable: false, width: "10%", label: "Field Staff", addHeaderFilter: true},
                {name: :staff_type, editable: false, label: "Staff Type", width: "10%", filter1: {xtype: 'combo', store: [["", "---"], ["User", "Field Staff"], ["Org", "Staffing Company"]]}},
                {name: :treatment__to_s, label: "Patient", editable: false, width: "10%", addHeaderFilter: true},
                {name: :purpose, editable: false, label: "Visit", width: "7%", addHeaderFilter: true},
                {name: :visit_date, editable: false, label: "Date", width: "8%", addHeaderFilter: true},
                {name: :submission_date, label: "Submitted", editable: false, width: "8%", addHeaderFilter: true},
                {name: :current_status, label: "Status", editable: false, width: "8%", filter1: {xtype: "combo", store: [["", "---"], ["F,S", "Pending Staff"], ["P", "Pending Agency"], ["C", "Completed"]]}},
                {name: :no_of_units, label: "#", editable: false, width: "3%"},
                {name: :units_display, label: "Unit", editable: false, width: "5%"},
                {name: :rate, lable: "Rate", editable: false, width: "6%", renderer: :adjusted_rate_format },
                {name: :payable_amount, header: "Total", editable: false, width: "6%", renderer: :adjusted_rate_format },
                {name: :adjusted_rate, align: "right", label: "Adjustment", renderer: :adjusted_rate_format, width: "9%"},
                action_column(c[:item_id], c[:action_column_width])
                ],
                scope: (c[:scope].nil? ? :org_scope : c[:scope])
    )
  end

  js_method :adjusted_rate_format,<<-JS
    function(value){
      return value.toFixed(2);
    }
  JS

  action :apply, text: "", icon: :save_new
  action :process, text: "Process"
  action :print_selected_payrolls, text: "", tooltip: "Print Payrolls", icon: :print
  action :clear_all, text: "Clear"

  js_method :on_process,<<-JS
    function(){
      if (this.store.getCount() > 0) {
        this.createPayroll({}, function(res){
          var explorer = this.up("#payable_list_explorer");
          var needToPayStore = explorer.down("#need_to_pay_payable_lst").store;
          needToPayStore.load();
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        }, this);
      } else {
        Ext.MessageBox.alert("Status", "No payrolls to process.");
      }
    }
  JS

  js_method :perform_action, <<-JS
      function(record_id, action) {
        if(action == "process"){
          this.processPayable({record_id: record_id, action: action}, function(res){
          if(res){
            record = this.store.getById(record_id);
            this.store.remove(record);
            record.data.actions = record.data.actions.replace("process", "un_process");
            record.data.actions = record.data.actions.replace("Pay", "Remove");
            needToPayStore = Ext.ComponentQuery.query("#need_to_pay_payable_lst")[0].store;
            needToPayStore.add(record);
          }
        }, this);
        }else{
          this.triggerEvent({record_id: record_id, action: action});
        }
      }
  JS

  def current_record(record_id)
    self.config[:model].constantize.find(record_id)
  end

  endpoint :process_payable do |params|
    current_record(params[:record_id]).send("#{params[:action]}!".to_sym)
    {:set_result => true}
  end

  js_method :on_print_selected_payrolls,<<-JS
    function(){
      if (this.store.getCount() > 0) {
        this.createPayroll({print_only: true}, function(res){
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        });

      } else {
        Ext.MessageBox.alert("Status", "No payrolls to print.");
      }
    }
  JS

  js_method :on_clear_all,<<-JS
    function(){
      if (this.store.getCount() > 0) {
        this.removePayrollsFromReadyToPay({}, function(){
          this.refreshData();
        }, this);
      } else {
        Ext.MessageBox.alert("Status", "No payrolls to clear.");
      }
    }
  JS

  component :launch_report do
    {
        class_name: "LaunchReport",
        width: '60%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

  add_form_config class_name: "PayableForm", mode: :add

  def human_action_name(event)
    if event == :process
      "Pay"
    elsif event == :un_process
      "Remove"
    else
      event.titleize
    end
  end

  js_method :refresh_data,<<-JS
    function(){
      var explorer = this.up("#payable_list_explorer");
      explorer.down("#unpaid_payable_lst").store.load();
      var needToPayStore = explorer.down("#need_to_pay_payable_lst").store;
      needToPayStore.load();
    }
  JS

  class PayrollPrintException < Exception
    def message
      "This exception is raised here. Since we need preview of payrolls without processing."
    end
  end

  endpoint :create_payroll do |params|
    result = false
    payroll_ids = []
    begin
      ActiveRecord::Base.transaction do
        payroll_ids = Payroll.create_payrolls
        payrolls = payroll_ids.collect{|id| Org.current.payrolls.find(id)}
        payroll = payrolls.first
        payroll.actual_payroll_ids = payroll_ids
        session[:pre_generated_file_name] = payroll.combine_payroll_summary_and_individual_details
        #HACK: PayrollPrintException exception is raised here. Since we need preview of payrolls without processing.
        raise PayrollPrintException if params[:print_only]
        {:set_result => true}
      end
    rescue PayrollPrintException
      {:set_result => true} if params[:print_only]
    end
  end

  endpoint :remove_payrolls_from_ready_to_pay do |params|
    Payable.items_in_queue.each{|p| p.un_process! if p.may_un_process? }
    {}
  end


end