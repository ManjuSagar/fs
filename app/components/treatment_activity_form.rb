class TreatmentActivityForm < Mahaswami::FormPanel

  def configuration
    s = super
    component_session[:event_name] = s[:event_name] if s[:event_name]
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:discipline_id] = s[:discipline_id] if s[:discipline_id]
    component_session[:episode_id] = s[:episode_id] if s[:episode_id]
    @treatment = PatientTreatment.find(component_session[:treatment_id])
    @episode = @treatment.treatment_episodes.find(component_session[:episode_id])
    s.merge(
      model: "TreatmentActivity",
      setByMe: false,
      item_id: :activity_form,
      items: [
               {name: :activity_reason_code, field_label: "Reason", allowBlank: false, item_id: :activity_reason_code, mode: :local, editable: false,
                store: acitvity_reason_code_store(component_session[:event_name]),
                 xtype: :combo},
            (component_session[:discipline_id].present? ?
                {name: :discipline__to_s, field_label: "Discipline", item_id: :discipline_id, hidden: true, value: component_session[:discipline_id], editable: false} :
                {name: :discipline__to_s, field_label: "Discipline", item_id: :discipline_id, editable: false}),
            {name: :activity_date, field_label: "Date", allowBlank: false},
            {name: :medical_order_required, field_label: "Create Medical Order"},
            {name: :activity_details, field_label: "Remarks", rows: 20},
            {name: :event_name, value: component_session[:event_name].titleize, hidden: true, item_id: :event_name},
            {name: :episode, hidden: true, value: component_session[:episode_id]},
        ],
        strong_default_attrs: s[:strong_default_attrs].merge({activity_type: get_activity_type(component_session[:event_name])})
    )
  end

  def discipline__to_s_combobox_options(params)
    list = [[nil,"All Disciplines"]]
    if @treatment and @episode
      @treatment.treatment_disciplines.episode_scope(@episode).select{|d| d.send("may_#{component_session[:event_name]}?")}.
          collect{|td| list << [td.id, td.to_s]}
    end
    {:data => list}
  end

  def acitvity_reason_code_store(event_name)
    if event_name == "discharge"
      PatientTreatment::DISCHARGE_REASONS + (@treatment.medicare? ? [] : PatientTreatment::NON_MEDICARE_DC_REASONS)
    elsif event_name == "hold"
      PatientTreatment::HOLD_REASONS
    elsif event_name == "unhold"
      PatientTreatment::UNHOLD_REASONS
    else
      []
    end
  end

  def get_activity_type(event_name)
    if event_name == "discharge"
      TreatmentActivity::DISCHARGE
    elsif event_name == "hold"
      TreatmentActivity::HOLD
    elsif event_name == "unhold"
      TreatmentActivity::UNHOLD
    end
  end

  js_method :after_render, <<-JS
    function(){
     this.callParent();
     var reason = this.down("#activity_reason_code");
    this.discipline = this.down("#discipline_id");
     var event_name = this.down("#event_name").value;
     if(event_name == "Unhold"){
        this.getHoldReason({},function(res){
          if(res == true){
            this.discipline.hide();
            reason.hide();
          }
        });
     }
     reason.on('change', function(){
       reasonValue = reason.value;
      if(reasonValue == "4"){
        this.discipline.reset();
        this.discipline.hide();
      }
      else if(this.discipline.value == null || this.discipline.value == 'undefined'){
        this.discipline.show();
      }
     },this);
  }
  JS

  js_method :on_apply,<<-JS
    function(){
      var formScope = this;
      if (this.setByMe == true) {
        this.setByMe = false;
        this.callParent();
        return;
      }
      var discipline_id = this.down("#discipline_id").value;
      var event_name = this.down("#event_name").value;
      this.getDescription({discipline_id: discipline_id}, function(res){
        var discipline_str = res;
        warningMessage = "Since you are resuming care you need to attach Resumption of care.<br>"
        message = "Are you sure you want to "+event_name+" the patient?"
        msg = (event_name == "Unhold") ? (warningMessage + message) : message
        Ext.MessageBox.confirm(event_name + ' Patient?', (discipline_id) ? 'Are you sure you want to '+event_name+' the patient for ' +'<b>' + discipline_str + '</b>' +'?' : msg, function(btn){
          if (btn == 'yes') {
            Ext.Function.defer(function(){
              formScope.setByMe = true;
              formScope.onApply();
            }, 10);
          }
          else{
            formScope.up('window').close();
            formScope.close();
          }
        });
      },this);
    }
  JS

  endpoint :get_hold_reason do |params|
    treatment_activity = @treatment.treatment_activities.where("activity_type = 'H'").order('id DESC').last
    res = treatment_activity.activity_reason_code == '4' if treatment_activity.present?
    {set_result: res}
  end

  endpoint :get_description do |params|
    if params[:discipline_id]
      res = TreatmentDiscipline.find(params[:discipline_id]).to_s
    end
    {set_result: res}
  end

end