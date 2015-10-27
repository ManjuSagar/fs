class PatientDetails < Mahaswami::SubPanel

  def configuration
    c = super
    component_session[:treatment_id] = c[:treatment_id] if c[:treatment_id]
    component_session[:record_id] = c[:record_id] if c[:record_id]
    treatment = PatientTreatment.find(component_session[:treatment_id])
    if c[:visit_id]
      visit = treatment.treatment_visits.unscoped.find(c[:visit_id])
    end
    @org = treatment.agency
    c.merge(
        header: false,
        border: false,
        visitIdPresent: c[:visit_id].present?,
        isClinicalStaff: User.current.clinical_staff?,
        recordIdPresent: c[:record_id].present?,
        currentUser: User.current.id,
        coSignFlag: treatment.co_signature_optional?,
        item_id: 'patient_details',
        items: [
            {
                xtype: 'borderlessFormPanel',
                margin: '0 0 0 10px',
                layout: {
                    columns: 6,
                    type: 'table'
                },
                items: [
                    {
                        xtype: 'textfield',
                        fieldLabel: 'Patient Name:',
                        name: 'patient_name',
                        editable: false,
                        readOnly: true,
                        hidden: true,
                        labelAlign: 'right'
                    },
                    {
                        xtype: 'textfield',
                        fieldLabel: 'MR#',
                        name: 'mr',
                        hidden: true,
                        editable: false,
                        readOnly: true,
                        labelAlign: 'right'
                    },{
                        xtype: 'combo',
                        fieldLabel: 'Physician:',
                        item_id: :physician_id,
                        name: "physician_id",
                        allowBlank: false,
                        editable: false,
                        label_width: 70,
                        margin: '0 5px 10px 0',
                        store: physician_store(c[:treatment_id], c[:visit_id])
                    }
                ] + field_staff_information_columns(c[:treatment_id], c[:visit_id]) +
                (c[:items] ? c[:items] : []) +
                    (c[:display_frequency_in_eval_form] ? [
                        {
                            xtype: 'textfield',
                            fieldLabel: 'Frequency',
                            name: :frequency,
                            item_id: :frequency,
                            label_align: "right",
                            margin: '0 5px 10px 0',
                            label_width: 90,
                            afterLabelTextTpl: '<a style="cursor:pointer;" onclick="Ext.ComponentQuery.query(\'#patient_details\')[0].displayAcceptableFormats();">
          <img style="postion:relative;top:100px" src="/assets/icons/information.png" class="info_image" data-qtip="Information"></img></a>'
                        }] : []) +
                    (User.current.office_staff? ? [{
                     xtype: 'checkbox',
                     field_label: "",
                     box_label: 'Field Signature Not Required',
                     item_id: :field_signature_not_required,
                     name: "field_signature_not_required",
                     inputValue: true,
                     margin: '0 5px 10px 0',
                 }] : [])
            }
        ]
    )

  end

  def field_staff_information_columns(treatment_id, visit_id)
    [{
                                 xtype: 'combo',
                                 field_label: 'Episode',
                                 name: 'treatment_episode_id',
                                 itemId: 'patient_treatment_episode',
                                 allowBlank: false,
                                 label_width: 70,
                                 margin: '0 5px 10px 0',
                                 store: episode_store(treatment_id)
                             },
                             {
                                 xtype: 'combo',
                                 field_label: 'Field Staff',
                                 name: 'field_staff_id',
                                 item_id: :field_staff_id,
                                 allowBlank: false,
                                 label_width: 70,
                                 margin: '0 5px 10px 0',
                                 agency_staff: User.current.office_staff?,
                                 readOnly: (User.current.field_staff? and !User.current.clinical_staff?),
                                 store: field_staff_store(treatment_id)
                             },
                             {
                                 xtype: 'combo',
                                 field_label: 'Sup. User',
                                 name: 'supervised_user_id',
                                 allowBlank: false,
                                 item_id: :supervised_user_id,
                                 label_width: 70,
                                 size: 17,
                                 margin: '0 5px 10px 0',
                                 store: supervised_user_store(treatment_id)
                             },
                             {
                                 xtype: 'datefield',
                                 fieldLabel: 'Date:',
                                 value: Date.current,
                                 name: :document_date,
                                 allowBlank: false,
                                 label_width: 50,
                                 size: 14,
                                 margin: '0 5px 10px 0',
                             }
    ]
  end

  def physician_store(treatment_id, visit_id)
    return [] if treatment_id.nil? and visit_id.nil?
    list = [[nil, "---"]]
    treatment = treatment_id ? PatientTreatment.find(treatment_id) : TreatmentVisit.find(visit_id).treatment
    treatment.treatment_physicians.collect{|tp| list << [tp.physician.id, tp.physician.full_name]}
    list.uniq
  end

  def episode_store(treatment_id)
    list = [[nil, "---"]]
    PatientTreatment.find(treatment_id).treatment_episodes.each{|e| list << [e.id, e.certification_period]} unless treatment_id.nil?
    list.uniq
  end

  def field_staff_store(treatment_id)
    list = [[nil, "---"]]
    list << [User.current.id, User.current.full_name] if User.current.clinical_staff?
    PatientTreatment.find(treatment_id).treatment_staffs.select{|s| s.staff_type == "User"}.each{|s| list << [s.staff.id, s.staff.full_name]} unless treatment_id.nil?
    list.uniq
  end

  def supervised_user_store(treatment_id)
    list = [[nil, "---"]]
    PatientTreatment.find(treatment_id).treatment_staffs.select{|s| s.staff_type == "User" and s.staff.license_type.independent_flag}.each{|s| list << [s.staff.id, s.staff.full_name]} unless treatment_id.nil?
    list.uniq
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
	  var formScope = this;
      var episode = this.down("[name=treatment_episode_id]");
      var documentDate = this.down("[name=document_date]");
      var fieldStaff = this.down('#field_staff_id');
      var supervisor = this.down('#supervised_user_id');
      var signDate = Ext.ComponentQuery.query("#sign_date")[0];
      var signPwd = Ext.ComponentQuery.query("#sign_password")[0];
      var fieldSignNotRequired = this.down("#field_signature_not_required");
      if (this.visitIdPresent) {
        episode.hide();
        documentDate.hide();
        fieldStaff.hide();
        supervisor.hide();
      }

      if(fieldStaff){
        if(fieldSignNotRequired){
          fieldStaff.on('change', function(ele){
            if (ele.value == this.currentUser && this.docIsDraft){
              fieldSignNotRequired.setValue(false);
              fieldSignNotRequired.setDisabled(true);
            }else{
              fieldSignNotRequired.setDisabled(false);
            }
            this.setSaveButtonsText(fieldSignNotRequired, fieldStaff.value);
          },this);
        }
      }

      if(supervisor){
        supervisor.hide();
        fieldStaff.on('change', function(ele){
          if(ele.value){
            this.checkFieldStaffIsIndependent({field_staff_id: ele.value}, function(result){
              if(result){
                supervisor.hide();
                supervisor.setValue();
                this.updateSupervisorSignFlagFalse({record_id: this.recordId});
              }else{
                  this.updateSupervisorSignFlagTrue({record_id: this.recordId});
                  if(this.recordIdPresent){
                    this.setSupervisedUser({record_id: this.recordId}, function(result){
                      supervisor.setValue(result);
                    });
                  }
                if(this.visitIdPresent == false){
                  supervisor.show();
                }
                if(ele.readOnly == true){
                  supervisor.readOnly = true;
                }
              }
            }, this);
          }
        }, this);
      }

      Ext.each(this.query('combo'), function(cmp) {
        cmp.store.on('load', function(self, params) {
          var modelName = cmp.parentId + "_" + cmp.name;
          if (self.getCount() > 2 && self.getAt(0).get("field1") == null) {
              if(!this.recordIdPresent && cmp.name != 'field_staff_id'){
                this.setValue(self.getAt(1));
                this.fireEvent('select', this);
              } else if(cmp.agencyStaff == true && cmp.name == 'field_staff_id'){
                this.setValue(self.getAt(0));
                this.fireEvent('select', this);
              }else if(cmp.agencyStaff != true && cmp.name == 'field_staff_id'){
                formScope.getFieldStaff({}, function(res){
                  if(res){
                   cmp.setValue(res);
                  }
                }, formScope);
              }
          }
        }, cmp);
      }, this);
      this.refreshComboStore("physician_id");
      var physician = this.down("[name=physician_id]");
      var window = this.up("window");
      var npi = window.down("[name=m0018_physician_id]");
      physician.on('change', function(ele){
        this.getNpiNumber({physician_id: ele.value}, function(res){
          npi.setValue(res);
        },this);
      },this);
      if(this.query("combo#field_staff_id")[0]) this.refreshComboStore("field_staff_id");


      if ( fieldSignNotRequired ) {
        this.setSaveButtonsText(fieldSignNotRequired, fieldStaff.value);
        fieldSignNotRequired.on('change', function(ele){
          this.setSaveButtonsText(fieldSignNotRequired, fieldStaff.value);
        }, this);
      }
    }
  JS

  js_method :set_save_buttons_text,<<-JS
    function(fieldSignNotRequired, fieldStaff){
      var window = this.up("window");
      if(fieldSignNotRequired.value) {
        if ( this.docIsDraft ) window.actions.ok.setText("Submit for QA");
        if ( this.saveDraftRequired ) window.actions.saveDraft.show();
      } else {
        window.actions.ok.setText("");
        window.actions.ok.setIconCls("ok_icon");
        window.actions.saveDraft.hide();
      }

      var signDate = Ext.ComponentQuery.query("#sign_date")[0];
      var signPwd = Ext.ComponentQuery.query("#sign_password")[0];
      this.getSupervisor({record_id: this.recordId},function(res){
      if(res[0]){
        if(this.docIsDraft && res[1] && this.isClinicalStaff && (res[0] == this.currentUser) && !fieldSignNotRequired.value){
          if(this.coSignFlag == false && !res[2]){
              signDate.hide();
              signPwd.hide();
          }else{
              signDate.show();
              signPwd.show();
          }
        } else if(this.docIsDraft && (fieldStaff == this.currentUser) && !fieldSignNotRequired.value){
            signDate.show();
            signPwd.show();
        } else {
            signDate.hide();
            signPwd.hide();
        }
      }
     },this);
    }
  JS

  js_method :refresh_combo_store, <<-JS
    function(item_ids) {
      item_ids = Ext.isArray(item_ids) ? item_ids : [item_ids]
      Ext.each(item_ids, function(item_id) {
        var cmp = this.query("combo#" + item_id)[0];
        cmp.reset();
        cmp.store.reload();
        console.log("Reloading Store of - " + item_id);
      }, this);
    }
  JS

  js_method :displayAcceptableFormats, <<-JS
    function(){
      var w = new Ext.window.Window({
          width: 400,
          height: 400,
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "Close",
              listeners: {
                click: function(){
                  w.close();
                }
              }
            }
          ],
          title: "Frequency formats",
        });
        w.show();
        this.loadNetzkeComponent({name: "frequency_information", container:w, callback: function(w){
          w.show();
        }});
    }
  JS

  component :frequency_information do
    {
        class_name: "FrequencyInformation",
        where_its_used: :evaluation
    }
  end

  endpoint :set_supervised_user do |params|
    user = Document.find(params[:record_id]).supervised_user
    {:set_result => [user.id, user.full_name]}
  end

  endpoint :check_field_staff_is_independent do |params|
    user = User.find_by_id(params[:field_staff_id])
    result = user.present?? user.license_type.independent_flag : true
    {:set_result => result}
  end

  endpoint :get_npi_number do |params|
    npi_number =  if params[:physician_id]
                    physician = Physician.find(params[:physician_id])
                    physician.npi_number
                  else
                    " "
                  end
    {set_result: npi_number}
  end

  endpoint :get_field_staff do |params|
    fs = Document.find(component_session[:record_id]).field_staff
    {set_result: fs.id}
  end

  endpoint :get_supervisor do |params|
    if params[:record_id]
      doc = Document.org_scope(@org).find(params[:record_id])
      {:set_result => [doc.supervised_user_id, doc.supervisor_sign_required, doc.fs_sign_date? ]}
    else
      {:set_result => [false]}
    end
  end

  endpoint :update_supervisor_sign_flag_true do |params|
    if params[:record_id]
      doc = Document.org_scope(@org).find(params[:record_id])
      doc.update_column(:supervisor_sign_required, true)
    end
  end

  endpoint :update_supervisor_sign_flag_false do |params|
    if params[:record_id]
      doc = Document.org_scope(@org).find(params[:record_id])
      doc.update_column(:supervisor_sign_required, false)
    end
  end

end
