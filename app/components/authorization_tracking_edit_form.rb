class AuthorizationTrackingEditForm <  Mahaswami::FormPanel
  include ButtonsOfOasisHeader
  def configuration
    c = super
    component_session[:auth_id] ||= c[:record_id] if c[:record_id]
    c.merge(
        model: "AuthorizationTracking",
        item_id: :authorization_edit_form,
        bbar: c[:bbar],
        recordIdPresent: c[:record_id].present?,
        margin: '5%',
        items: [
            {
                layout: :hbox,
                border: false,
                margin: "5% 5% 5% 100%",
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
                     { name: :patient__full_name, flex: 0.5, field_label: "Patient",  allow_blank: false, width: '50%', label_align: 'right',
                       label_width: '62%', item_id: "patient_id" },
                    { name: :discipline_id, flex: 0.5, xtype: 'combo', field_label: "Discipline", store: Discipline::DISCIPLINE_DESCRIPTION_COMBO_STORE_DISPLAY,
                        allow_blank: false, width: '50%', label_align: 'right',label_width: '62%', item_id: :discipline }
                ]
            },
            {
                layout: :hbox,
                border: false,
                margin: "5%",
                items:[
                    { name: :treatment_episode__to_s, flex: 0.5, field_label: "Episode", allow_blank: false, width: '50%',
                        label_align: 'right',label_width: '62%', item_id: :episode_id},
                    { name: :field_staff__to_s, flex: 0.5, field_label: "Field Staff", allow_blank: false, width: '50%',
                        label_align: 'right',label_width: '62%', item_id: :field_staff }
                ]
            },
            {
                layout: :hbox,
                border: false,
                margin: "5%",
                items:[
                    { name: :insurance_company__company_name, flex: 0.5, field_label: "Insurance", allow_blank: false, width: '50%',
                        label_align: 'right',label_width: '62%', item_id: :insurance_company },
                    { name: :visit_count, field_label: "Visits", allow_blank: false, width: '50%', label_align: 'right',
                        label_width: '62%' }
                ]
            },
            {
                layout: :hbox,
                border: false,
                margin: "5%",
                items:[
                    { name: :patient_number, flex: 0.5, field_label: "Insurance ID", allow_blank: false, width: '50%', label_align: 'right',
                        label_width: '62%', item_id: "patient_number" },
                    { name: :start_date, field_label: "Start Date", allow_blank: false, width: '50%', label_align: 'right',
                        label_width: '62%' }
                ]
            },
            {
                layout: :hbox,
                border: false,
                margin: "5%",
                items:[
                    { name: :insurance_case_manager__full_name, flex: 0.5, field_label: "Case Manager", width: '50%', label_align: 'right',
                        label_width: '62%', item_id: :insurance_case_manager },
                    { name: :end_date, flex: 0.5, field_label: "End Date", allow_blank: false, width: '50%',  label_align: 'right',
                        label_width: '62%' },
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

            { name: :special_instructions, rows: 5, field_label: "Special Instructions", margin: '5%',
                label_align: 'right', label_width: '24%' },

            { name: :internal_comments, rows: 5, field_label: "Internal Comments", margin: '5%',
                label_align: 'right', label_width: '24%' }

        ]

    )
  end

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.resetSessionContext();
      var field_staff = this.down('#field_staff');
      var store = this.down('#field_staff').store;
      store.on('load', function(res){
        store.removeAt(0);
        store.insert(0,{field1: 0, field2: 'Pending Staffing'}, true);
      });
      this.down('#episode_id').on('select', function(res){
        this.setEpisodeId({episode_id: res.value});
      },this);
    }
  JS

  js_method :after_render, <<-JS
    function() {
      this.callParent();
      var patientNum = this.down('#patient_number');
      var caseManager = this.down('#insurance_case_manager');
      var field_staff = this.down('#field_staff');
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
      if(field_staff.value == 0){
        field_staff.setValue('Pending Staffing');
      }
      this.patientOnChangeEvent(patientNum,caseManager);
      this.insuranceCompanyChangeEvent(patientNum);
      this.down('#discipline').on('select', function(res){
        this.setDisciplineId({discipline_id: res.value});
      },this);
    }
  JS

  js_method :patient_on_change_event, <<-JS
    function(patientNum,caseManager){
      this.down("#patient_id").on("select", function(val){
        this.selectPatientId({patient_id: val.value}, function(){
          patientNum.setValue(' ');
          caseManager.setValue(' ');
          var item_ids = ['episode_id', 'insurance_company'];
          Ext.each(item_ids, function(item_id) {
            var cmp = this.down('#'+item_id);
              cmp.store.on('load', function(self, params) {
                if (self.getCount() >= 2 && self.getAt(0).get("field1") == null) {
                  this.setValue(self.getAt(1));
                  this.fireEvent('select', this);
                }
              }, cmp);
            }, this);
        },this);
      },this);
    }
  JS

  js_method :insurance_company_change_event, <<-JS
    function(patientNum){
      this.down("#insurance_company").on("select", function(val){
      patientNum.setValue(' ');
        this.setInsId({ins_id: val.value}, function(res){
        patientNum.setValue(res);
        var cmp = this.down('#insurance_case_manager');
          cmp.reset();
          cmp.store.reload();
          cmp.store.on('load', function(self, params) {
            if (self.getCount() >= 2 && self.getAt(0).get("field1") == null) {
              this.setValue(self.getAt(1));
              this.fireEvent('select', this);
            }
          }, cmp);
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

  endpoint :set_episode_id do |params|
    component_session[:episode_id] = params[:episode_id]
  end

  endpoint :set_discipline_id do |params|
    component_session[:discipline_id] = params[:discipline_id]
     {refresh_combo_store: :field_staff}
  end

  def insurance_company__company_name_combobox_options(params)
    patient_id = component_session[:patient_id] || AuthorizationTracking.find(component_session[:tracking_id]).patient_id
    values = PatientInsuranceCompany.where({patient_id: patient_id})
    res = values.collect{|i| [i.insurance_company_id, i.insurance_company.to_s]}
    {data: res}
  end

  def patient__full_name_combobox_options(params)
    data = if params[:query].blank?
             Patient.admitted_patients.all
           else
             query = "#{params[:query].upcase}%"
             Patient.admitted_patients.where(["upper(first_name) LIKE ? or upper(last_name) LIKE ?", query, query])
           end
    {data: data.collect{|d| [d.id, d.full_name]}}
  end

  def insurance_case_manager__full_name_combobox_options(params)
    insurance_company = InsuranceCompany.org_scope.where(id: component_session[:ins_id]).first
    values = insurance_company.insurance_case_managers.collect{|i| [i.id, i.full_name]}
    {data: values}
  end


  def treatment_episode__to_s_combobox_options(params)
    list = []
    treatment_id = Patient.org_scope.where(id: component_session[:patient_id]).first.treatments.last.id
    PatientTreatment.org_scope.where(id: treatment_id).first.treatment_episodes.each{|e| list << [e.id, e.certification_period]} unless treatment_id.nil?
    {data: list.reverse}
  end

  def field_staff__to_s_combobox_options(params)
    discipline_id = component_session[:discipline_id]
    field_staffs =  FieldStaff.field_staffs_by_discipline(discipline_id)
    data = if params[:query].blank?
             field_staffs.collect{|s| [s.id, s.to_s]}
           else
             query = "#{params[:query].upcase}%"
             values = field_staffs.empty??  [] : field_staffs.where(["upper(first_name) LIKE ? or upper(last_name) LIKE ?", query, query])
             values = values.reject{|x| x.clinical_staff.present?}
             values.collect!{|x| [x.id, x.full_name]}
           end
    {data: data}
  end

  endpoint :set_ins_id do |params|
    component_session[:ins_id] = params[:ins_id]
    ins = PatientInsuranceCompany.org_scope.where(insurance_company_id: component_session[:ins_id], patient_id: component_session[:patient_id]).first
    res = ins.patient_insurance_number if ins.present?
    {refresh_combo_store: [:insurance_case_manager]}
    {set_result: res}
  end

  endpoint :select_patient_id do |params|
    component_session[:patient_id] = params[:patient_id]
    {refresh_combo_store: [:episode_id, :insurance_company]}
  end


  endpoint :reset_session_context do |params|
    record = AuthorizationTracking.org_scope.find(component_session[:auth_id])
    component_session[:patient_id] = record.patient_id
    component_session[:ins_id] = record.insurance_company_id
    component_session[:discipline_id] = record.discipline_id
    component_session[:episode_id] = record.treatment_episode_id
  end

end