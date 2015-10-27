class PendingPayrollsButtons < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
        {
            border: false,
            header: false,
            tbar: [:apply.action,
                   "->",
                   "->", {name: :total_number_of_items, field_label: "Visits ", xtype: :displayfield, label_width: 40, value: total_visits, item_id: :total_items_selected},
                   {name: :total_amount_to_pay, field_label: "Total ", xtype: :displayfield, label_width: 40, value: "$ #{total_count}", item_id: :total_amount_to_pay},
                   :process.action,
                   :print_selected_payrolls.action,
                   :clear_all.action]
        }
    )
  end

  def total_count
    Payable.items_in_queue.map(&:adjusted_rate).sum
  end

  def total_visits
    Payable.items_in_queue.size
  end

  action :apply, text: "", icon: :save_new
  action :process, text: "Process"
  action :print_selected_payrolls, text: "", tooltip: "Print Payrolls", icon: :print
  action :clear_all, text: "Clear"

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      this.explorer = this.up("#payable_list_explorer");
      this.unpaid = this.explorer.down("#unpaid_payable_lst");
      this.needToPay = this.explorer.down("#need_to_pay_payable_lst");
      this.needToPay.store.on('load', function(s, records, successful, eOpts ){
        this.updateTotalSelectedAndAmount({}, function(res){
          this.down("#total_amount_to_pay").setValue("$ " + res[1]);
          this.down("#total_items_selected").setValue(res[0]);
        }, this);
      }, this);
    }
  JS

  endpoint :update_total_selected_and_amount do |params|
    payables = Payable.items_in_queue
    arr = [payables.size, payables.map(&:adjusted_rate).sum]
    {:set_result => arr}
  end

  js_method :on_apply,<<-JS
    function(){
      this.unpaid.onApply();
      this.needToPay.onApply();
    }
  JS

  js_method :on_process,<<-JS
    function(){
      this.needToPay.onProcess();
    }
  JS

  js_method :on_print_selected_payrolls,<<-JS
    function(){
      this.needToPay.onPrintSelectedPayrolls();
    }
  JS

  js_method :on_clear_all,<<-JS
    function(){
      this.needToPay.onClearAll();
    }
  JS
end