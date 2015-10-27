class VisitEditForm < VisitNewForm
  
  def configuration
    c = super
      component_session[:visit_id] = c[:record_id] if c[:record_id]
      if component_session[:visit_id]
        visit = TreatmentVisit.find(component_session[:visit_id])
        component_session[:treatment_id] = visit.treatment_id
        component_session[:treatment_episode_id] = visit.treatment_episode_id
        non_modifiable_attr = (not visit.editable?)
        date_not_editable = visit.can_not_edit_field?
        vitals_not_editable = visit.can_not_edit_field?({vitals_flag: true})
        end_date_display = visit.visit_end_date_display
        current_user_is_visited_staff = visit.current_user_is_field_staff?
      end
      c[:strong_default_attrs] = nil
      c.merge(
        item_id: :visit_edit_form,
        visit_id: component_session[:visit_id],
        treatment_id: component_session[:treatment_id],
        treatment_episode_id: component_session[:treatment_episode_id],
        clear_state_on_destroy: false, #For multiple visit adding purpose, manually destroyed this component.
        strong_default_attrs: (c[:strong_default_attrs] ? c[:strong_default_attrs] : {}).merge({draft_status: false}),
        layout: :border,
        autoScroll: true,
        items: [
            {region: :north,
             border: false,
             autoScroll: true,
             items:[
                 {
                     border: false,
                     margin: "5px 80px 0 30px",
                     items:[
                         {
                             border: false,
                             layout: 'hbox',
                             style: 'text-align: center; margin: "5px";',
                             items: [
                                 {name: :visited_staff__full_name,
                                  item_id: :visited_staff,
                                  field_label: "Visited Staff",
                                  label_align: "right",
                                  scope: :org_scope,
                                  allow_blank: false,
                                  margin: "0 0 5px 0",
                                  flex: 1,
                                  hidden: current_user_is_visited_staff,
                                  read_only: non_modifiable_attr
                                 },
                                 {name: :visited_user__full_name, item_id: :visited_user_id, field_label: "Visited SC User", label_align: "right", scope: :org_scope, hidden: true, allow_blank: false, margin: "0 0 5px 0", flex: 1, read_only: non_modifiable_attr},
                                 {name: :supervised_user__full_name, item_id: :supervised_user_id, field_label: "Supervised User", label_align: "right", scope: :org_scope, hidden: true, allow_blank: false, margin: "0 0 5px 0", flex: 1, read_only: non_modifiable_attr},
                             ]
                         },{
                             border: false,
                             layout: 'hbox',
                             style: 'text-align: center; margin: "5px";',

                             items: [
                                 {name: :visit_entry_type, field_label: "Entry Type", width: 253, mode: 'local', label_align: "right", store: TreatmentVisit::VISIT_ENTRY_TYPES, xtype: :combo, allow_blank: false, read_only: non_modifiable_attr, hidden: current_user_is_visited_staff},
                                 {name: :visit_type__visit_type_description,  anchor: "100%", flex: 1.2, item_id: :visit_type_id, label_align: "right", field_label: "Visit Type", scope: :org_scope, default_if_single_item: false, allow_blank: false, margin: "0 0 5px 0", read_only: non_modifiable_attr},
                                 {name: :count_for_frequency_flag,  flex: 0.8, field_label: "Count for Frequency?", label_align: "right", xtype: :checkbox, margin: "0 0 5px 0", read_only: non_modifiable_attr},
                             ]
                         },{
                             border: false,
                             layout: 'hbox',
                             style: 'text-align: center; margin: "5px";',

                               items: [
                                   {name: :visit_date, field_label: 'Start Date', xtype: :datefield, flex: 0.8, allow_blank: false,
                                          label_align: "right",  read_only: date_not_editable, item_id: 'visit_date'},
                                   {
                                       layout: :hbox,
                                       border: false,
                                       flex: 0.6,
                                       items: [
                                           {
                                               name: :start_time_hour,
                                               field_label: 'Start',
                                               xtype: :numberfield,
                                               label_width: 50,
                                               maxValue: 23,
                                               minValue: 00,
                                               width: 120,
                                               read_only: date_not_editable
                                           },
                                           {
                                               xtype: :label,
                                               text: " :",
                                           },
                                           {
                                               name: :start_time_min,
                                               field_label: ' ',
                                               xtype: :numberfield,
                                               label_separator: '',
                                               label_width: 5,
                                               maxValue: 59,
                                               minValue: 00,
                                               width: 80,
                                               read_only: date_not_editable
                                           }
                                       ],
                                   },
                                    {name: :visit_end_date, field_label: 'End Date', xtype: :datefield, flex: 0.8, allow_blank: false,
                                      label_align: "right", value: end_date_display, read_only: date_not_editable, item_id: 'visit_end_date'},
                                   {
                                       layout: :hbox,
                                       border: false,
                                       flex: 0.6,
                                       items: [
                                           {
                                               name: :end_time_hour,
                                               field_label: 'End',
                                               xtype: :numberfield,
                                               label_width: 50,
                                               maxValue: 23,
                                               minValue: 00,
                                               width: 120,
                                               read_only: date_not_editable
                                           },
                                           {
                                               xtype: :label,
                                               text: " :",
                                           },
                                           {
                                               name: :end_time_min,
                                               field_label: ' ',
                                               xtype: :numberfield,
                                               label_separator: '',
                                               label_width: 5,
                                               maxValue: 59,
                                               minValue: 00,
                                               width: 80,
                                               read_only: date_not_editable
                                           }
                                       ],
                                   }
                               ]
                           },
                     ]
                 },                    {
                                       xtype: :fieldset,
                                       title: "Vitals",
                                       layout: :auto,
                                       :margin => "5px",
                                       items: [
                                           {
                                               border: false,
                                               :margin => "5px",

                                               items: [
                                                   {
                                                       border: false,
                                                       layout: 'hbox',
                                                       defaults: {padding: 1, hideTrigger: true, mouseWheelEnabled: false},
                                                       style: 'text-align: center; margin: "5px";',
                                                       items: [
                                                           {name: :systolic_bp, field_label: 'BP', xtype: 'numberfield',  label_align: "right", emptyText: 'Systolic', flex:1, label_width: 38, read_only: vitals_not_editable},
                                                           {name: :diastolic_bp, field_label: ' ', xtype: 'numberfield',  emptyText: 'Diastolic', label_separator: '', flex:1, label_width: 10, margin: "0 10px 0 0", read_only: vitals_not_editable},
                                                           {name: :bp_read_location,  field_label: ' ', xtype: :combo, store: TreatmentVital::BP_LOCATION, editable: false, hideTrigger: false, mouseWheelEnabled: true, label_separator: '', emptyText: 'Read Location', flex:1,  label_width: 10, read_only: vitals_not_editable},
                                                           {name: :bp_read_position, field_label: ' ', xtype: :combo, store: TreatmentVital::BP_POSITION, editable: false, hideTrigger: false, mouseWheelEnabled: true, flex:1, label_width: 10, emptyText: 'Read Position', label_separator: '', margin: "0 0 5px 0", read_only: vitals_not_editable},
                                                       ]
                                                   },{
                                                       border: false,
                                                       layout: 'hbox',
                                                       style: 'text-align: center; margin: "5px";',
                                                       defaults: {padding: 1, hideTrigger: true, mouseWheelEnabled: false},
                                                       items: [
                                                           {name: :heart_rate, field_label: 'Rate', xtype: 'numberfield', label_align: "right",  emptyText: 'Heart', flex:1, label_width: 38, read_only: vitals_not_editable},
                                                           {name: :respiration_rate, field_label: ' ', xtype: 'numberfield', emptyText: 'Respiration', label_separator: '', flex:1, label_width: 10, margin: "0 10px 0 0", read_only: vitals_not_editable},
                                                           {name: :blood_sugar, field_label: ' ', xtype: 'numberfield', emptyText: 'Blood Sugar', label_separator: '', flex:1,  label_width: 10, read_only: vitals_not_editable},
                                                           {name: :sugar_read_period, field_label: ' ', xtype: :combo, store:TreatmentVital::SUGAR_READ_PERIOD, editable: false, hideTrigger: false, mouseWheelEnabled: true, emptyText: 'Sugar Rd Period', label_separator: '', flex:1, label_width: 10, margin: "0 0 5px 0", read_only: vitals_not_editable},
                                                       ]
                                                   },{
                                                       border: false,
                                                       layout: 'hbox',
                                                       defaults: {padding: 1, hideTrigger: true, mouseWheelEnabled: false},
                                                       style: 'text-align: center; margin: "5px";',
                                                       items: [
                                                           {name: :weight_in_lbs, field_label: 'Details', xtype: 'numberfield', label_align: "left", emptyText: 'Weight(lbs)', flex:1, label_width: 38, read_only: vitals_not_editable},
                                                           {name: :temperature_in_fht, field_label: ' ', xtype: 'numberfield',  emptyText: "Temperature(F)", label_separator: '', flex:1, label_width: 10, margin: "0 10px 0 0", read_only: vitals_not_editable},
                                                           {name: :oxygen_saturation, field_label: ' ', xtype: 'numberfield', emptyText: 'Oxygen Saturation', label_separator: '', flex:1,  label_width: 10, read_only: vitals_not_editable},
                                                           {name: :pain, field_label: ' ', xtype: 'numberfield',  emptyText: 'Pain', label_separator: '', flex:1, label_width: 10, margin: "0 0 5px 0", margin: "0 0 5px 0", read_only: vitals_not_editable},
                                                       ]
                                                   },
                                               ]
                                           }
                                       ]
                                   }

             ]},


    :details.component(
                :name => :details,
                region: :center,
                :title => "Details",
                :header => false,
                :class_name => "Netzke::Basepack::TabPanel",
                :items => [
                    :visit_docs.component(
                        class_name: "Documents",
                        border: false,
                        association: "documents",
                        parent_model: "TreatmentVisit",
                        parent_id: component_session[:visit_id],
                        treatment_id: component_session[:treatment_id],
                        episode_id: component_session[:treatment_episode_id],
                        item_id: :visit_doc_grid_from_visit_edit,
                        strong_default_attrs: {treatment_id: component_session[:treatment_id], visit_id: component_session[:visit_id]}
                    ).merge((c[:editable] == false)? {bbar: [], context_menu: []}: {}),
                    :visit_attachments.component(
                        class_name: "Mahaswami::HasManyCollectionList",
                        association: "attachments",
                        parent_model: "TreatmentVisit",
                        parent_id: component_session[:visit_id],
                        columns: [ {name: :attachment_type__attachment_description, header: "Type" },
                                   {name: :attachment_file_name, label: "File Name"},
                                   { name: :attachment, label: "", getter: lambda{ |r| link_to("Download", r.attachment.url, :target => "_blank")}},

                        ],
                        add_form_window_config: {
                            title: "Add Attachment"
                        },
                        add_form_config: {
                            class_name: "VisitAttachmentForm",
                           },
                        bbar: (c[:editable] == false) ? [] :[:add_in_form.action, :del.action],
                        context_menu: (c[:editable] == false) ? [] :[:add_in_form.action, :del.action]
                    ),
                    :treatment_medication.component(
                               class_name: "TreatmentMedications",
                               association: "medications",
                               parent_model: "TreatmentVisit",
                               title: 'Medications',
                               item_id: "visit_medication_grid",
                               parent_id: component_session[:visit_id],
                               visit_id: component_session[:visit_id],
                               treatment_id: component_session[:treatment_id],
                               show_tool_bar: true,
                           ).merge((c[:editable] == false)? {bbar: [], context_menu: []}: {}),
                    ],
                :width => "70%",
                :border => true,
                :active_tab => 0
            )
        ]
    )

  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      var documentGrid = this.down("#visit_doc_grid_from_visit_edit");
      var supUser = this.down("#supervised_user_id");
      if(supUser){
        supUser.on('change', function(ele){
          var value = ele.value+'-'+this.visitId;
          this.assignedSupervisedUser(value);
        }, this);
      }
      this.down("#visit_type_id").on("change", function(ele){
        documentGrid.updateDocumentsMenu({visit_type_id: ele.value});
      }, this);
      documentGrid.store.on('load', function(){
        var visitTypeId = this.down("#visit_type_id").value;
        documentGrid.updateDocumentsMenu({visit_type_id: visitTypeId});
      }, this);
      var startDate = this.down('#visit_date');
      var endDate = this.down('#visit_end_date');
      startDate.on('change', function(el) {
        endDate.setValue(el.value);
      });
    }
  JS

  js_method :assigned_supervised_user, <<-JS
    function(value){
      Ext.Ajax.request({
        async: false,
        url: '/welcome/assign_supervised_user/'+value,
        method: 'POST'
      });
    }
  JS

  js_method :on_apply,<<-JS
    function(){
      var formScope = this;
      if(formScope.setByMe == true) {
        formScope.setByMe = false;
        this.callParent();
        return;
      }
      var values = this.getForm().getValues();
      this.checkVisitIsOverlapped({values: values}, function(res){
        if (res) {
          Ext.MessageBox.confirm("Warning:", res, function(btn){
            if (btn == 'yes') {
              Ext.Function.defer(function(){
                formScope.setByMe = true;
                formScope.onApply();
              }, 10);
            }
          });
        } else {
          Ext.Function.defer(function(){
            formScope.setByMe = true;
            formScope.onApply();
          }, 10);
        }
      },this);
    }
  JS

  endpoint :check_visit_is_overlapped do |params|
    res = TreatmentVisit.check_visit_is_overlapped(component_session[:treatment_id], params[:values], component_session[:visit_id])
    res = res ? (res + "<br/><br/>" + "Would you like to proceed?") : false
    {set_result: res}
  end
end
