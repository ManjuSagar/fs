class PatientEditForm < Mahaswami::FormPanel

  def initialize(conf = {}, parent = nil)
    @record = Patient.find(conf[:record_id]) if conf[:record_id]
    super
  end

  def configuration
    c = super
    component_session[:patient_id] = c[:record_id] if c[:record_id]
    c.merge(
        model: "Patient",
        width: "50%",
        autoScroll: true,
        item_id: "medicare_eligibility",
        notify_on_save: ((c[:is_sample_patient] == true)? false : true),
        cityStatePrefill: true,
        title: c[:title] || "Edit Patient",
        bbar: c[:bbar] ? ([:medicare_eligibility.action, :add_referral.action] + c[:bbar]) : [:medicare_eligibility.action],
        items: [
            {
                border: false,
                :margin => '0 0 5px 10px',
                items:
                ((@record and @record.draft_status?) ? [{
                    border: false,
                    layout: :hbox,

                    style: 'text-align: right; margin: "5px";',
                    bodyStyle: 'padding-top: 10px; padding-right: 30px',
                    items: [
                        {name: :patient_reference, field_label: 'MR #', item_id: :mr_num, emptyText: 'MR #', flex: 1, label_width: 70}
                    ]
                }] : []) + [{
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
                        {name: :gender, field_label: ' ', mode: 'local', store: User::GENDERS, xtype: :combo, editable: false, allow_blank: false, flex: 1, label_width: 5, label_separator: '', emptyText: "Gender"},
                        {name: :ssn, field_label: ' ', input_mask: '999-99-9999', allow_blank: false, emptyText: 'SSN', flex: 1, label_width: 5, label_separator: '', margin: "0 5px 0 0", item_id: :ssn},
                        {name: :medicare_number, field_label: '', item_id: :medicare_number, emptyText: 'Medicare #', flex: 1, label_width: 70},
                    ]
                },
                {
                    header: false,
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 0 0 0 5px;',
                    bodyStyle: 'padding-top: 10px; padding-right: 30px',
                    items: [{name: :street_address, field_label: 'Address', emptyText: 'Street Address', allow_blank: false, flex: 4, label_width: 65, margin: "0 5px 0 0"},
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
                        {name: :phone_number, field_label: 'Contact', input_mask: '(999) 999-9999', allow_blank: false, emptyText: 'Mobile', label_width: 65, margin: "0 5px 0 0"},
                        {name: :phone_number_2, field_label: '', input_mask: '(999) 999-9999', emptyText: 'Home Phone'}
                    ]
                }
            ]},
            {xtype: :fieldset, collapsible: true, collapsed: true, title: "DNR/DNI/Advanced Directives/Acuity", layout: :hbox,
             :margin => '0 0 10px 20px',
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
            {xtype: :fieldset, collapsible: true, collapsed: true, title: "Languages", :margin => '0 0 10px 20px', items:[
                :languages.component(field_label: "")
            ]},
            :details.component
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

  component :details do
    {
        :name => :details,
        :title => "",
        :header => false,
        :height => 200,
        :margin => '0 0 10px 20px',
        :class_name => "Netzke::Basepack::TabPanel",
        :items => [
            :insurance_companies.component(class_name: "PatientInsuranceCompaniesList",
                                           parent_id: component_session[:patient_id]),
            :care_givers.component(
                class_name: "CaregiversList",
                parent_id: component_session[:patient_id]

            )  ]
    }
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.agencyAbleToCheckEligibility({}, function(res){
       newPatient = Ext.ComponentQuery.query('#patient_new')[0];
       if (newPatient){newPatient.actions.medicareEligibility.setDisabled(!res);}
       this.actions.medicareEligibility.setDisabled(!res);
      }, this);
      ssn = this.down('#ssn');
      ssn.on('blur',function(){
        ssn_value = ssn.value.split("-").join("");
        medicare = this.down('#medicare_number');
        medicare.setValue(ssn_value);
      },this);
      if(this.isSamplePatient){
        this.on('submitsuccess', function() {
          Ext.MessageBox.confirm('Confirm', 'Do you wish to create a referral for this patient?', function(result){
            if (result == "yes") {
              this.up('window').setWidth(700);
              this.up('window').setHeight(475);
              this.up('window').actions.medicareEligibility.hide();
              var parentId = this.getValues().id;
              this.loadNetzkeComponent({name: 'referral_new_form', params: {component_params: {patient_id: parentId}}, container: this.getParentNetzkeComponent(),
                callback: function() {
                  this.getParentNetzkeComponent().setTitle(this.getParentNetzkeComponent().items.first().title);
                  this.getParentNetzkeComponent().items.first().on("submitsuccess", function(){
                    console.log("referral Submit success");
                    this.getParentNetzkeComponent().closeRes = {status: "referral_yes", patient_id: parentId}; this.getParentNetzkeComponent().close();
                    return false;
                  }, this);
                }, scope: this
              });
            }else{
              this.getParentNetzkeComponent().closeRes = {status: "referral_no", patient_id: parentId};
              this.up('window').close();
            }
          }, this);
          return false;
        }, this);
      }
    }
  JS

  action :medicare_eligibility, text: "Medicare Eligibility", tooltip: "Medicare Eligibility", item_id: :medicare_eligibility_button
  action :delete_patient, text: "", tooltip: "Delete Patient", icon: :delete_new
  action :add_referral, text: "Referral", tooltip: "Add Referral", icon: :add_new
  action :apply, text: ""

  endpoint :agency_able_to_check_eligibility do |params|
    org = Org.current
    {:set_result => org.health_agency_detail.certificate_password.present?}
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
          errorMsg += field.emptyText+" can't be blank.<br />";
        }
      });
      if(medicareNumber.value != null){
          if (medicareNumber.value.match(/^[a-zA-z]{1}/) && medicareNumber.value.match(/^([a-zA-Z]){3}([0-9]){6,9}(\s){0,3}/) == null){
              errorMsg += "Medicare # if the first character is a letter, then there must be 1 to 3 alphabetic characters followed by 6 or 9 numbers followed by spaces up to the field length of 12."
          }else if (medicareNumber.value.match(/^([0-9]){1}/) && medicareNumber.value.match(/^([0-9]){9}/) == null){
              errorMsg += "Medicare # If the first character is numeric (0 through 9), then the first 9 characters must be numeric"
          }
      }
      if(errorMsg.length > 0){
        Ext.MessageBox.alert("Status", errorMsg);
      }else{
        this.selectPatientInformation({first_name: firstName.value, last_name: lastName.value, dob: dob.value,
                          medicare_number: medicareNumber.value}, function(res){
          this.setLoading(true);
          this.printEligibilityReport({}, function(){
            this.setLoading(false);
         });
        });
      }
    }
  JS

  endpoint :print_eligibility_report do |params|
    details= component_session[:patient_details]
    org = Org.current
    p = PatientMedicareEligibilityInfo.new(org, details[0], details[1], Date.parse(details[2]), details[3] )
    title = "Eligibility Report"
    res = p.generate_pdf_report    
    if res.start_with?("#{Rails.root}")
      session[:pre_generated_file_name] = res
      {:launch_eligibility_report => ["/reports/eligibility", title]}
    else
      {display_errors: res}
    end
  end

  js_method :display_errors, <<-JS
    function(res){
      Ext.MessageBox.alert("Error(s)", res);
    }
  JS

  js_method :launch_eligibility_report, <<-JS
    function(result) {
      var reportUrl = result[0];
      reportUrl = window.location.protocol + "//" + window.location.host + result[0];
      var reportTitle = result[1];
      if (Ext.isGecko) {
        window.location = reportUrl;
      } else {
        Ext.create('Ext.window.Window', {
            width : "60%",
            height: "90%",
            layout : 'fit',
            title : reportTitle,
            itemId: 'eligibility_report',
            items : [{
                xtype : "component",
                id: 'myIframe',
                autoEl : {
                    tag : "iframe",
                    href : ""
                }
            }]
        }).show();
        Ext.getDom('myIframe').src = reportUrl
      }
    }
  JS

  js_method :on_add_referral, <<-JS
    function(){
      this.loadNetzkeComponent({name: 'add_referral', callback: function(w){
        w.show();
      }, scope: this});
    }
  JS

  component :add_referral do
    form_config = {
        class_name: "ReferralNewForm",
        patient_id: config[:record_id],
        bbar: [],
        header: false
    }

    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        width: 700,
        height: 475,
        :auto_width => true,
        :auto_height => true,
        :title => "Add Referral",
        :button_align => "right",
        :items => [form_config]
    }
  end

  endpoint :select_patient_information do |params|
    params["dob"] = Date.parse(params["dob"]).strftime("%Y%m%d")
    params["medicare_number"] = params["medicare_number"].split("_").first
    params["first_name"] = params["first_name"].upcase
    params["last_name"] = params["last_name"].upcase
    component_session[:patient_details] = params.values
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

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      if(this.showMedicareEligibilityAction) this.actions.medicareEligibility.hide();
      this.createAudit({patient_id: this.record.id});
    }
  JS

  endpoint :create_audit do |params|
    p = Patient.find(params[:patient_id])
    return {} if p.draft_status
    p.user_viewing_changed_attr_value = p.current_sign_in_at
    p.current_sign_in_at = Time.now
    p.audit_comment = "User View"
    p.save!
    {}
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

  js_method :on_delete_patient,<<-JS
    function(){
      this.checkPatientCanBeDeletable({}, function(res){
        if(!res){
          Ext.MessageBox.alert("Status", "Patient cannot be deleted.<br/><br/> <b>Reason:</b><br/><br/>1. Patient contains Referrals.")
        } else {
          var main_app = Ext.ComponentQuery.query("#app")[0];
          main_app.loadPatientsList();
        }
      }, this);
    }
  JS

  endpoint :check_patient_can_be_deletable do |params|
    patient = Patient.find(config[:record_id])
    res = patient.can_delete?
    res = patient.destroy if res
    {:set_result => res}
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end

end