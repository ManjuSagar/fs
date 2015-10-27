class StaffingCompanyEditForm < Mahaswami::FormPanel

  def configuration
    c = super
    component_session[:org_id] = c[:record_id] if c[:record_id]
    c.merge(
        cityStatePrefill: true,
        model: "StaffingCompany",
        style: 'text-align: left; margin: 10px',
        strong_default_attrs: {draft_status: false},
        items: [
            {
                title: "Staffing Company Details",
                bodyStyle: 'padding-top: 10px',
                width: "70%",
                border: false,
                layout: :hbox,
                style: 'text-align: left; margin: 10px',
                items: [{name: :org_name, flex: 1, field_label: 'Name', emptyText: 'Name', allow_blank: false, label_width: 67, margin: "0 5px 0 0"}]
            },{
                border: false,
                layout: :hbox,
                style: 'text-align: left; margin: 10px',
                items: [
                    {name: :street_address, field_label: 'Address', emptyText: 'Street Address', allow_blank: false, flex: 4, label_width: 65, margin: "0 5px 0 0"},
                    {name: :suite_number, field_label: '', emptyText: 'Suite #', flex: 1}
                ]
            },{
                border: false,
                layout: :hbox,
                style: 'text-align: left; margin: 10px',
                items: [
                    {name: :zip_code, field_label: 'Location', allow_blank: false,  flex: 1, emptyText: 'ZIP Code', label_width: 65, margin: "0 5px 0 0"},
                    {name: :city, field_label: '', flex: 1, emptyText: 'City', label_width: 65, margin: "0 5px 0 0"},
                    {name: :state, field_label: '', xtype: 'combo', flex: 1, emptyText: 'State', label_width: 65,
                     store: State.all.collect{|x|[x.state_code, x.state_description]}},
                ]
            },{
                border: false,
                layout: :hbox,
                style: 'text-align: left; margin: 10px',
                items: [
                    {name: :email, field_label: 'Email/Fed Tax', allow_blank: false,  flex: 1.7, emptyText: 'Email', label_width: 97, margin: "0 5px 0 0", label_align: :left},
                    {name: :fed_tax_number, field_label: '', input_mask: '999999999', flex: 0.7, emptyText: 'Fed Tax Number', label_width: 65, item_id: :fed_tax_number },
                ]
            },
            {
                border: false,
                layout: :hbox,
                style: 'text-align: left; margin: 10px',
                items: [
                    {name: :phone_number, field_label: 'Phone Number', flex: 1, label_width: 100, emptyText: 'Phone Number', input_mask: '(999) 999-9999', margin: "0 5px 0 0", label_align: :left},
                    {name: :fax_number, field_label: 'Fax Number', flex: 1,  label_width: 90, input_mask: '(999) 999-9999', emptyText: 'Fax Number'},
                ]
            },

            :details.component(
            :name => :details,
            :height => 300,
            item_id: 'staffing_company_details',
            header: false,
            title: false,
            :class_name => "Netzke::Basepack::TabPanel",
            :items => [:contacts.component(
                           class_name: "ContactList",
                           parent_id: c[:record_id],
                       ),
                       :fieldstaffs.component(
                           :class_name => "ScFieldStaffList",
                           parent_id: component_session[:org_id],
                           header: "Field Staffs",
                           scope: "user_id IN (SELECT id FROM users WHERE user_type IN  ('LiteFieldStaff', 'FieldStaff')) AND org_id = #{component_session[:org_id]}",
                           :strong_default_attrs => {:org_id => component_session[:org_id]}

                       ),
                       :staffing_company_contracts.component(
                          :class_name => "StaffingCompanyContracts",
                          org_id: component_session[:org_id],
                          staffing_company_id: component_session[:org_id]
                       )  ],
            :width => 700,
            :border => true,
            :active_tab => 0
        )
        ]
    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      ele = Ext.ComponentQuery.query("#fed_tax_number")[0];
      ele.on('blur', function(ele){
         Ext.QuickTips.register({
           target: ele.getEl(),
           text: 'Fed Tax Number Must contain the 9 digit number',
         });
      },this);
    }
  JS
end