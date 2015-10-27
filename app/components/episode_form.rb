class EpisodeForm < Mahaswami::FormPanel

  def configuration
    s = super
    insurance = PatientTreatment.find(s[:treatment_id]).treatment_request.insurance_company if s[:treatment_id]
    medicare_insurance_flag = (insurance.present? and insurance.medicare?)
    s.merge({
      model: "TreatmentEpisode",
      medicare_insurance_flag: medicare_insurance_flag,
      items: [
        {name: :start_date, field_label: "Start Date", item_id: :start_date},
        {name: :end_date, field_label: "End Date", item_id: :end_date, read_only: medicare_insurance_flag},
        {name: :episode_type, field_label: "Episode Type", editable: false, xtype: 'combo', store: TreatmentEpisode::EPISODE_TYPES, hidden: true}
      ]
    })
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
      startDate.on('change', function(){
        this.getEndDate({start_date: startDate.value}, function(result){
          if(result[0])
            this.down('#end_date').setValue(result[1]);
        }, this);
      }, this);
    }
  JS

  endpoint :get_end_date do |params|
    start_date = params[:start_date].to_date
    {:set_result => [config[:medicare_insurance_flag], start_date + 59]}
  end

end