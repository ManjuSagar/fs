class HealthAgencyUserProfile < Mahaswami::FormPanel

    def initialize(conf = {}, parent = nil)
      super
      config[:record_id] = User.current.id
    end

    def configuration
      c = super
      c.merge(
          cityStatePrefill: true,
          :lazy_loading => true,
          :title => "Profile",
          model: "OrgStaff",
          bbar: [:apply.action],
          #scope: :user_scope, # TO DO Not needed now since finding through record_id in initialize method
          items: [
              {xtype: 'fieldset',
               title: 'Details',
               layout: {
                   type: 'auto',
               },
               width: "30%",
               items: [{
                         width: "60%",
                         border: false,
                         items: [
                             {
                                 margin: "0 0 10px 100px ",

                                 border: false,
                                 layout: :hbox,
                                 style: 'text-align: right; xmargin: 10px',
                                 bodyStyle: 'padding-top: 10px',
                                 items: [
                                     {name: :first_name, field_label: "Name" , emptyText: 'First Name', allow_blank: false, label_separator:'', label_width: 65, flex: 5, margin: "0 5px 0 0"},
                                     {name: :last_name, field_label: "<span style='color:red;'>*</span>", label_separator: '', allow_blank: false, label_width: 5, emptyText: 'Last Name', flex: 4},
                                 ]
                             },
                             {
                                 margin: "0 0 10px 100px ",

                                 border: false,
                                 layout: :hbox,
                                 style: 'text-align: right; margin: 10px',
                                 items: [
                                     {name: :street_address, field_label: 'Address', emptyText: 'Street Address', flex: 4, label_width: 65, margin: "0 5px 0 0"},
                                     {name: :suite_number, field_label: '', emptyText: 'Suite #', flex: 1}
                                 ]
                             },


                             {

                                 margin: "0 0 10px 100px ",
                                 border: false,
                                 layout: :hbox,
                                 style: 'text-align: right; margin: 10px',
                                 items: [
                                     {name: :zip_code, field_label: 'Location', allow_blank: false,  flex: 1, emptyText: 'ZIP Code', label_width: 65, margin: "0 5px 0 0"},
                                     {name: :city, field_label: '', flex: 1, emptyText: 'City', label_width: 65, margin: "0 5px 0 0"},
                                     {name: :state, field_label: '', xtype: 'combo', flex: 1, emptyText: 'State', label_width: 65,
                                      store: State.all.collect{|x|[x.state_code, x.state_description]}},
                                 ]
                             },
                             {
                                 margin: "0 0 10px 14px ",
                                 border: false,
                                 layout: :hbox,
                                 style: 'text-align: right; margin: 10px',
                                 items: [
                                     {name: :gender, field_label: "Gender/Contacts <span style='color:red;'>*</span>", flex: 1.3,  mode: 'local', store: User::GENDERS, xtype: :combo, editable: false, emptyText: 'Gender', label_width: 150},
                                     {name: :email, field_label: '', allow_blank: false,  flex: 1, emptyText: 'Email', label_width: 65, margin: "0 5px 0 5px"},
                                     {name: :phone_number, field_label: '', input_mask: '(999) 999-9999', flex: 0.6, emptyText: 'Phone Number', label_width: 65},
                                 ]
                             }
                         ]

                       },
                   {
                       width: "75%",
                       margin: "0 0 10px 63px ",
                       border: false,
                       layout: :hbox,
                       style: 'text-align: right; margin: 10px',
                       items: [
                           {name: :password, inputType: 'password', field_label: 'Password', flex: 1.3, emptyText: 'Login Password', label_width: 100, margin: "0 5px 0 0"},
                           {name: :password_confirmation, inputType: 'password', field_label: '', flex: 0.8, emptyText: 'Confirm Password', margin: "0 5px 0 0"},
                           {name: :sign_password, inputType: 'password', field_label: '', flex: 0.8, emptyText: 'Sign Password', label_width: 100, margin: "0 5px 0 0"},
                           {name: :sign_password_confirmation, inputType: 'password', field_label: '', flex: 0.8, emptyText: 'Confirm Sign Password', margin: "0 5px 0 0"},

                       ]
                   },
               ]},
              {
                  xtype: 'panel',
                  autoScroll: true,
                  border: false,
                  items: [
                      {
                          xtype: 'panel',
                          hidden: true,
                      },{
                          xtype: 'fieldset',
                          title: "Signatures Info",
                          collapsible: true,
                          collapsed: false,
                          items: [
                              {
                                  xtype: 'tabpanel',
                                  region: 'center',
                                  width: "50%",
                                  height: "50%",
                                  minWidth: "50%",
                                  minHeight: "20%",
                                  margin: '5px',
                                  activeTab: 0,
                                  plain: true,
                                  items: signature_tab_panel_items

                              }
                          ]
                      },
                  ]
              },

          ]
      )
    end

  def signature_tab_panel_items
    (User.current.signature?) ?
        [
            {
                xtype: 'panel',
                title: 'Old Signature',
                items: [
                    {
                        xtype: 'image',
                        height: '122px',                        
                        src: User.current.signature.url(:thumb)
                    }
                ]
            },{
                xtype: 'panel',
                title: 'New Signature',
                items: [
                    {
                        name: :org_staff_signature, xtype: 'signatureCapture'
                    }
                ]
            }
        ] : [{
                 xtype: 'panel',
                 title: 'New Signature',
                 items: [
                     {
                         name: :org_staff_signature, xtype: 'signatureCapture'
                     }
                 ]
             }]
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.on("submitsuccess", function(){
        this.setCurrentPageAsDefaultPage({}, function(res){
          if(res == true) window.location = window.location.protocol + "//" + window.location.host;
        }, this);
      }, this);
    }
  JS

  endpoint :set_current_page_as_default_page do |params|
    res = session[:profile_not_completed]
    if session[:profile_not_completed]
      session[:current_page] = session[:home_page_component]
      session[:profile_not_completed] = false
    end
    {set_result: res}
  end

end