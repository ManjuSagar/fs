class PhysicianList < Mahaswami::GridPanel

  def initialize(conf={}, parent=nil)
    super
    components[:edit_form][:items].first.merge!(strong_default_attrs: {physician_id: component_session[:physician_id]})
  end

 def configuration
   super.merge(
     model: 'OrgPhysician',
     title:  "Physician",
     item_id: 'physician_list',
     columns: [
       {name: :physician__first_name, header: "First Name", editable: false, width: '10%', addHeaderFilter: true},
       {name: :physician__last_name, header: "Last Name", editable: false, width: '10%' , addHeaderFilter: true},
       {name: :physician__phone_number, header: "Phone Number", width: '10%', editable: false},
       {name: :physician__personal_phone_contact_1, header: "Alternate Number", width: '10%', editable: false},
       {name: :physician__physician_fax_number, header: "Fax Number", width: '10%', editable: false},
       {name: :physician__physician_email, header: "Email", width: '15%', editable: false},
       {name: :physician__npi_number, header: "NPI Number", editable: false, width: '8%', addHeaderFilter: true},
       {name: :physician__pecos_verification, header: "PECOS", renderer: :pecos_verification_status, width: '5%', editable: false },
     ],
     scope: :org_scope,
   )
 end

 def personal_contacts_column_if_required
   (Org.current.is_a? HealthAgency)? [{name: :personal_phone_number_1, width: 170, header: "Private Contact Number 1" },
                                      {name: :personal_phone_number_2, width: 170, header: "Private Contact Number 2" }] : []
 end

 def default_bbar
   [:add_in_form.action, :edit_in_form.action]
 end

 def default_context_menu
   [:add_in_form.action, :edit_in_form.action]
 end

 action :add_in_form, text: "Add New Physician", tooltip: "Add Physician", item_id: 'add_physician_button', icon: "",
                      cls: "blue-color-button"
 action :edit_in_form, text: "", tooltip: "Edit Physician", item_id: "edit_physician"

 add_form_config         class_name: "PhysicianForm"
 add_form_window_config  title: "Add Physician", width: "50%", height: "50%"
 edit_form_config        class_name: "PhysicianEditForm"
 edit_form_window_config  title: "Edit Physician", width: "50%", height: "50%"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemdblclick',function(view, record, e){
        this.setPhysicianId({recordId : record.get('id')})
      }, this);

    }
 JS

  js_method :pecos_verification_status, <<-JS
    function(value){      
      if (value == true){
        return "<center><img class='checked_image_class'></center>";
      }else{
        return "<center><img class='cross_image_class'></center>";
      }
    }
  JS

  endpoint :set_physician_id do |params|
    org_physician = OrgPhysician.where(id: params[:recordId]).first
    component_session[:physician_id] = org_physician.physician.id
  end

end