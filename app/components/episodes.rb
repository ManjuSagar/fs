class Episodes < Mahaswami::HasManyCollectionList
  association "treatment_episodes"
  parent_model "PatientTreatment"

  def initialize(conf = {}, parent_id = nil)
    super
    episode_instance = TreatmentEpisode.new(treatment_id: config[:parent_id])
    components[:add_form][:items].first.merge!(:record => episode_instance)
  end

  def configuration
    c = super
    component_session[:treatment_id] = component_session[:parent_id]
    component_session[:chart_id] = c[:chart_episode_id]
    c.merge(
    editOnDblClick: ((User.current.field_staff? or Org.current.is_a? StaffingCompany or
        (User.current.office_staff? &&  treatment.medicare?) )? false : true),
    title: 'Certification Periods',
    columns: [{name: :start_date, label: "Start Date", editable: false},
             {name: :end_date, label: "End Date", editable: false}
            ],
    add_form_window_config: { title: "Add Certification Period"},
    edit_form_window_config: {title: "Edit Certification Period"},
    add_form_config: {class_name: "EpisodeForm", treatment_id: component_session[:treatment_id], mode: :add},
    edit_form_config: {class_name: "EpisodeForm", treatment_id: component_session[:treatment_id], mode: :edit}
    )
  end
  
  def default_bbar
    treatment.episodes_actions
  end

  def default_context_menu
    treatment.episodes_actions
  end

  def treatment
    PatientTreatment.find(component_session[:treatment_id]) if component_session[:treatment_id]
  end


  js_method :on_del, <<-JS
    function(){
      if (this.getSelectionModel().selected.length == 1){
        var records = [];
        this.getSelectionModel().selected.each(function(r){
          if (r.isNew) {
            // this record is not know to server - simply remove from store
            this.store.remove(r);
          } else {
            records.push(r.getId());
          }
        }, this);;
        this.canDeleteEpisode({record_id: Ext.encode(records[0])}, function(res){
          if (res) {
            Ext.Msg.confirm(this.i18n.confirmation, this.i18n.areYouSure, function(btn){
              if (btn == 'yes') {
                this.deleteData({records: Ext.encode(records)}, function(res){
                  if(res){
                    var main_app = Ext.ComponentQuery.query("#app")[0];
                    main_app.loadPatientsList();
                  }else{
                    this.store.load();
                    container = Ext.ComponentQuery.query('#p_chart')[0];
                    container.onRefresh();
                  }
                }, this);
              }
            }, this);
          } else {
            var arr = ["Visits", "Invoices", "Medications", "Documents", "Medical Orders", "Communication Notes", "Receivables"];
            var msg = "Episode cannot be deleted.<br/><br/> <b>Reasons:</b><br/>Episode contains:<br/>";
            Ext.each(arr, function(item, index){
              msg += ((index + 1).toString() + ". " + item);
              if(index != (arr.length -1)) msg += " OR<br/>";
            }, this);
            Ext.MessageBox.alert("Status", msg);
          }
        }, this);
      } else {
        Ext.MessageBox.alert("Status", "Select one episode to delete.");
      }
    }
  JS

  endpoint :can_delete_episode do |params|
    record_id = ActiveSupport::JSON.decode(params[:record_id])
    episode = TreatmentEpisode.find(record_id)
    res = episode.is_deletable?
    {:set_result => res}
  end

  def delete_data_endpoint(params)
    records = ActiveSupport::JSON.decode(params[:records])
    treatment = TreatmentEpisode.find(records.first).treatment
    episodes = treatment.treatment_episodes
    res = ((records.first == component_session[:chart_id]) or episodes.length == 1) ? true : false
    super
    {:set_result => res}
  end

end