class UnlockReasons < Mahaswami::Panel
  def configuration
    s = super
    doc = Document.find(s[:document_id])
    s.merge(
      header: false,
      autoScroll: true,
      items: [
          {
              xtype: 'radiogroup',
              fieldLabel: "Specify the type of correction to be made",
              name: 'correction_unlock_reason',
              labelStyle: "font-weight:bold",
              labelAlign: 'top',
              columns: 1,
              margin: "10 5",
              items: [
                  {
                      xtype: 'radiofield',
                      name: "unlock_reason",
                      inputValue: "4",
                      margin: 5,
                      boxLabel: 'Assessment was submitted to the state and rejected.',
                      checked: true

                  },
                  {
                      xtype: 'radiofield',
                      name: "unlock_reason",
                      inputValue: "2",
                      margin: 5,
                      boxLabel: 'Assessment was submitted to the state and was accepted. Inactivation of the assessment is necessary.'
                  },
                  {
                      xtype: 'radiofield',
                      name: "unlock_reason",
                      inputValue: "3",
                      margin: 5,
                      boxLabel: 'Assessment was submitted to the state and was accepted. Correction to non-key fields is necessary.'
                  }]+
                  ((doc.display_clinical_fields? and doc.document_type == 'OasisEvaluation') ? [{
                      xtype: 'radiofield',
                      name: "unlock_reason",
                      inputValue: "5",
                      margin: 5,
                      boxLabel: 'Assessment was submitted to the state and was accepted. Correction to clinical fields is necessary.'
                  }] : [])+
                  [{
                  xtype: 'label',
                  text: '(Key Fields: M0030, M0032, M0040, M0064, M0066, M0069, M0090, M0100, M0906)'
                  }

              ]
          }

      ],
      bbar: ['->', :ok.action, :cancel.action]
    ).merge(s[:params])
  end

  action :ok, text: "", tooltip: "OK", icon: :save_new
  action :cancel, text: "", tooltip: "Cancel", icon: :cancel_new

  js_method :on_ok, <<-JS
    function(){
      var reason = this.down('[name=correction_unlock_reason]').getValue().unlock_reason;
      this.updateReason({reason: reason}, function(result){
        var window = this.up("window");
        window.closeRes = "ok";
        this.close();
        window.close();
      },this);
    }
  JS

  endpoint :update_reason do |params|
    doc = Document.org_scope.find(config[:document_id])
    doc.set_unlock_reason(params[:reason])
    {:set_result => true}
  end

  js_method :on_cancel,<<-JS
    function(){
      var window = this.up('window');
      window.close();
    }
  JS
end