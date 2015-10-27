class Payrolls < Mahaswami::Panel
    
  def configuration
    c = super
    c.merge(
      layout: {type: 'border'},
      header: false,
      items: [
        :payrolls.component,
        :payroll_details.component
      ]
    )
  end
    
  component :payrolls do
    {
       region: :west,
       width: "65%",
       class_name: "PayrollList",
       item_id: :payroll_grid,
       auto_scroll: true,
       scope: config[:scope]
    }
  end
   
  component :payroll_details do
    {
       region: :center,
       class_name: "PayrollDetails",
       item_id: :payroll_details_grid,
       auto_scroll: true,
       scope: (component_session[:payroll_id].nil? ? {:payroll_id => 0} : {:payroll_id => component_session[:payroll_id]}),
    }
  end
  
 js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.resetSessionContext({}, function(){
        //this.down('#payroll_details_grid').store.load();
      });

      this.down('#payroll_grid').on('itemclick',function(view, record){
        this.setPayrollId({payroll_id : record.get('id')}, function(result){
          this.down('#payroll_details_grid').store.load();
        }, this);
      }, this);
    }    
  JS
  
  endpoint :reset_session_context do |params|
    payroll = if User.current.office_staff?
                Org.current.payrolls.first
              else
                User.current.payrolls.first
              end
    component_session[:payroll_id] = payroll ? payroll.id : nil
    {:set_result => true}
  end
  
  endpoint :set_payroll_id do |params|
    component_session[:payroll_id] = params[:payroll_id]
    {:set_result => true}
  end
end
