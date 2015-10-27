class Icd9Code < Mahaswami::FormPanel

  def configuration
    s = super
    s.merge(
         model: 'ProspectivePaymentSystem::Icd9DiagnosticCode',
         header: false,
         bbar: false,
         border: false,
         bodyStyle: {border_width: 0},
         items: [{
              xtype: 'netzkeremotecombo',
              width: 450,
              parent_id: self.global_id,
              name: 'icd_code',
              field_label: '',
              emptyText: 'Enter ICD9 Code',
              item_id: "icd_9_code",
              margin: '9 0 3px 5px',
      }]
    )
  end

  js_method :on_apply, <<-JS
    function(){
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      var icd9 = Ext.ComponentQuery.query('#icd_9_code')[0];
      icd9.store.on('load', function(){
        icd9.store.removeAt(0);
      });
    }
  JS

  def get_combobox_options_endpoint(params)
    OasisEvaluation.netzke_combo_options_for(params[:column], {query: params["query"]})
  end
end