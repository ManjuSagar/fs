class SuperVisoryVisits < Mahaswami::SubPanel
  def configuration
    c = super
    @treatment = PatientTreatment.find(c[:treatment_id]) if c[:treatment_id]
    @treatment_staffs = @treatment.treatment_staffs
    c.merge(
        header: false,
        border: false,
        bodyPadding: 10,
        currentUser: User.current.id,
        items:[
            {
                xtype: 'panel',
                border: 0,
                padding: '5px',
                layout: {
                    align: 'stretch',
                    type: 'hbox'
                },
                items:
                    [
                        {
                            xtype: 'combo',
                            fieldLabel: 'Physician',
                            item_id: :physician_id,
                            name: :physician_id,
                            allowBlank: false,
                            editable: false,
                            label_width: 70,
                            readOnly: false,
                            margin: '0 5px 10px 0',
                            store: physician_store(c[:treatment_id], c[:visit_id])
                        },
                        {
                            xtype: 'datefield',
                            fieldLabel: 'Date',
                            name: :document_date,
                            value: Date.current,
                            allowBlank: false,
                            labelAlign: 'right',
                            label_width: 30,
                            margin: '0 5px 10px 0',
                        },
                        {
                            xtype: 'combo',
                            fieldLabel: 'Supervisor',
                            name: 'supervised_user_id',
                            item_id: :supervised_user_id,
                            labelAlign: 'right',
                            label_width: 70,
                            margin: '0 5px 10px 0',
                            store: supervised_user_store
                        },
                        {
                            xtype: 'combo',
                            fieldLabel: 'Field Staff',
                            name: 'field_staff_id',
                            item_id: :field_staff_id,
                            labelAlign: 'right',
                            label_width: 70,
                            margin: '0 5px 10px 0',
                            store: fs_and_sc_store
                        },
                        {
                            xtype: 'radiogroup',
                            labelWidth: '10%',
                            flex: 0.1,
                            items:
                                [
                                    {
                                        xtype: 'radiofield',
                                        boxLabel: 'Present',
                                        name: 'present',
                                    },
                                    {
                                        xtype: 'radiofield',
                                        boxLabel: 'Not Present',
                                        name: 'present'
                                    }
                                ]
                        }
                    ]
            }
        ]
    )
  end

  def fs_and_sc_store
    list = [[nil, "---"]]
    sc_fs = []
    @treatment_staffs.select{|s| s.staff_type == "User" and s.staff.license_type.independent_flag}.each{|s| list << [s.staff.id, s.staff.full_name]} if @treatment
    @treatment_staffs.select{|s| s.staff_type == "Org"}.collect{|sc| sc.staff_id}.each{|sc_id| sc_fs << StaffingCompany.find(sc_id)}
    sc_fs.each{|sc| sc.staffs.collect{|s| list << [s.id, s.full_name]}}
    list.uniq
  end

  def supervised_user_store
    list = [[nil, "---"]]
    @treatment_staffs.select{|s| s.staff_type == "User" and s.staff.license_type.independent_flag}.each{|s| list << [s.staff.id, s.staff.full_name]} if @treatment
    list.uniq
  end

  def physician_store(treatment_id, visit_id)
    return [] if treatment_id.nil? and visit_id.nil?
    list = [[nil, "---"]]
    treatment = treatment_id ? PatientTreatment.find(treatment_id) : TreatmentVisit.find(visit_id).treatment
    treatment.treatment_physicians.collect{|tp| list << [tp.physician.id, tp.physician.full_name]}
    list.uniq
  end

  js_method :after_render,<<-JS
    function(){
        this.callParent();
        var window = this.up("window");
        var signDate = Ext.ComponentQuery.query("#sign_date")[0];
        var signPwd = Ext.ComponentQuery.query("#sign_password")[0];
        var fieldStaff = this.down('#field_staff_id');
        var supervisor = this.down('#supervised_user_id');
        this.refreshComboStore("physician_id");
        this.refreshComboStore("field_staff_id");
        this.refreshComboStore("supervised_user_id");
        
        if (supervisor || fieldStaff ){
          window.actions.saveDraft.hide();
        }

        if (supervisor) {
          supervisor.on('change', function(ele) {
            if (ele.value == fieldStaff.value){
                fieldStaff.setValue(); 
            }
            if(ele.value == this.currentUser && this.docIsDraft) {
              signPwd.show();
              signDate.show();
             }
            else {
              signPwd.hide();
              signDate.hide();
            } 
            this.disableFieldStaff(ele, fieldStaff);
          },this);
        } 
    }
  JS

  js_method :disable_field_staff, <<-JS
    function(ele, fieldStaff) {
      fieldStaff.store.reload();
      fieldStaff.store.each(function(el, index) {
        if(el != undefined && ele.value == el.data.field1) {
          fieldStaff.store.removeAt(index);
        }
      });
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
  
end