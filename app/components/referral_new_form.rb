class ReferralNewForm < Mahaswami::FormPanel

  def configuration
    c = super
    @set_disabled = false
    if c[:record_id]
      treatment_request = TreatmentRequest.find(c[:record_id])
      @set_disabled = treatment_request.patient_admitted?
    end

    c.merge(
        model: "TreatmentRequest",
        record: TreatmentRequest.new(patient_id: c[:patient_id]),
        item_id: :referral_new_form,
        items: [
            {name: :patient__full_name, field_label: "Patient", scope: :org_scope, allow_blank: false, item_id: :patient_id},
            {name: :request_date, field_label: "Referral Date"},
            {
                layout: 'hbox',
                border: false,
                items: [
                    {name: :referred_physician__full_name, field_label: "Referring Physician",allow_blank: false, flex:1, margin: '0 5 0 0' },
                    {xtype: 'button', text: 'Add New Physician', item_id: 'add_physician', cls: 'blue-color-button'}
                ]
            },
            {name: :insurance_company__company_name, field_label: "Primary Insurance Company", item_id: :insurance_company, allow_blank: false},
            {name: :insurance_case_manager__full_name, field_label: "Insurance Company Case Manager", item_id: :insurance_company_case_mgr, editable: false},
            {name: :certification_period, field_label: "Certification Period", item_id: :certification_period, minValue: 0, hideTrigger: true, hidden: true, keyNavEnabled: false, mouseWheelEnabled: false },
            {
                xtype: 'radiogroup',
                fieldLabel: 'Bill Insurance',
                labelSeparator: ' ',
                layout: {
                    type: 'hbox',
                    align: 'stretch'
                },
                disabled: @set_disabled,
                items: [
                    {xtype: 'radiofield', name: :insurance_bill_type, field_label: '', width: 80, boxLabel: 'Per Visit', inputValue: 'V' },
                    {xtype: 'radiofield', name: :insurance_bill_type, field_label: '', width: 80, boxLabel: 'Hourly', inputValue: 'H'}
                ]
            },{
            xtype: 'radiogroup',
            fieldLabel: 'Pay Field Staff',
            labelSeparator: ' ',
            layout: {
                type: 'column',
            },
            disabled: @set_disabled,
            items: [
                {xtype: 'radiofield', name: :field_staff_bill_type, width: 80, field_label: '', boxLabel: 'Per Visit', inputValue: 'V' },
                {xtype: 'radiofield', name: :field_staff_bill_type, width: 80, field_label: '', boxLabel: 'Hourly', inputValue: 'H'}
            ]

        },
            :disciplines.component,
            {xtype: 'label',
             html: "Please edit disciplines in the Disciplines page of the patient chart",
             cls: 'disciplines_edit_msg',
             hidden: (@set_disabled == false),
             style: {
                 marginLeft: "160px"
                }
             },
            :visit_types.component,
            {name: :preferred_gender, field_label: "Preferred Gender", xtype: :combo, store: TreatmentRequest::PREFERRED_GENDER_MAP},
            {name: :special_instructions, field_label: "Special Instructions"},
            {
                header: false,
                border: false,
                margin: '0 0 5px 155px',
                layout: :hbox,
                items: [
                    {name: :lang_mandatory_flag, field_label: "", boxLabel: "Language Mandatory", flex: 1},
                    {name: :si_mandatory_flag, field_label: "", boxLabel: "Special Instructions Mandatory", flex: 1.40},
                ]
            },
            {
                header: false,
                border: false,
                margin: '0 0 10px 155px',
                layout: :hbox,
                items: [
                    {name: :referral_received_flag, field_label: "", boxLabel: "Referral Received", item_id: :referral_received_flag, flex: 1},
                    {name: :transfer_from_hha, field_label: "", boxLabel: "Transferred from Another HHA",
                     xtype: "checkbox", input_value: "Y", flex: 1.40},
                ]
            },
            {name: :referral_received_date, field_label: "Referral Received Date", hidden: true, item_id: :referral_received_date},
            {name: :point_of_origin, field_label: "Point Of Origin", xtype: :combo, store: TreatmentRequest::POINT_OF_ORIGIN },
        ]
    )
  end

  component :disciplines do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        columns: 6,
        assoc_records: Discipline.order("sort_order"),
        allow_blank: false,
        disabled: @set_disabled,
        association: :disciplines
    }
  end

  component :visit_types do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        columns: 3,
        association: :visit_types,
        scope: :without_discipline
    }
  end

  def insurance_company__company_name_combobox_options(params)
    values = PatientInsuranceCompany.where({patient_id: component_session[:patient_id]})
    values.collect!{|i| [i.insurance_company_id, i.insurance_company.to_s]}
    {data: values}
  end

  def insurance_case_manager__full_name_combobox_options(params)
    insurance_company = InsuranceCompany.find(component_session[:insurance_company_id])
    values = insurance_company.insurance_case_managers.collect!{|i| [i.id, "#{i.full_name} #{i.phone_number}"]}
    {data: values}
  end

  def patient__full_name_combobox_options(params)
    data = if params[:query].blank?
             Patient.org_scope.all
           else
             query = "#{params[:query].upcase}%"
             Patient.org_scope.where(["upper(first_name) LIKE ? or upper(last_name) LIKE ?", query, query])
           end
    {data: data.collect{|d| [d.id, d.full_name]}}
  end

  def referred_physician__full_name_combobox_options(params)
    data = if params[:query].blank?
             Physician.physician_agency_specific.all
           else
             query = "#{params[:query].upcase}%"
             Physician.physician_agency_specific.where(["upper(first_name) LIKE ? or upper(last_name) LIKE ?", query, query])
           end
    {data: data.collect{|d| [d.id, d.full_name]}}
  end

  js_method :init_component, <<-JS
    function() {
      this.callParent();

      this.down("#patient_id").on('change', function(ele){
        this.selectPatientId({patient_id: ele.value});
      }, this);

      this.down('#insurance_company').on('change', function(ele){
       if(ele.value){
         this.validateCertificationPeriod({insurance_company_id: ele.value});
       }else
        this.down("#certification_period").hide().reset();

       this.selectInsuranceCompanyId({insurance_company_id: ele.value});
      }, this);

      this.down('#referral_received_flag').on("change", function(ele){
        if(ele.value == true){
          this.down("#referral_received_date").show();
          this.down("#referral_received_date").setValue(new Date());
        }else{
          this.down("#referral_received_date").hide();
          this.down("#referral_received_date").setValue("");
        }
      }, this);

        var addPhy = Ext.ComponentQuery.query('#add_physician')[0]
        addPhy.on('click', function() {
          this.formDisplayComponent();
        }, this);
      }
  JS


  js_method :form_display_component, <<-JS
  function() {
    var w = new Ext.window.Window({
      width: '50%',
      modal: true,
      border: false,
      layout:'fit',
      title: "Add Physician",
      buttons: [
        {
          text: "", tooltip: "OK", iconCls: "ok_icon",
             listeners: {
                click: function(){
                  var form = Ext.ComponentQuery.query('#physician_form')[0];
                  form.on("submitsuccess", function(){
                    w.closeRes = "ok";
                    this.close();
                }, w);
                form.onApply();
                }
             }
        },
        {
          text: "", tooltip: "Cancel", iconCls: "cancel_icon", listeners: { click: function() {w.close();} }
        }
      ]

    });
    w.show();
    this.loadNetzkeComponent({name: "add_physician_form", container:w, callback: function(w){
      w.show();
    }});
  }
  JS

  component :add_physician_form do
    {
        class_name: "PhysicianForm",
        header: false,
        lazy_loading: true,
        bbar: false
    }
  end

   endpoint :select_patient_id do |params|
     component_session[:patient_id] = params[:patient_id]
     {refresh_combo_store: :insurance_company}
   end

  endpoint :select_insurance_company_id do |params|
    component_session[:insurance_company_id] = params[:insurance_company_id]
    {refresh_combo_store: :insurance_company_case_mgr}
  end
   
   endpoint :validate_certification_period do |params|      
      cp = InsuranceCompany.find(params[:insurance_company_id]).certification_period
      result = cp == 0
      {:show_hide_certification_period => result}
   end
   
   js_method :show_hide_certification_period, <<-JS
     function(result){
      if(result)
        this.down("#certification_period").show();
      else
        this.down("#certification_period").hide().reset();      
     }
   JS
end