class RecertificationForm < Mahaswami::FormPanel

  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    @treatment_id = component_session[:treatment_id]
    insurance = PatientTreatment.find(component_session[:treatment_id]).treatment_request.insurance_company if component_session[:treatment_id]
    medicare_insurance_flag = (insurance.present? and insurance.medicare?)
    s.merge(
        model: "TreatmentEpisode",
        medicare_insurance_flag: medicare_insurance_flag,
        items: [
            {name: :start_date, field_label: "Start Date", item_id: :start_date, read_only: medicare_insurance_flag},
            {name: :end_date, field_label: "End Date", item_id: :end_date, read_only: medicare_insurance_flag},
            {name: :episode_type, field_label: "Episode Type", editable: false, xtype: 'combo', store: TreatmentEpisode::EPISODE_TYPES, hidden: true},
            {name: :treatment_id, value: component_session[:treatment_id], hidden: true},
            :disciplines.component
        ],
        strong_default_attrs: {treatment_id: component_session[:treatment_id]},
    )
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      var startDate = this.down('#start_date');
      startDate.on('select', function(){
        this.getEndDate({start_date: startDate.value}, function(result){
          if (result[0])
            this.down('#end_date').setValue(result[1]);
        }, this);
      }, this);
      startDate.on('blur', function(){
        this.getEndDate({start_date: startDate.value}, function(result){
          if(result[0])
            this.down('#end_date').setValue(result[1]);
        }, this);
      }, this);
    }
  JS

  endpoint :get_end_date do |params|
    start_date = params[:start_date].to_date
    {:set_result => [config[:medicare_insurance_flag], (start_date -1) + 60]}
  end

  component :disciplines do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        association: :disciplines,
        columns: 2,
        assoc_ids: PatientTreatment.find(@treatment_id).discipline_ids
    }
  end
end