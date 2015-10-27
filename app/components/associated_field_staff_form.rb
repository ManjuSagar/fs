class AssociatedFieldStaffForm < Mahaswami::FormPanel

  def configuration
    c = super
    c.merge(
        model: "OrgUser",
        show_new_field_staff_action: true,
        item_id: "new_field_staff",
        strong_default_attrs: {:org_id => Org.current.id, :user_status => "N", fs_assigning_to_ha: true},
        items: [
            {name: :user__full_name, item_id: "user_list", field_label: "Field Staff"},
            {name: :user_email, item_id: "user_email", field_label: "Email", hidden: true, allowBlank: false, vtype: :email}
        ]
    )
  end

  action :new_field_staff, text: "New Field Staff"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var field = this.down('#user_list');
      field.on("select", function(){
        this.checkUserType({user_id: field.value});
      }, this);
      field.store.on("load", function( s, records, successful, eOpts ){
        if (records.length == 0)
          field.setValue("");
          this.showHideEmailInput(false);
      }, this);
    }
  JS

  endpoint :check_user_type do |params|
    show_email_input = false
    unless params[:user_id].nil?
      user = User.find(params[:user_id])
      show_email_input = user.is_a? LiteFieldStaff
    end
    {:show_hide_email_input => show_email_input}
  end

  js_method :show_hide_email_input, <<-JS
    function(show){
      var email = Ext.ComponentQuery.query('#user_email')[0];
      if(show){
        email.show();
      }else{
        email.hide();
      }
    }
  JS

  js_method :on_new_field_staff, <<-JS
    function(){
    this.loadNetzkeComponent({name: "add_field_staff", callback: function(w){
      w.show();
      w.on("close", function(){
        Ext.ComponentQuery.query("#add_form")[0].close();
        Ext.ComponentQuery.query("#associated_field_staff_grid")[0].store.load();
      });
    }, scope: this});
  }
  JS

  component :add_field_staff do
    form_config = {
        :class_name => "Mahaswami::FormPanel",
        :model => "FieldStaff",
        :cityStatePrefill => true,
        :persistent_config => config[:persistent_config],
        :strong_default_attrs => config[:strong_default_attrs],
        :border => true,
        :bbar => false,
        :prevent_header => true,
        :mode => config[:mode],
        :items => [
            {

                border: false,
                :margin => '0 0 5px 20px',
                items: [
                {
                    border: false,
                    layout: :hbox,


                    style: 'text-align: right; margin: "5px";',
                    bodyStyle: 'padding-top: 10px; padding-right: 30px',
                    items: [
                    {name: :first_name, field_label: 'Name', item_id: :first_name, emptyText: 'First Name', allow_blank: false, label_width: 70, flex: 5},
                    {name: :last_name, field_label: ' ', item_id: :last_name, label_separator: '',  label_width: 5, emptyText: 'Last Name', allow_blank: false, flex: 4},
                ]
            },
            {
                header: false,
                border: false,
                layout: :hbox,
                style: 'text-align: right; margin: 0 0 0 5px;',
                bodyStyle: 'padding-top: 10px; padding-right: 30px',
                items: [{name: :street_address, field_label: 'Address', emptyText: 'Street Address', flex: 4, label_width: 65, margin: "0 5px 0 0"},
                        {name: :suite_number, field_label: '', emptyText: 'Suite #', flex: 1}
                ]
            },
            {
                border: false,
                layout: :hbox,
                style: 'text-align: right; margin: 0 0 0 5px',
                bodyStyle: 'padding-top: 10px; padding-right: 30px',
                items: [
                    {name: :zip_code, field_label: 'Location', allow_blank: false,  flex: 1, emptyText: 'ZIP Code', label_width: 65, margin: "0 5px 0 0"},
                    {name: :city, field_label: '', flex: 1, emptyText: 'City', label_width: 65, margin: "0 5px 0 0"},
                    {name: :state, field_label: '', xtype: 'combo', flex: 1, emptyText: 'State', label_width: 65,
                     store: State.all.collect{|x|[x.state_code, x.state_description]}},
                ]
            },
            {
                border: false,
                layout: :hbox,
                style: 'text-align: right; margin: 0 0 0 5px;',
                bodyStyle: 'padding-top: 10px; padding-right: 30px',
                items: [
                    {name: :email, field_label: 'Contact', allow_blank: false, emptyText: 'Email', flex: 2.5, label_width: 65,  margin: "0 5px 0 0"},
                    {name: :phone_number, field_label: '', flex: 1, label_width: 65, emptyText: "Phone Number 1", input_mask: '(999) 999-9999',  margin: "0 5px 0 0"},
                    {name: :phone_number_2, field_label: '', flex: 1, label_width: 65, emptyText: 'Phone Number 2', input_mask: '(999) 999-9999', margin: "0 5px 0 0"},
                    {name: :fax_number, field_label: '', flex: 1,  label_width: 70, input_mask: '(999) 999-9999', emptyText: 'Fax Number', label_separator: ''},
                ]
            },
            {

                border: false,
                layout: :hbox,

                style: 'text-align: right; margin: "5px";',
                bodyStyle: 'padding-top: 10px; padding-right: 30px',
                items: [
                    {name: :password, inputType: 'password', field_label: 'Password', emptyText: 'Password', allow_blank: false, label_width: 70, flex: 5},
                    {name: :password_confirmation, inputType: 'password', field_label: ' ', label_separator: '',  label_width: 5, emptyText: 'Confirm password', allow_blank: false, flex: 4},
                ]
            },
            {
                border: false,
                layout: :hbox,
                style: 'text-align: right; margin: 0 0 10px 5px',
                bodyStyle: 'padding-top: 10px; padding-right: 30px',
                items: [
                    {name: :gender, field_label: 'Details', mode: 'local', store: User::GENDERS, xtype: :combo, editable: false, flex: 1, emptyText: 'Gender', label_width: 65, margin: "0 5px 0 0"},
                    {name: :license_number, field_label: '', flex: 1, emptyText: 'License Number', label_width: 65, margin: "0 5px 0 0"},
                    {name: :license_type__license_type_description, flex: 1, field_label: ' ', label_separator: '', emptyText: 'License Type ', allow_blank: false, label_width: 5},
                ]
            },{name: :clinical_staff, boxLabel:"",
               xtype: 'checkboxfield',
               field_label: "This field staff works in the office (checking this box will allow this field staff access to all your patient charts)",
               labelWidth: 645}
          ]},
            :languages.component(
                class_name: "Mahaswami::HasAndBelongsToManyInput",
                record: record,
                columns: 3,
                margin: '0 0 10px 25px',
                label_width: 63,
                association: :languages,
                scope: :sort_ascending
            ),
            :visit_types.component(
                class_name: "Mahaswami::HasAndBelongsToManyInput",
                record: record,
                association: :visit_types,
                scope: :without_discipline,
                label_width: 63,
                columns: 3,
                margin: '0 0 10px 25px',
            )
        ]
    }

    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :width => "55%",
        :height => "71%",
        :title => "Add Field Staff",
        :button_align => "right",
        :items => [form_config]
    }
  end

  def user__full_name_combobox_options(params)
    return [] if params[:query].empty?
    existing_staffs = Org.current.org_users.field_staffs.map(&:user).map(&:id)
    users = if existing_staffs.empty?
              User.where({:user_type => ['FieldStaff', 'LiteFieldStaff']})
            else
              User.where({:user_type => ['FieldStaff', 'LiteFieldStaff']}).where(["id not in (?)", existing_staffs])
            end
    query = "#{params[:query].upcase}%"
    values = users.empty??  [] : users.where(["upper(first_name) LIKE ? or upper(last_name) LIKE ?", query, query])
    values = values.reject{|x| x.clinical_staff.present?}
    values.collect!{|x| [x.id, x.full_name]}
    {:data => values}
  end

end