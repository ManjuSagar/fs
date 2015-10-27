class ScheduleAuthorizationTrackingForm < Mahaswami::FormPanel
  include ButtonsOfOasisHeader
  include ScheduleAuthorizationTrackingRelatedMethods

  def configuration
    s = super
    episode_id = s[:episode_id]
    component_session[:episode_id] = s[:episode_id]
    treatment_episode = TreatmentEpisode.org_scope.find(episode_id)
    treatment_request = treatment_episode.treatment.treatment_request
    insurance_company_id = treatment_request.insurance_company_id
    s.merge(
      model: "AuthorizationTracking",
      item_id: :authorization_new_form,
      margin: '5%',
      items: [
        {
          layout: :hbox,
          border: false,
          margin: '5% 5% 5% 100%',
          items:[
            { name: :reported, field_label: '', box_label: 'Reported', flex: 0.7 },
            { name: :evaluation_sent, field_label: '',box_label: 'Evaluation Sent', flex: 0.9 },
            { name: :approval_received, field_label: '',box_label: 'Approval Received', flex: 1 },
            { name: :visit_done, field_label: '',  box_label: 'Visits Done', flex: 1 },
          ]
        },
        {
          layout: :hbox,
          border: false,
          margin: "5%",
          items:[
            {name: :patient_id, flex: 0.5, xtype: 'combo', store: episode_patient_name, field_label: "Patient", allow_blank: false, width: '50%', label_align: 'right',
             label_width: '62%', item_id: "patient_id", read_only: true},
            { name: :discipline_id, xtype: 'combo', flex: 0.5,field_label: "Discipline", store: Discipline::DISCIPLINE_DESCRIPTION_COMBO_STORE_DISPLAY,
                allow_blank: false, width: '50%', label_align: 'right',label_width: '62%', item_id: :discipline }
          ]
        },
        {
          layout: :hbox,
          border: false,
          margin: "5%",
          items:[
            { name: :treatment_episode_id, flex: 0.5, xtype: 'combo', store: patient_episode, field_label: "Episode", allow_blank: false, width: '50%', label_align: 'right',
              label_width: '62%', item_id: :episode_id, read_only: true },
            { name: :field_staff__to_s, flex: 0.5, field_label: "Field Staff", allow_blank: false, width: '50%', label_align: 'right',
              label_width: '62%', item_id: :field_staff }
          ]
        },
        {
          layout: :hbox,
          border: false,
          margin: "5%",
          items:[
            { name: :insurance_company__company_name, xtype: 'combo', store: insurance_company_store, flex: 0.5, field_label: "Insurance", allow_blank: false, width: '50%',
              label_align: 'right', label_width: '62%', item_id: :insurance_company },
            { name: :visit_count, flex: 0.5, field_label: "Visits", allow_blank: false, width: '50%', label_align: 'right',
              label_width: '62%' }
          ]
        },
        {
          layout: :hbox,
          border: false,
          margin: '5 5 5 5',
          items:[
            { name: :patient_number, flex: 0.5, field_label: "Insurance ID", allow_blank: false, width: '50%', label_align: 'right',
              label_width: '62%', item_id: "patient_number" },
            { name: :start_date, field_label: "Start Date", allow_blank: false, width: '50%',
                label_align: 'right', label_width: '62%' }
          ]
        },
        {
          layout: :hbox,
          border: false,
          margin: "5%",
          items:[
              { name: :insurance_case_manager__full_name, flex: 0.5, field_label: "Case Manager", width: '50%', label_align: 'right',
                label_width: '62%', item_id: :insurance_case_manager},
            { name: :end_date, flex: 0.5, field_label: "End Date", allow_blank: false, width: '50%',
              label_align: 'right', label_width: '62%' }
          ]
        },
        {
          layout: :hbox,
          border: false,
          margin: "5%",
          items:[
            { name: :authorization_number, xtype: 'textfield', field_label: "Authorization Number", width: '50%',
              label_align: 'right', label_width: '62%'},
          ]
        },
        { name: :special_instructions, rows: 5, field_label: "Special Instructions", label_align: 'right',
          label_width: '24%', margin: '5%' },
        { name: :internal_comments, rows: 5, field_label: "Internal Comments", label_align: 'right',
          label_width: '24%', margin: '5%' }

      ]
    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var item_ids = ['patient_id', 'episode_id', 'insurance_company', 'field_staff'];
      Ext.each(item_ids, function(item_id){
        var fieldName = Ext.ComponentQuery.query('#'+item_id)[0];
        var store = fieldName.store;
        fieldName.setValue(store.getAt(0));
      });
       var cmp = this.down('#insurance_case_manager');
          cmp.reset();
          cmp.store.reload();
          cmp.store.on('load', function(self, params) {
            if (self.getCount() >= 2 && self.getAt(0).get("field1") == null) {
              this.setValue(self.getAt(1));
              this.fireEvent('select', this);
            }
          }, cmp);
      var insuranceNumber = this.down('#patient_number');
      var insCaseManager = this.down('#insurance_case_manager');
        this.getPatientPrimaryInsuranceNumber({},function(res){
          insuranceNumber.setValue(res);
        },this);
      this.insuranceCompanyChangeEvent(insuranceNumber, insCaseManager);
      this.down('#discipline').on('select', function(res){
        this.setDisciplineId({discipline_id: res.value});
      },this);
      var store = this.down('#field_staff').store;
      store.on('load', function(res){
        store.removeAt(0);
        store.insert(0,{field1: 0, field2: 'Pending Staffing'}, true);
      });
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      var w = this.up('window');
      var orders = w.down('#view_orders');
      var form = this;
      orders.on('click', function(){
        var episodeId = form.down('#episode_id').value;
        if(episodeId){
          form.onViewOrders();
        } else {
          Ext.MessageBox.alert("Status", "Select an episode to view medical orders.");
        }
      });
    }
  JS

 js_method :insurance_company_change_event, <<-JS
   function(insuranceNumber, insCaseManager){
     this.down("#insurance_company").on("select", function(val){
       insuranceNumber.setValue(' ');
       insCaseManager.setValue(' ');
       this.setInsId({ins_id: val.value}, function(res){
         insuranceNumber.setValue(res);
       },this);
       this.setCaseManager({ins_id: val.value}, function(res){
         var insCaseManagerStore = this.down('#insurance_case_manager').store;
         var insCaseManager = this.down('#insurance_case_manager');
         insCaseManagerStore.removeAll();
         insCaseManagerStore.add(res);
         insCaseManager.setValue(insCaseManagerStore.getAt(0));
       },this);
     },this);
   }
 JS

  component :medical_orders do
    episode = TreatmentEpisode.org_scope.where(id: component_session[:episode_id]).first
    treatment_id = episode.treatment.id if episode
    {
        class_name: "MedicalOrders",
        parent_id: treatment_id,
        treatment_id: treatment_id,
        episode_id: component_session[:episode_id],
        episode_orders: true,
        header: false
    }
  end

  def insurance_company_store
    result = []
    primary_insurance = PatientInsuranceCompany.org_scope.where({patient_id: component_session[:patient_id]}).order(:primary_insurance_flag)
    primary_insurance.each do |ins|
      result << [ins.insurance_company_id, ins.insurance_company.to_s]
    end
    component_session[:primary_insurance_number] = primary_insurance.first.patient_insurance_number
    component_session[:ins_id] = primary_insurance.first.insurance_company_id
    result
  end

  def insurance_case_managers_store
    result = []
    insurance_company = InsuranceCompany.org_scope.where(id: component_session[:ins_id]).first
    case_managers = insurance_company.insurance_case_managers
    case_managers.each do |case_manager|
      res = [case_manager.id, case_manager.full_name]
      result << res
    end
    result
  end

end