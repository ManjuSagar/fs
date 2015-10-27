class TreatmentPhysicianForm <  Mahaswami::FormPanel
  def configuration
    super.merge(
        title: "Physicians",
        model: "TreatmentPhysician",
        item_id: 'save',
        items: [
            {
                border: false,
                layout: 'hbox',
                items: [
                    {name: :physician__full_name, field_label: "Physician", editable: false, width: "10%", flex: 1, margin: '0 5 0 0' },
                    {xtype: 'button', text: 'Add New Physician', item_id: 'add_physician', cls: 'blue-color-button' }
                ]},
            {name: :primary_referral_flag, field_label: "Primary Physician?", editable: false, width: "10%"},
            {name: :require_cc_flag, field_label: "Require CC?", editable: false, width: "18%"}
        ]
    )
  end


  def physician__full_name_combobox_options(params)
    values = Physician.physician_agency_specific.collect{|x| [x.id, x.full_name]}
    {:data => values}
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
       var addPhy = Ext.ComponentQuery.query('#add_physician')[0]
          addPhy.on('click', function() {
            this.formDisplayComponent();
          }, this);
    }
  JS


  js_method :form_display_component, <<-JS
  function() {
    var w = new Ext.window.Window({
      width: '50%',
      modal: true,
      border: false,
      layout:'fit',
      title: "Add Physician",
      buttons: [
        {
          text: "", tooltip: "OK", iconCls: "ok_icon",
             listeners: {
                click: function(){
                  var form = Ext.ComponentQuery.query('#physician_form')[0];
                  form.on("submitsuccess", function(){
                    w.closeRes = "ok";
                    this.close();
                }, w);
                form.onApply();
                }
             }
        },
        {
          text: "", tooltip: "Cancel", iconCls: "cancel_icon", listeners: { click: function() {w.close();} }
        }
      ]

    });
    w.show();
    this.loadNetzkeComponent({name: "add_physician_form", container:w, callback: function(w){
      w.show();
    }});
  }
  JS

  component :add_physician_form do
    {
        class_name: "PhysicianForm",
        header: false,
        lazy_loading: true,
        bbar: false
    }
  end

end