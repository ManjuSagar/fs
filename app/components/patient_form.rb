class PatientForm < Mahaswami::FormPanel

  def configuration
    super.merge(
        model: "Patient",
        autoScroll: true,
        notify_on_save: false,
        cityStatePrefill: true,
        bbar: [:medicare_eligibility.action],
        items: [
            { border: false,
              :margin => '0 0 10px 10px',
                items: [
                {
                    border: false,
                    layout: :hbox,

                    style: 'text-align: right; margin: "5px";',
                    bodyStyle: 'padding-top: 10px; padding-right: 30px',
                    items: [
                        {name: :first_name, field_label: 'Name', item_id: :first_name, emptyText: 'First Name', allow_blank: false, label_width: 70, flex: 5, margin: "0 5px 0 0"},
                        {name: :middle_initials, field_label: '', emptyText: 'MI', flex: 1},
                        {name: :last_name, field_label: ' ', item_id: :last_name, label_separator: '',  label_width: 5, emptyText: 'Last Name', allow_blank: false, flex: 4, margin: "0 5px 0 0"},
                        {name: :suffix, field_label: '', emptyText: 'Suffix', flex: 1},
                    ]
                },
                {
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 0 0 0 5px;',
                    bodyStyle: 'padding-top: 10px; padding-right: 30px',
                    items: [
                        {name: :dob, field_label: 'Details', item_id: :dob, allow_blank: false, emptyText: 'DOB(mm/dd/yyyy)', flex: 2, label_width: 65},
                        {name: :gender, field_label: ' ', item_id: :gender,  mode: 'local', store: User::GENDERS, xtype: :combo, editable: false, allow_blank: false, flex: 1, label_width: 5, label_separator: '', emptyText: "Gender"},
                        {name: :ssn, field_label: ' ', input_mask: '999-99-9999', allow_blank: false, emptyText: 'SSN', flex: 1, label_width: 5, label_separator: '', margin: "0 5px 0 0"},
                        {name: :medicare_number, field_label: '', item_id: :medicare_number, clearWhenInvalid: false, input_mask: '999999999L99', emptyText: 'Medicare #', flex: 1, label_width: 70},
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
                    style: 'text-align: right; margin: 0 5px 10px 5px',
                    bodyStyle: 'padding-top: 10px',
                    items: [
                        {name: :phone_number, field_label: 'Contact', input_mask: '(999) 999-9999', allow_blank: false, emptyText: 'Mobile',  label_width: 65, allow_blank: false, margin: "0 5px 0 0"},
                        {name: :phone_number_2, field_label: '', input_mask: '(999) 999-9999', emptyText: 'Home Phone'}
                    ]
                }
            ]},
            {xtype: :fieldset, collapsible: true, collapsed: true,  title: "DNR/DNI/Advanced Directives/Acuity", layout: :hbox,
             margin: '0 0 10px 20px',
             items:[
                 {
                     xtype: 'radiogroup',
                     fieldLabel: "DNR",
                     labelAlign: 'right',
                     border: false,
                     label_width: 50,
                     flex: 1,
                     item_id: :dnr,
                     columns: 1,
                     items: [
                         {
                             xtype: 'radiofield',
                             name: "dnr",
                             inputValue: "1",
                             field_label: "",
                             boxLabel: 'Yes'
                         },
                         {
                             xtype: 'radiofield',
                             name: "dnr",
                             inputValue: "2",
                             field_label: "",
                             boxLabel: 'No'
                         },
                         {
                             xtype: 'radiofield',
                             name: "dnr",
                             inputValue: "3",
                             field_label: "",
                             boxLabel: 'NA'
                         }
                     ]
                 },
                 {
                     xtype: 'radiogroup',
                     fieldLabel: "DNI",
                     labelAlign: 'right',
                     border: false,
                     label_width: 50,
                     flex: 1,
                     columns: 1,
                     items: [
                         {
                             xtype: 'radiofield',
                             name: "dni",
                             inputValue: "1",
                             field_label: "",
                             boxLabel: 'Yes'
                         },
                         {
                             xtype: 'radiofield',
                             name: "dni",
                             inputValue: "2",
                             field_label: "",
                             boxLabel: 'No'
                         },
                         {
                             xtype: 'radiofield',
                             name: "dni",
                             inputValue: "3",
                             field_label: "",
                             boxLabel: 'NA'
                         }
                     ]
                 },
                 {
                     xtype: 'radiogroup',
                     fieldLabel: "Advanced Directives",
                     labelAlign: 'right',
                     border: false,
                     label_width: 50,
                     flex: 1,
                     columns: 1,
                     items: [
                         {
                             xtype: 'radiofield',
                             name: "advanced_directive",
                             inputValue: "1",
                             field_label: "",
                             boxLabel: 'Yes'
                         },
                         {
                             xtype: 'radiofield',
                             name: "advanced_directive",
                             inputValue: "2",
                             field_label: "",
                             boxLabel: 'No'
                         },
                         {
                             xtype: 'radiofield',
                             name: "advanced_directive",
                             inputValue: "3",
                             field_label: "",
                             boxLabel: 'NA'
                         }
                     ]
                 },
                 {
                     xtype: 'radiogroup',
                     fieldLabel: "Acuity",
                     labelAlign: 'right',
                     border: false,
                     label_width: 50,
                     flex: 1,
                     item_id: :acuity_level,
                     columns: 1,
                     items: [
                         {
                             xtype: 'radiofield',
                             name: "acuity_level",
                             inputValue: "1",
                             field_label: "",
                             boxLabel: 'Low'
                         },
                         {
                             xtype: 'radiofield',
                             name: "acuity_level",
                             inputValue: "2",
                             field_label: "",
                             boxLabel: 'Medium'
                         },
                         {
                             xtype: 'radiofield',
                             name: "acuity_level",
                             inputValue: "3",
                             field_label: "",
                             boxLabel: 'High'
                         },
                         {
                             xtype: 'radiofield',
                             name: "acuity_level",
                             inputValue: "4",
                             field_label: "",
                             boxLabel: 'NA'
                         }
                     ]
                 },
             ]},
            {xtype: :fieldset, collapsible: true, collapsed: true, title: "Languages", margin: '0 0 10px 20px', items:[
              :languages.component(field_label: "")
            ]},
            {xtype: :fieldset, collapsible: true, collapsed: true, title: "Caregivers", margin: '0 0 10px 20px',items:[
                {border: false, items:[
                {
                  border: false,
                  layout: :hbox,
                  margin: '0 0 5px 0',
                  items: [
                  {name: :caregiver_1_first_name, field_label: 'Caregiver 1', emptyText: 'First Name', flex: 1.5, label_width: 70},
                  {name: :caregiver_1_last_name, field_label: '', emptyText: 'Last Name', flex: 1},
                  {name: :caregiver_1_phone_number, field_label: '', input_mask: '(999) 999-9999', emptyText: 'Phone Number', flex: 1},
                  {name: :caregiver_1_relation_to_patient, field_label: '', emptyText: 'Relation to Patient', flex: 1}
                ]},
                {   border: false,
                    layout: :hbox,
                    items: [
                    {name: :caregiver_2_first_name, field_label: 'Caregiver 2', emptyText: 'First Name', flex: 1.5, label_width: 70},
                    {name: :caregiver_2_last_name, field_label: '', emptyText: 'Last Name', flex: 1},
                    {name: :caregiver_2_phone_number, field_label: '', input_mask: '(999) 999-9999', emptyText: 'Phone Number', flex: 1},
                    {name: :caregiver_2_relation_to_patient, field_label: '', emptyText: 'Relation to Patient', flex: 1}
                ]}
                ]}
            ]},


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

  action :medicare_eligibility, text: "Medicare Eligibility", tooltip: "Medicare Eligibility"

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      var formScope = this;
      this.on('submitsuccess', function() {
        var w = new Ext.window.Window({
            width: "50%",
            height: "80%",
            modal: true,
            layout:'fit',
            buttons: [
              {
                text: "Close",
                listeners: {
                  click: function(){formScope.addInsuranceCompaniesAndReferral(); w.close();}
                }
              }
            ],
            title: "Insurance Companies",
          }, this);
          w.show();
          w.on('close', function(){
            formScope.addInsuranceCompaniesAndReferral();
          }, this);
          this.loadNetzkeComponent({name: "patient_insurance_companies_list", params: {component_params: {parent_id: this.getValues().id}}, container:w, callback: function(w){
            w.show();
          }});
        return false;
      }, this);
    }
  JS

  js_method :add_insurance_companies_and_referral,<<-JS
    function(){
      Ext.MessageBox.confirm('Confirm', 'Do you wish to create a referral for this patient?', function(result){
        if (result == "yes") {
          this.up('window').setWidth(700);
          this.up('window').setHeight(475);
          this.loadNetzkeComponent({name: 'referral_new_form', params: {component_params: {patient_id: this.getValues().id}}, container: this.getParent(),
            callback: function() {
              this.getParent().setTitle(this.getParent().items.first().title);
              this.getParent().items.first().on("submitsuccess", function(){
                  this.getParent().closeRes = "ok"; this.getParent().close();
              }, this);
            },
            scope: this
          });
        }else{
          this.getParent().closeRes = "ok";
          this.up('window').close();
        }
      }, this);
    }
  JS

  component :patient_insurance_companies_list do
    {
        class_name: "PatientInsuranceCompaniesList"
    }
  end

  js_method :on_medicare_eligibility,<<-JS
    function(){
      var firstName = this.down("#first_name");
      var lastName = this.down("#last_name");
      var dob = this.down("#dob");
      var medicareNumber = this.down("#medicare_number");
      var fields = [firstName, lastName, dob, medicareNumber];
      var errorMsg = "";
      Ext.each(fields, function(field, index){
        if (field.value == null || field.value == ""){
          errorMsg += field.fieldLabel+" can't be blank.<br />";
        }
      });
      if(medicareNumber.value != null && !medicareNumber.value.match(/[0-9]{9}[A-Z]{1}/)){
        errorMsg += "Medicare # Format should be 9 digits followed by a upper case character."
      }
      if(errorMsg.length > 0){
        Ext.MessageBox.alert("Status", errorMsg);
      }else{
        this.selectPatientInformation({first_name: firstName.value, last_name: lastName.value, dob: dob.value,
                          medicare_number: medicareNumber.value}, function(res){
          var w = new Ext.window.Window({
              width: "60%",
              height: "90%",
              modal: true,
              layout:'fit',
              title: "Eligibility Check Report",
            });
          w.show();
          this.loadNetzkeComponent({name: "check_medicare_eligibility_details", container:w, callback: function(w){
            w.show();
          }});
        }, this);
      }
    }
  JS

  endpoint :select_patient_information do |params|
    component_session[:patient_details] = params
    {:set_result => 't'}
  end

  component :check_medicare_eligibility_details do
    {
        class_name: "CheckMedicareEligibilityDetails",
        items: [],
        patient_details: component_session[:patient_details],
        lazy_loading: true,
    }
  end

  component :referral_new_form do
    {
    class_name: "ReferralNewForm",
    border: true,
    bbar: false,
    prevent_header: true,
    record: TreatmentRequest.new,
    title: "Add Referral"
    }
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end

end
