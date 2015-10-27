class HealthAgencyProfile < Mahaswami::FormPanel

  def initialize(conf = {}, parent = nil)
    super
    config[:record_id] = HealthAgencyDetail.find_by_health_agency_id(Org.current)
  end

  def configuration
    s = super
    ha_detail = HealthAgencyDetail.find_by_health_agency_id(Org.current)
    s.merge(
        :lazy_loading => true,
        :title => "Company",
        :model => "HealthAgencyDetail",
        :bbar => [:apply.action, :vitals.action, :ha_users.action, :audit_log.action],
        #:scope => :org_scope, # TO DO Not needed now since finding through record_id in initialize method
        :items => [{name: :org_name, field_label: "Agency Name", read_only: true},
                   {name: :building_name, field_label: "Building Name", xtype: :textfield},
                   {name: :street_address, field_label: "Street Address", xtype: :textfield},
                   {name: :suite_number, field_label: "Suite #", xtype: :textfield},
                   {name: :city, field_label: "City", xtype: :textfield},
                   {name: :state, field_label: "State", xtype: :textfield}] +
                  [
                      {xtype: 'fieldset',
                       border: false,
                       layout: :hbox,
                       margin: '3 -11 5 -10',
                       items: [
                        {name: :zip_code, field_label: "Zip Code", width: '20%', margin: '0 3 0 0'},
                        {name: :zip_code_part2, field_label: " _", labelSeparator: '', label_width: '1%',width: '79.9%'},
                        ]
                      }
                  ] + [
                   {name: :provider_number, field_label: "Provider Number"},
                   {name: :npi_number, field_label: "NPI #"},
                   {name: :submitter_id, field_label: "Submitter Id"},
                   {name: :mr_num_start_with, field_label: "MR # Start With", xtype: :numberfield},
                   {name: :cms_cert_number, field_label: "CMS Certification #"}]+
                    [
                      {
                        xtype: 'panel',
                        border: false,
                        layout: 'hbox',
                        items: [
                          {name: :routesheet_mandatory, field_label: "Routesheet mandatory?"},
                          {name: :print_insurance_address, field_label: "Print Insurance Company <br> Contact Info On Patient Documents", flex: 2.7, label_width: '85%', margin: '0 0 0 230%'},
                          { name: :co_signature_optional  , field_label: "Assistant co-signatures optional", flex: 1, label_width: 210, margin: '0 10% 0 0' },
                        ]
                      }
                    ] +
                   (ha_detail.can_do_billing? ? [{name: :claims_electronic_transmission, field_label: "Claims Electronic Submission",read_only: true}] : [] )+
                   [{name: :document_definition_set__set_name, field_label: "Document Set", read_only: true},
                   {name: :document_form_template_set__set_name, field_label: "Document Templates Set", read_only: true},
        ]
    )
  end

  action :ha_users, text: "", tooltip: "Users", icon: :users
  action :vitals, text: "", tooltip: "Vitals", icon: :vitals
  action :audit_log, text: "", tooltip: "Audit Log", icon: :audit_log

  js_method :on_ha_users, <<-JS
    function(){
      this.displayWindow("ha_users_list", "Users");
    }
  JS

  js_method :on_vitals, <<-JS
    function(){
      this.displayWindow("vital_signs_reference_range_list", "Vitals");
    }
  JS

  js_method :on_audit_log, <<-JS
    function(){
      this.displayWindow("audits", "Audit Log");
    }
  JS

  js_method :display_window,<<-JS
    function(component_name, title){
       var width = "50%";
       if(component_name == "audits") width = "80%";
       var w = new Ext.window.Window({
          width: width,
          height: "80%",
          modal: true,
          layout:'fit',
          buttons: [
           {
              text: "Close",
              listeners: {
                click: function(){w.close();}
              }
            }
          ],
            title: title,
        });
        w.show();
        this.loadNetzkeComponent({name: component_name, container:w, callback: function(w){
          w.show();
        }});
    }
  JS

  component :ha_users_list do
    {
        class_name: "OrganizationUsersList",
        lazy_loading: true,
        model: "OrgStaff",
        header: false,
        org_id: Org.current.id
    }
  end
  component :vital_signs_reference_range_list do
    {
        class_name: "VitalSignsReferenceRangeList",
        lazy_loading: true,
        header: false
    }
  end
  component :audits do
    {
        class_name: "Audits",
        lazy_loading: true,
        header: false
    }
  end


end