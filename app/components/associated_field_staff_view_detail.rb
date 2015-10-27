class AssociatedFieldStaffViewDetail < Mahaswami::FormPanel

  def initialize(conf = {}, parent = nil)
    super
    config[:record_id] = config[:field_staff_id]
    org_user = OrgUser.unscoped.where(user_id: config[:field_staff_id], org_id: Org.current.id).first
    user_status = org_user.user_status
    if user_status == :inactive
      self.config[:items].first[:items].each_with_index do |item, index|
          if item[:items].present?
            item[:items].each_with_index do |item, index|
              if item[:items].present?
                item[:items].each_with_index { |item, index | item[:read_only] = true}
              end
              item[:read_only] = true
            end
          else
            item[:read_only] = true
            config[:items][index] = item
          end
      end

    end
  end

  def configuration
    s = super
    fs = User.find(s[:field_staff_id])
    org_user = OrgUser.unscoped.where(user_id: fs.id, org_id: Org.current.id).first
    user_status = org_user.user_status
    component_session[:fs_id] = fs.id if fs
    s.merge(
        header: false,
        layout: :border,
        itemId: :associated_field_staff_view,
        cityStatePrefill: true,
        model: "FieldStaff",
        items: [
            {xtype: :fieldset,
             title: "Details",
             margin: 5,
             region: :north,
             autoScroll: true,
             collapsible: false,
             collapsed: false,
             items: [
                 {
                     border: false,
                     :margin => '0 0 5px 10px',
                     items: [
                         {
                             border: false,
                             layout: :hbox,


                             style: 'text-align: right; margin: "5px";',
                             bodyStyle: 'padding-top: 10px; padding-right: 30px',
                             items: [
                                 {name: :first_name, field_label: 'Name', xtype: :textfield,
                                   emptyText: 'First Name', label_width: 60, flex: 5, margin: "0 5px 0 0"},
                                 {name: :middle_initials, field_label: '', xtype: :textfield,
                                   emptyText: 'MI', flex: 1},
                                 {name: :last_name, field_label: '', xtype: :textfield,
                                   label_separator: '',  label_width: 5, emptyText: 'Last Name', flex: 4, margin: "0 5px 0 0"},
                                 {name: :suffix, field_label: '', emptyText: 'Suffix', xtype: :textfield, flex: 1},
                             ]
                         }
                     ]
                 },
                 {
                     header: false,
                     border: false,
                     layout: :hbox,
                     style: 'text-align: right; margin: 0 0 0 5px;',
                     bodyStyle: 'padding-top: 10px; padding-right: 30px',
                     items: [{name: :street_address, field_label: 'Address', xtype: :textfield,
                               emptyText: 'Street Address', flex: 4, label_width: 65, margin: "0 5px 0 0"},
                             {name: :suite_number, field_label: '', xtype: :textfield, emptyText: 'Suite #', flex: 1}
                     ]
                 },
                 {
                     border: false,
                     layout: :hbox,
                     style: 'text-align: right; margin: 0 0 0 5px',
                     bodyStyle: 'padding-top: 10px; padding-right: 30px',
                     items: [
                         {name: :zip_code, field_label: 'Location', xtype: :textfield, flex: 1,
                           emptyText: 'ZIP Code', label_width: 65, margin: "0 5px 0 0"},
                         {name: :city, field_label: '', xtype: :textfield, flex: 1, emptyText: 'City',
                           label_width: 65, margin: "0 5px 0 0"},
                         {name: :state, field_label: '', xtype: 'combo', xtype: :textfield, flex: 1, emptyText: 'State',
                          label_width: 65},
                     ]
                 },
                 {
                     border: false,
                     layout: :hbox,
                     style: 'text-align: right; margin: 0 0 0 5px;',
                     bodyStyle: 'padding-top: 10px; padding-right: 30px',
                     items: [
                         {name: :email, field_label: 'Contact', xtype: :textfield,  emptyText: 'Email',
                           flex: 2.1, label_width: 65,  margin: "0 5px 0 0"},
                         {name: :phone_number, input_mask: '(999) 999-9999', field_label: '', flex: 1, xtype: :textfield,
                           label_width: 65, emptyText: "Phone Number 1", margin: "0 5px 0 0"},
                         {name: :phone_number_2, input_mask: '(999) 999-9999', field_label: '', flex: 1, xtype: :textfield,
                           label_width: 65, emptyText: 'Phone Number 2',  margin: "0 5px 0 0"},
                         {name: :fax_number, input_mask: '(999) 999-9999', field_label: '', flex: 1, xtype: :textfield,
                           label_width: 70, emptyText: 'Fax Number', label_separator: '',margin: "0 2px 0 0"},
                     ]
                 },
                 {
                     border: false,
                     layout: :hbox,
                     style: 'text-align: right; margin: 0 0 5px 5px',
                     bodyStyle: 'padding-top: 10px; padding-right: 30px',
                     items: [
                         {name: :license_number, field_label: 'License', flex: 0.5, xtype: :textfield,
                           emptyText: 'License Number', label_width: 65, margin: "0 5px 0 0"},
                         {name: :license_type__license_type_description, flex: 0.5, field_label: ' ', label_separator: '',
                           emptyText: 'License Type ',
                          xtype: :textfield,
                           label_width: 5, read_only: true},
                          {xtype: :clinical_staff, boxLabel: '', field_label: "Works in Office", xtype: "checkboxfield",
                            flex: 0.3, read_only: true, value: fs.clinical_staff, item_id: "Clinical_staff" }
                     ]
                 },
                 fbar: [:convert_to_los.action]
             ]
            },
            :details.component(
              name: :details,
              region: :center,
              header: false,
              item_id: 'field_staff_details',
              class_name: "Netzke::Basepack::TabPanel",
              items: [
              :credentials.component(
                class_name: "FieldStaffCredentials",
                margin: 5,
                region: :center,
                bbar: (user_status == :inactive ? []: [:add_in_form.action, :edit_in_form.action, :print.action, :del.action]),
                title: "Credentials",
                context_menu: [],
                strong_default_attrs: {:field_staff_id => s[:field_staff_id]},
                scope: ["field_staff_id = ?", s[:field_staff_id]],
              ),
              :visit_type.component(
                  title: "Rates",
                  region: :center,
                  item_id: :rates,
                  class_name: "OrgFieldStaffVisitTypeList",
                  scope: {:org_user_id => s[:org_user_id]},
                  org_user_id: s[:org_user_id]

              ),
              :patients.component(
                title: "Patients",
                region: :center,
                item_id: :patients,
                class_name: 'FieldStaffPatientsList',
                field_staff_id:  s[:field_staff_id],
              )
              ]
            )
        ]
    )
  end

  action :convert_to_los, text: "Convert to Office Staff Account", tooltip: "Convert to Office Staff Login"
  #action :convert_to_fs, text: "Convert to Field Staff", tool_tip: "Convert to Field Staff"

  js_method :on_convert_to_los, <<-JS
    function(){
      var los = this.actions.convertToLos;
      var msg = "Converting this person's account type to an Office Staff account will allow him/her access to all"
                 + " patient records in your agency. Do you want to continue?"
      if(los){
        Ext.MessageBox.confirm("<b><i>Warning:</i></b>", msg, function(btn){
          if(btn == "yes"){
            this.convertToClinicalStaff({}, function(res){
            if (res){
              clinical_staff = this.down("#Clinical_staff")
              clinical_staff.setValue(true);
              Ext.MessageBox.alert("Status", "Field Staff account successfully converted to Office Staff account" );
            }else{
               Ext.MessageBox.alert("Status", "We cannot convert this field staff account to an office staff account"
                  + " at this time because he/she works with more than one home health agency.");
            }
            },this);
          }
        }, this);
      }
    }
  JS

  endpoint :convert_to_clinical_staff do |params|
    f = FieldStaff.find(component_session[:fs_id])
    res = f.convert_fs_to_clinical_staff
    {:set_result => res}
  end

  js_method :on_convert_to_fs, <<-JS
    function(){
      this.convertToFieldStaff({}, function(res){
        if (res){
          Ext.MessageBox.alert("Status", "Converted Clinical Staff to Field Staff successfully." );
        }else{
           Ext.MessageBox.alert("Status", "Field staff can not converted to field staff");
        }
      },this);
    }
  JS

  endpoint :convert_to_field_staff do |params|
    f = FieldStaff.find(component_session[:fs_id])
    res = f.convert_cs_to_field_staff
    {:set_result => res}
  end

end