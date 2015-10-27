class VerifyUserAuthentication < Mahaswami::Panel

  def configuration
    super.merge(
      header: false,
      items: [
          {name: :sign_date, field_label: "Date", xtype: :datefield, margin: 10, item_id: :sign_date, format: 'm/d/Y', value: Date.current},
          {name: :sign_password, field_label: "Sign Password:<span style='color:red;'>*</span>", label_separator: '', xtype: :textfield, inputType: :password, item_id: :sign_password, margin: 10}
      ],
      bbar: ['->', :ok.action, :cancel.action]
    )
  end

  action :ok, text: "", tooltip: "OK", icon: :save_new
  action :cancel, text: "", tooltip: "Cancel", icon: :cancel_new

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      var formScope = this;
      Ext.each(this.items.items, function(item, index){
        item.enableKeyEvents = true;
        item.on('keydown', function(field, e, options){
          if(e.keyCode == 13){
            formScope.onOk();
          }
        }, this);
      });
    }
  JS

  js_method :on_ok,<<-JS
    function(){
      var date = this.down('#sign_date').value;
      var password = this.down('#sign_password').value;
      if(date != null && password != null){
        this.verifyUserSignPassword({date: date, password: password}, function(result1){
          if(result1){
            this.setSignDate({date: date}, function(result2){
              if(result2){
                this.signRes = true;
              }else{
                this.signRes = false;
              }
              this.close();
            }, this);
          }
          else
            Ext.MessageBox.alert("Status", "Invalid Password. Please try again.");
        }, this);
      }
      else if(date == null && password != null)
        Ext.MessageBox.alert("Status", "Invalid Date. Please try again.");
      else if(date != null && password == null)
        Ext.MessageBox.alert("Status", "Invalid Password. Please try again.");
      else
        Ext.MessageBox.alert("Status", "Invalid Date and Password. Please try again.");
    }
  JS

  endpoint :verify_user_sign_password do |params|
    result = false
    result = User.current.valid_sign_password?(params[:password])
    {:set_result => result}
  end

  endpoint :set_sign_date do |params|
    record_instance = config[:record_klass].constantize.find(config[:record_id])
    result = record_instance.set_sign_date(params[:date].to_date)
    {:set_result => result}
  end

  js_method :on_cancel,<<-JS
    function(){
      this.signRes = false;
      this.up('window').close();
      this.close();
    }
  JS

end