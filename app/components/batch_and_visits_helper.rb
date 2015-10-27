module BatchAndVisitsHelper
  include Netzke

  def self.included(klass)

    klass.js_method :display_error_msgs,<<-JS
      function(errors){
        this.disableAction(this.actions.apply, false);
        this.loadNetzkeComponent({name: "error_window", params: {component_params: {errors: errors}}, callback: function(w){
          w.show();
        }, scope: this});;
      }
    JS

    klass.js_method :disable_action,<<-JS
      function(action, value){
        action.setDisabled(value);
      }
    JS

    klass.js_method :msg_display,<<-JS
      function(msg){
        Ext.MessageBox.alert("Status", msg);
        this.disableAction(this.actions.apply, false);
      }
    JS

    klass.js_method :refresh_grids, <<-JS
      function(){
        this.store.load();
        this.up("#schedule_visit_explorer_" + this.episodeId).down("#patient_schedules_new_" + this.episodeId).store.load();
        this.disableAction(this.actions.apply, false);
      }
    JS

    klass.js_method :confirmation_msg,<<-JS
      function(params){
        Ext.MessageBox.confirm("Warning:", params[0], function(btn){
          if (btn == 'yes') {
            this.createRecords({data: params[1]});
          }
          this.disableAction(this.actions.apply, false);
        }, this);
      }
    JS

    klass.js_method :on_apply, <<-JS
      function (){
        this.disableAction(this.actions.apply, true);
        this.callParent();
      }
    JS

    klass.js_method :time_display, <<-JS
      function(value){
        if(value.length == 0 || (value.indexOf(':') != -1)) return value;
        return value.substr(0, value.length - 2) +":"+ value.substr(value.length - 2, value.length - 1);
      }
    JS

    klass.component :error_window
  end

  def at_least_one_field_is_modified?(row, operation)
    return true if operation == :update
    keys = row.keys - ["id", "record_number"]
    keys.any?{|key| row[key] != false and row[key].present? }
  end

  def visited_user_id_list
    values = []
    unless component_session[:treatment_id].blank?
      treatment = PatientTreatment.find(component_session[:treatment_id])
      staffs = treatment.fs_and_sc_staffs
      values = staffs.collect{|x| ["#{x.id}", x.full_name]}.uniq
    end
    values
  end

  def visit_type_id_list(short_form = false)
    values = []
    display_field = short_form ? "visit_type_short_display" : "to_s"
    unless component_session[:treatment_id].blank?
      treatment = PatientTreatment.find(component_session[:treatment_id])
      values = treatment.discipline_visit_types_list(component_session[:episode_id])
      values.collect!{|x|
        ["#{x[1].id}", ((x[0].nil? or short_form) ? x[1].send(display_field) : x[0].to_s + " - " + x[1].send(display_field))]
      }.uniq
    end
    values
  end

end