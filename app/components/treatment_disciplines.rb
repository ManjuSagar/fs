class TreatmentDisciplines < Mahaswami::HasManyCollectionList
  association  "treatment_disciplines"
  parent_model "PatientTreatment"


  def configuration
    c = super
    component_session[:treatment_id] = component_session[:parent_id]
    component_session[:episode_id] = c[:episode_id] if c[:episode_id]
    c.merge(
      title: "Disciplines",
      item_id: :treatment_discipline_grid,
      columns: [ {name: :discipline__discipline_description, header: "Description",  width: "20%"},
                 {name: :treatment_status, label: "Status", getter: lambda{|r| r.treatment_status.to_s.titleize}, width: "15%"},
                 action_column("treatment_discipline_grid")
               ],
      strong_default_attrs: {treatment_episode_id:  component_session[:episode_id], treatment_id: component_session[:treatment_id]},
      scope: (c[:episode_based] ? {treatment_episode_id: component_session[:episode_id]} : c[:scope])
    )
  end

  add_form_config class_name: "TreatmentDisciplinesForm", mode: :add
  add_form_window_config title: "Add Treatment Discipline"
  action :add_in_form, text: "", tooltip: "Add Treatment Discipline", item_id: "discipline_add_btn"

  def default_bbar
    User.current.office_staff? ? [:add_in_form.action] : []
  end

  def default_context_menu
    User.current.office_staff? ? [:add_in_form.action] : []
  end

  js_method :init_component, <<-JS
    function(){
      this.on('itemdblclick',function(dataview, record, item, index, e){
        return false;
      });
      this.callParent();
    }
  JS

  def perform_event(comp_name, record, event)
    if [:discharge, :hold, :unhold].include?(event.name)
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.selectTreatmentAndEvent({discipline_id: "#{record.id}", event_name: "#{event.name.to_s}"}, function(){
          g.loadNetzkeComponent({name: "treatment_activity_form", callback: function(w){
            w.show();
            w.on('close', function(){
              if (w.closeRes === "ok") {
                this.store.load();
              }
            }, g);
          }, scope: g});;
        }, g);
      JS
    else
      super
    end
  end

  endpoint :select_treatment_and_event do |params|
    treatment_discipline = TreatmentDiscipline.find_by_id(params[:discipline_id].to_i)
    component_session[:discipline_id] = params[:discipline_id]
    component_session[:treatment_id] = treatment_discipline.treatment_id
    component_session[:event_name] = params[:event_name]
    {}
  end

  component :treatment_activity_form do
    form_config = {
        class_name: "TreatmentActivityForm",
        parent_model: "PatientTreatment",
        treatment_id: component_session[:treatment_id],
        episode_id: component_session[:episode_id],
        event_name: component_session[:event_name],
        discipline_id: component_session[:discipline_id],
        strong_default_attrs: {treatment_id: component_session[:treatment_id], discipline_id: component_session[:discipline_id]},
        :border => true,
        :bbar => false,
        :prevent_header => true
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :width => "50%",
        :height => "70%",
        :title => (component_session[:event_name] ? "#{component_session[:event_name].titleize} Treatment" : "Treatment"),
        :button_align => "right",
        :items => [form_config]
    }
  end

  endpoint :treatment_discipline_record do |params|
    component_session[:treatment_discipline_id] = params[:treatment_discipline_id].to_i
  end

  js_method :refresh_treatment_grid, <<-JS
    function(args){
      this.store.load();
    }
  JS

end