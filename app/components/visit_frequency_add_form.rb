class VisitFrequencyAddForm < Mahaswami::FormPanel

  def configuration
    c = super
    component_session[:treatment_id] ||= c[:parent_id]
    c.merge(
      model: "VisitFrequency",
      item_id: :visit_frequency_add_form,
      items: [
        {name: :treatment_episode__certification_period, field_label: "Episode", item_id: :episode_id},
        {name: :discipline__to_s, field_label: "Discipline", item_id: :discipline_id},
        {name: :frequency_start_date, field_label: "Start Date", value: pre_populate_start_date, dateFormat: 'm-d-Y' },
        {name: :frequency_string, field_label: "Frequency", afterLabelTextTpl: '<a style="cursor:pointer;" onclick="Ext.ComponentQuery.query(\'#visit_frequency_add_form\')[0].displayAcceptableFormats();">
          <img style="postion:relative;top:100px" src="/images/icons/information.png" class="info_image" data-qtip="Information"></img></a>'},
      ]
    )
  end

  def discipline__to_s_combobox_options(params)
    {:data => PatientTreatment.find(component_session[:treatment_id]).treatment_disciplines.episode_scope(component_session[:episode_id]).select{|d| d.active? }.
            collect{|d|[d.discipline.id, d.discipline.discipline_description]}}
  end

  def treatment_episode__certification_period_combobox_options(params)
    {:data => PatientTreatment.find(component_session[:treatment_id]).treatment_episodes.collect{|x| [x.id, x.certification_period]} }
  end

  def pre_populate_start_date
    frequency = PatientTreatment.find(component_session[:treatment_id]).visit_frequencies.reorder('frequency_start_date').last
    frequency.present?? frequency.frequency_end_date + 1 : Date.current
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.query("#episode_id")[0].on('select', function(ele) {
        this.selectEpisodeId({episode_id: ele.getValue()});
      }, this);
    }
  JS

  endpoint :select_episode_id do |params|
    component_session[:episode_id] = params[:episode_id]
    {:refresh_combo_store => [:discipline_id]}
  end

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
        class_name: "FrequencyInformation"
    }
  end

end