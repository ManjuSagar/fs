class StaffingCompanyForm < Mahaswami::FormPanel

  def configuration
    super.merge(
        cityStatePrefill: true,
        notify_on_save: false,
        model: "StaffingCompany",
        style: 'text-align: right; margin: 10px',
        items: [
          {
              width: "70%",
              border: false,
              layout: :hbox,
              style: 'text-align: right; margin: 10px',
              items: [{name: :org_name, flex: 1, field_label: 'Name', emptyText: 'Name', label_width: 65}]
          },
          {
            border: false,
            layout: :hbox,
            style: 'text-align: right; margin: 10px',
            items: [
                {name: :street_address, field_label: 'Address', emptyText: 'Street Address', flex: 4, label_width: 65, margin: "0 5px 0 0"},
                {name: :suite_number, field_label: '', emptyText: 'Suite #', flex: 1}
            ]
          },{
              border: false,
              layout: :hbox,
              style: 'text-align: right; margin: 10px',
              items: [
                  {name: :zip_code, field_label: 'Location', allow_blank: false,  flex: 1, emptyText: 'ZIP Code', label_width: 65, margin: "0 5px 0 0"},
                  {name: :city, field_label: '', flex: 1, emptyText: 'City', label_width: 65, margin: "0 5px 0 0"},
                  {name: :state, field_label: '', xtype: 'combo', flex: 1, emptyText: 'State', label_width: 65,
                   store: State.all.collect{|x|[x.state_code, x.state_description]}},
              ]
          },{
            border: false,
            layout: :hbox,
            style: 'text-align: right; margin: 10px',
            items: [
                {name: :email, field_label: 'Details', allow_blank: false,  flex: 1.7, emptyText: 'Email', label_width: 65, margin: "0 5px 0 0"},
                {name: :fed_tax_number, field_label: '', input_mask: '999999999', flex: 0.5, emptyText: 'Fed Tax Number', label_width: 65, margin: "0 5px 0 0"},
                {name: :npi_number, field_label: '', flex: 0.5, emptyText: 'NPI #', label_width: 65 }
            ]
          },{
              title: "Primary Contact & Admin User Information",
              width: "70%",
              border: false,
              layout: :hbox,
              style: 'text-align: right; margin: 10px',
              bodyStyle: 'padding-top: 10px',
              items: [
                  {name: :primary_contact_first_name, field_label: 'Name', emptyText: 'First Name', allow_blank: false, label_width: 65, flex: 5, margin: "0 5px 0 0"},
                  {name: :primary_contact_last_name, field_label: ' ', label_separator: '', allow_blank: false, label_width: 5, emptyText: 'Last Name', flex: 4},
              ]
          },
          {
            border: false,
            layout: :hbox,
            style: 'text-align: right; margin: 10px',
            items: [
              {name: :primary_contact_email, field_label: 'Contact', emptyText: 'Email', allow_blank: false, flex: 1.7, label_width: 65, margin: "0 5px 0 0"},
              {name: :primary_contact_phone_number, field_label: '', input_mask: '(999) 999-9999', allow_blank: false, flex: 0.5, emptyText: 'Phone Number', label_width: 65, margin: "0 5px 0 0"},
              {name: :primary_contact_extension, field_label: '', flex: 0.5, emptyText: 'Extn.', label_width: 65},
            ]
          }
        ]
    )
  end

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      var formScope = this;
      this.on('submitsuccess', function() {
        var w = new Ext.window.Window({
            width: "40%",
            height: "80%",
            modal: true,
            layout:'fit',
            buttons: [
              {
                text: "Close",
                listeners: {
                  click: function(){formScope.addScContractsAndFieldStaff(); w.close();}
                }
              }
            ],
            title: "Contracts",
          }, this);
          w.show();
          w.on('close', function(){
            formScope.addScContractsAndFieldStaff();
          }, this);
          this.loadNetzkeComponent({name: "staffing_company_contracts", params: {component_params: {staffing_company_id: this.getValues().id,
          parent_id: this.getValues().id, strong_default_attrs: {org_id: this.getValues().id} }},
          container:w, callback: function(w){
            w.show();
          }});
        return false;
      }, this);
    }
  JS

  js_method :add_sc_contracts_and_field_staff,<<-JS
    function(){
      var formScope = this;
      Ext.MessageBox.confirm('Confirm', 'Do you wish to create a Field Staff for this Staffing Company?', function(result){
        if (result == "yes") {
          var w = new Ext.window.Window({
            width: "40%",
            height: "80%",
            modal: true,
            layout:'fit',
            buttons: [
              {
                text: "Close",
                listeners: {
                  click: function(){ w.close();}
                }
              }
            ],
            title: "Field Staffs",
          }, this);
           w.on('close', function(){
            formScope.getParentNetzkeComponent().closeRes = "ok";
            formScope.getParentNetzkeComponent().close();
            formScope.close();
          }, this);
          w.show();
          this.loadNetzkeComponent({name: 'sc_field_staff_list', params: {component_params: {staffing_company_id: this.getValues().id,
              parent_id: this.getValues().id, strong_default_attrs: {org_id: this.getValues().id} }}, container: w}, this);
        }else{
          formScope.getParentNetzkeComponent().closeRes = "ok";
          formScope.getParentNetzkeComponent().close();
        }
      }, this);
    }
  JS

  component :staffing_company_contracts do
    {
        class_name: "StaffingCompanyContracts",
        item_id: :staffing_company_contracts_grid,
        auto_scroll: true,
        enable_pagination: false,
        header: false,
        title: false,
    }
  end

  component :sc_field_staff_list do
    {
        class_name: "ScFieldStaffList",
        item_id: :Staffing_company_field_Staffs_grid,
        enable_pagination: false,
        header: false,
        title: false,
        auto_scroll: true
    }
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end

end