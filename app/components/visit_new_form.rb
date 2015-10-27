class VisitNewForm < Mahaswami::FormPanel
   js_include :state_chart

  def configuration
    c = super
    component_session[:treatment_id] = c[:treatment_id] if c[:treatment_id]
    component_session[:treatment_episode_id] = c[:treatment_episode_id] if c[:treatment_episode_id]
    component_session[:visit_id] = c[:visit_id] if c[:visit_id]
    c.merge(
        model: "TreatmentVisit",
        enableSaveAndContinue: true,
        visit_form: true,
        trackResetOnLoad: true,
           items:[
               {
                   border: false,
                   :margin => "5px 0 0 -5px",
                 items: [
                     {
                         border: false,
                         layout: 'hbox',
                         style: 'text-align: center; margin: "5px";',

                         items: [

                             {name: :visited_staff__full_name, item_id: :visited_staff, field_label: "Visited Staff", label_align: "right", scope: :org_scope, allow_blank: false, margin: "0 0 5px 0", flex: 1},
                             {name: :visited_user__full_name, item_id: :visited_user_id, field_label: "Visited SC User", label_align: "right", scope: :org_scope, hidden: true, allow_blank: false, margin: "0 0 5px 0", flex: 1},
                             {name: :supervised_user__full_name, item_id: :supervised_user_id, field_label: "Supervised User", label_align: "right", scope: :org_scope, hidden: true, allow_blank: false, margin: "0 0 5px 0", flex: 1},
                         ]
                     },{
                         border: false,
                         layout: 'hbox',
                         style: 'text-align: center; margin: "5px";',

                         items: [
                             {name: :visit_entry_type, field_label: "Entry Type", mode: 'local', label_align: "right", store: TreatmentVisit::VISIT_ENTRY_TYPES, xtype: :combo, allow_blank: false, flex: 1},
                             {name: :visit_type__visit_type_description, item_id: :visit_type_id, field_label: "Visit Type", label_align: "right",scope: :org_scope, default_if_single_item: false, allow_blank: false, margin: "0 0 5px 0", flex: 1},
                         ]
                     },{
                         border: false,
                         layout: 'hbox',
                         style: 'text-align: center; margin: "5px 5px 10px 5px";',

                         items: [
                             {name: :count_for_frequency_flag, field_label: "Count for Frequency?", label_align: "right", xtype: :checkbox, margin: "0 0 5px 0"},

                         ]
                     },{
                         border: false,
                         layout: 'hbox',
                         style: 'text-align: center; margin: "5px";',

                         items: [
                             {name: :visit_date, field_label: 'Start Date', xtype: :datefield, allow_blank: false, label_align: "right", margin: "0 0 5px 0"},
                             {name: :start_time, field_label: ' ', xtype: :timefield, format: "H:i", allow_blank: false, editable: false, label_separator: '', label_width: 5,  flex: 1},
                             {name: :visit_end_date, field_label: 'End Date', xtype: :datefield, allow_blank: false, label_align: "right", margin: "0 0 5px 0"},
                             {name: :end_time, field_label: ' ', xtype: :timefield, format: "H:i", allow_blank: false, editable: false, label_separator: '', label_width: 5,  margin: "0 0 5px 0"},

                         ]
                     },

                 ]},
                 {
                    xtype: 'panel',
                    border: false,
                      items: [
                          {
                            xtype: :fieldset,
                            title: "Vitals",
                            layout: :auto,
                            :margin => "0 0 0 20px",
                            items: [
                                {
                                    border: false,
                                    :margin => "5px 0 0 20px",

                                    items: [
                                        {
                                            border: false,
                                            layout: 'hbox',
                                            defaults: {padding: 1, hideTrigger: true, mouseWheelEnabled: false},
                                            style: 'text-align: center; margin: "5px";',
                                            bodyStyle: 'padding-top: 10px; padding-right: 30px',
                                            items: [
                                                {name: :systolic_bp, field_label: 'BP', xtype: 'numberfield', label_align: "right", emptyText: 'Systolic', flex:1, label_width: 38 },
                                                {name: :diastolic_bp, field_label: ' ', xtype: 'numberfield', emptyText: 'Diastolic', label_separator: '', flex:1, label_width: 10, margin: "0 10px 0 0"},
                                                {name: :bp_read_location,  field_label: ' ', xtype: :combo, store: TreatmentVital::BP_LOCATION, editable: false, hideTrigger: false, mouseWheelEnabled: true, label_separator: '', emptyText: 'Read Location', flex:1,  label_width: 10},
                                                {name: :bp_read_position, field_label: ' ', xtype: :combo, store: TreatmentVital::BP_POSITION, editable: false, hideTrigger: false, mouseWheelEnabled: true, flex:1, label_width: 10, emptyText: 'Read Position', label_separator: '', margin: "0 0 5px 0"},
                                            ]
                                        },{
                                            border: false,
                                            layout: 'hbox',
                                            style: 'text-align: center; margin: "5px";',
                                            defaults: {padding: 1, hideTrigger: true, mouseWheelEnabled: false},
                                            bodyStyle: 'padding-top: 10px; padding-right: 30px',
                                            items: [
                                                {name: :heart_rate, field_label: 'Rate', xtype: 'numberfield', label_align: "right",  emptyText: 'Heart', flex:1, label_width: 38},
                                                {name: :respiration_rate, field_label: ' ', xtype: 'numberfield', emptyText: 'Respiration', label_separator: '', flex:1, label_width: 10, margin: "0 10px 0 0"},
                                                {name: :blood_sugar, field_label: ' ', xtype: 'numberfield', emptyText: 'Blood Sugar', label_separator: '', flex:1,  label_width: 10},
                                                {name: :sugar_read_period, field_label: ' ', xtype: :combo, store:TreatmentVital::SUGAR_READ_PERIOD, editable: false, hideTrigger: false, mouseWheelEnabled: true, emptyText: 'Sugar Rd Period', label_separator: '', flex:1, label_width: 10, margin: "0 0 5px 0"},
                                            ]
                                        },{
                                            border: false,
                                            layout: 'hbox',
                                            style: 'text-align: center; margin: "5px";',
                                            defaults: {padding: 1, hideTrigger: true, mouseWheelEnabled: false},
                                            bodyStyle: 'padding-top: 10px; padding-right: 30px',
                                            items: [
                                                {name: :weight_in_lbs, field_label: 'Details', xtype: 'numberfield', label_align: "left", emptyText: 'Weight(lbs)', flex:1, label_width: 38},
                                                {name: :temperature_in_fht, field_label: ' ', xtype: 'numberfield',  emptyText: "Temperature(F)", label_separator: '', flex:1, label_width: 10, margin: "0 10px 0 0"},
                                                {name: :oxygen_saturation, field_label: ' ', xtype: 'numberfield', emptyText: 'Oxygen Saturation', label_separator: '', flex:1,  label_width: 10},
                                                {name: :pain, field_label: ' ', xtype: 'numberfield',  emptyText: 'Pain', label_separator: '', flex:1, label_width: 10, margin: "0 0 5px 0", margin: "0 0 5px 0"},
                                            ]
                                        },
                                    ]
                                }
                            ]
                          }
                      ]
               }
           ]
        )
  end

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.resetSessionContext();
      this.statechart = createStateChart(this);
      this.down("#visited_staff").on('select', function(ele) {
        this.statechart.sendEvent("visited_staff_changed");
      }, this);
      this.down("#visited_user_id").on('select', function(ele) {
        this.statechart.sendEvent("visited_user_changed");
      }, this);
    }
  JS

  js_method :reset_visit_type_store,<<-JS
    function(){
      var visit_type = this.down("#visit_type_id");
      visit_type.reset();
      var visit_type_store = visit_type.store;
      visit_type_store.remoteFilter = true;
      visit_type_store.clearFilter();
      visit_type_store.filter([{property: "visited_staff_id", value: this.statechart.cmp.down("#visited_staff").getValue()}]);
    }
  JS

  js_method :show_hide_visited_user, <<-JS
    function(show) {
      if(show)
        this.query("#visited_user_id")[0].show();
      else
        this.query("#visited_user_id")[0].hide();
    }
  JS

  js_method :show_hide_supervised_user, <<-JS
    function(show) {
      if(show)
        this.query("#supervised_user_id")[0].show();
      else
        this.query("#supervised_user_id")[0].hide();
    }
  JS

  js_method :show_hide_input, <<-JS
    function(args) {
      cmp_id = args[0];
      show = args[1];
      if(show)
        this.query("#" + cmp_id)[0].show();
      else
        this.query("#" + cmp_id)[0].hide();
    }
  JS

  js_method :set_visited_user, <<-JS
    function(value) {
      console.log("Setting Visited User to - " + value);
      this.query("#visited_user_id")[0].setValue(value);
    }
  JS

  js_method :set_value_for_input, <<-JS
    function(v) {
      var cmp = this.down("#"+v[0]);
      cmp.setValue(v[1]);
      cmp.fireEvent('select', cmp);
    }
  JS

  endpoint :get_visited_staff_id_and_type do |params|
    visited_staff_class_name, visited_staff_id = params[:visited_staff_id].split("_")
    visited_staff = visited_staff_class_name.constantize.find(visited_staff_id)
    visited_staff_type = if visited_staff.is_a?(StaffingCompany)
                           "SC"
                         elsif visited_staff.independent?
                            "IFS"
                         else
                            "FS"
                         end
    {set_result: {visited_staff_type: visited_staff_type, visited_staff_id: visited_staff_id }}
  end

  endpoint :select_visited_user do |params|
    component_session[:visited_user_id] = params[:visited_user_id]
    show_supervised_user = (component_session[:visited_user_id] and FieldStaff.find(component_session[:visited_user_id]).independent? == false)
    {:show_hide_supervised_user => show_supervised_user}
  end

  endpoint :reset_session_context do |params|
      record = TreatmentVisit.find(component_session[:visit_id])
      component_session[:treatment_id] = record.treatment_id
      component_session[:visited_staff] = "#{record.visited_staff.class.name}_#{record.visited_staff.id}" if record.visited_staff
      component_session[:discipline_id] = record.discipline_id
      component_session[:visited_user_id] = record.visited_user_id
      component_session[:supervised_user_id] = record.supervised_user_id
      component_session[:visit_type_id] = record.visit_type_id
      res = (record.supervised_user.blank? == false or (User.current.is_a?(FieldStaff) and record.supervised_user.blank? == true and User.current.independent? == false))
      {:show_hide_visited_user => record.visited_staff.is_a?(StaffingCompany),
       :show_hide_supervised_user => res
      }
  end

  def visited_staff__full_name_combobox_options(params)
    treatment_id = component_session[:treatment_id]
    visited_user_id = component_session[:visited_user_id]
    visit_id = component_session[:visit_id]

    treatment = PatientTreatment.find(component_session[:treatment_id])
    treatment_visit = TreatmentVisit.find(visit_id)
    treatment_visit.get_active_field_staff(treatment_id, visited_user_id, treatment)
  end

  def visited_user__full_name_combobox_options(params)
    return if params["filter"].blank? and component_session[:visited_staff].nil?
    return if params["filter"] and filter_param_value(params["filter"], "visited_staff_id") == -1
    visited_staff = if params["filter"]
                      filter_param_value(params["filter"], "visited_staff_id")
                    else
                      component_session[:visited_staff]
                    end
    treatment = PatientTreatment.find(component_session[:treatment_id])
    visited_staff_class_name, visited_staff_id = visited_staff.split("_")
    values = []
    if visited_staff_class_name == "StaffingCompany"
      staffs = staffing_company_staffs(treatment, visited_staff_id.to_i)
      unless params[:query].blank?
        query = "#{params[:query].upcase}%"
        searched_staffs = staffs.where(["upper(first_name) LIKE ? or upper(last_name) LIKE ?", query, query])
        values = searched_staffs.collect{|x| [x.id, x.full_name]}.uniq
      else
        values = staffs.collect{|x| [x.id, x.full_name]}.uniq
      end
    end
    {:data => values}
  end

  def staffing_company_staffs(treatment, visited_staff_id)
    staffing_company = StaffingCompany.find(visited_staff_id)
    staffing_company.staffs
  end

  def supervised_user__full_name_combobox_options(params)
    return if params["filter"].blank? and component_session[:visited_staff].nil?
    return if params["filter"] and filter_param_value(params["filter"], "visited_staff_id") == -1
    visited_staff = if params["filter"]
                      filter_param_value(params["filter"], "visited_staff_id")
                    else
                      component_session[:visited_staff]
                    end
    treatment = PatientTreatment.find(component_session[:treatment_id])
    visited_staff_class_name, visited_staff_id = visited_staff.split("_")
    values = []
    if visited_staff_class_name == "FieldStaff" and not FieldStaff.find(visited_staff_id.to_i).license_type.independent_flag
      staffs = supervised_staffs(treatment, visited_staff_id.to_i)
      unless params[:query].blank?
        query = "#{params[:query].upcase}%"
        searched_staffs = staffs.empty? ? [] : staffs.where(["upper(first_name) LIKE ? or upper(last_name) LIKE ?", query, query])
        values = searched_staffs.collect{|x| [x.id, x.full_name]}.uniq
      else
        values = staffs.collect{|x| [x.id, x.full_name]}.uniq
      end
    end
    {:data => values}
  end

  def supervised_staffs(treatment, visited_staff_id)
    v_staff_treatment_staffs_records = treatment.treatment_staffs.staffed.where({:staff_type => "User", :staff_id => visited_staff_id})
    staffs = []
    v_staff_treatment_staffs_records.each{|staff|
      staffs = staffs +  (treatment.treatment_staffs.staffed.where(["discipline_id = ? or visit_type_id = ?", staff.discipline_id, staff.visit_type_id]) - v_staff_treatment_staffs_records)
    }
    staffs.select{|s| s.staff_type == "User" and s.staff.license_type.independent_flag}.collect{|s| s.staff }.uniq
  end

  def visit_type__visit_type_description_combobox_options(params)
    return if params["filter"].blank? and component_session[:visited_staff].nil?
    return if params["filter"] and filter_param_value(params["filter"], "visited_staff_id") == -1
    visited_staff = if params["filter"]
                      filter_param_value(params["filter"], "visited_staff_id")
                    else
                      component_session[:visited_staff]
                    end
    visit_types = VisitType.get_visit_types_for_visit(visited_staff, component_session[:treatment_id])

    if component_session[:visit_id]
      visit = TreatmentVisit.find(component_session[:visit_id])
      visit_type = visit.visit_type
      visit_types << visit_type if visit_type
    end

    {:data => visit_types.collect{|x| [x.id, (x.discipline ? x.discipline.to_s + " - " + x.to_s : x.to_s)]}.uniq}
  end

  private

  def filter_param_value(filter_param, param_name)
    param = filter_param.detect{|f| f["property"] == param_name}
    param["value"] if param
  end
end

