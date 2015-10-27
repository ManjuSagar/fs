class FieldStaffProfile < Mahaswami::FormPanel

  def initialize(conf = {}, parent = nil)
    super
    config[:record_id] = FieldStaff.current.id
  end

  def configuration
    c = super
    c.merge(
        cityStatePrefill: true,
      :lazy_loading => true,
      :title => "Settings",
      model: "FieldStaff",
      scope: :user_scope,
      bbar: [:apply.action, :service_areas.action],
      items: [
          {xtype: 'fieldset',
           title: 'Details',
           autoWidth: true,
           autoHeight: true,
           layout: {
               type: 'auto',
           },
           items: [
               {
                   width: "60%",
                   border: false,
                   items: [
                     {
                         margin: "0 0 10px 100px ",
                         border: false,
                         layout: :hbox,

                         style: 'text-align: right; margin: "5px";',
                         items: [
                             {name: :first_name, field_label: 'Name', emptyText: 'First Name', allow_blank: false, label_width: 65, flex: 5},
                             {name: :last_name, field_label: ' ', label_separator: '',  label_width: 5, emptyText: 'Last Name', allow_blank: false, flex: 4},
                         ]
                     },
                     {
                         margin: "0 0 10px 100px ",
                         border: false,
                         layout: :hbox,
                         style: 'text-align: right; margin: 10px',
                         items: [
                             {name: :street_address, field_label: 'Address', emptyText: 'Street Address', flex: 4, label_width: 65, margin: "0 5px 0 0"},
                             {name: :suite_number, field_label: '', emptyText: 'Suite #', flex: 1, label_width: 5}
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
                         margin: "0 0 10px 100px ",
                         border: false,
                         layout: :hbox,
                         style: 'text-align: right; margin: 0 0 0 5px;',
                         items: [
                             {name: :email, field_label: 'Contact', allow_blank: false, emptyText: 'Email', flex: 2, label_width: 65,  margin: "0 5px 0 0"},
                             {name: :phone_number, field_label: '', flex: 1, label_width: 65, emptyText: "Phone Number 1", input_mask: '(999) 999-9999',  margin: "0 5px 0 0"},
                             {name: :phone_number_2, field_label: '', flex: 1, label_width: 65, emptyText: 'Phone Number 2', input_mask: '(999) 999-9999', margin: "0 5px 0 0"},
                             {name: :fax_number, field_label: '', flex: 1,  label_width: 65, input_mask: '(999) 999-9999', emptyText: 'Fax Number', label_separator: ''},
                         ]
                     },

                     {

                         margin: "0 0 10px 100px ",
                         border: false,
                         layout: :hbox,
                         style: 'text-align: right; margin: 0 0 10px 5px',
                         items: [
                             {name: :gender, field_label: 'Details', mode: 'local', store: User::GENDERS, xtype: :combo, editable: false, flex: 1, emptyText: 'Gender', label_width: 65, margin: "0 5px 0 0"},
                             {name: :license_number, field_label: '', flex: 1, emptyText: 'License Number', label_width: 65, margin: "0 5px 0 0"},
                             {name: :license_type__license_type_description, flex: 1, field_label: ' ', label_separator: '', emptyText: 'License Type ', read_only: true, allow_blank: false, label_width: 5},
                         ]
                     },
                     {

                         margin: "0 0 10px 15px",
                         border: false,
                         layout: :hbox,
                         style: 'text-align: right; margin: 0 0 10px 5px',
                         items: [
                             {name: :review_agency_changes_flag, field_label: "Review Agency Changes", xtype: "checkbox", label_align: "left", inputValue: true, label_width: 150},
                         ]
                     }
                   ]
               },
               {
                   width: "75%",
                   margin: "0 0 10px 62px ",
                   border: false,
                   layout: :hbox,
                   style: 'text-align: right; margin: 0 0 10px 5px',
                   items: [
                       {name: :password, inputType: 'password', field_label: 'Password',  emptyText: 'Login Password', label_width: 100, margin: "0 5px 0 0"},
                       {name: :password_confirmation, inputType: 'password', field_label: '', emptyText: 'Confirm Password'},
                       {name: :sign_password, inputType: 'password', field_label: '', emptyText: 'Sign Password', label_width: 100, margin: "0 5px 0 0"},
                       {name: :sign_password_confirmation, inputType: 'password', field_label: '', emptyText: 'Confirm Sign Password'},

                   ]
               },
           ]},
          {xtype: :fieldset, collapsible: true, collapsed: false, title: "Languages",
                items:[:languages.component(field_label: "")]},
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


  component :languages do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        columns: 4,
        association: :languages,
        scope: :sort_ascending
    }
  end


  action :service_areas

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
                  name: :field_staff_signature, xtype: 'signatureCapture'
                }
            ]
        }
    ] : [{
                 xtype: 'panel',
                 title: 'New Signature',
                 items: [
                     {
                       name: :field_staff_signature, xtype: 'signatureCapture'
                     }
                 ]
             }]
  end
  
  component :service_area_selection_window, :lazy_loading => true do
    c = {} 
    c[:class_name] = 'ServiceAreaSelectionWindow'
    c[:fs_id] = FieldStaff.user_scope.first.id
    c
  end
  
  endpoint :get_current_fs do |params|
    {set_result: {fs_id: FieldStaff.user_scope.first.id}}
  end  
  
  js_method :on_service_areas, <<-JS
    function(){
      this.getCurrentFs({}, function(result){
                var fsId = result['fsId'];
                console.log(fsId);
                
                var a = this.loadNetzkeComponent({name: 'service_area_selection_window',
                    callback: function(w){
                      w.show();
                    }
                });
                
            } , this);
    }
  JS

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
