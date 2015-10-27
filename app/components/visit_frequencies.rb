class VisitFrequencies < Mahaswami::HasManyCollectionList
  association "visit_frequencies"
  parent_model "PatientTreatment"

  def initialize(conf = {}, parent_id = nil)
    super
    return unless component_session[:treatment_id]
    doc_instance = PatientTreatment.find(component_session[:treatment_id]).visit_frequencies.build
    components[:add_form][:items].first.merge!(:parent_id => component_session[:treatment_id], :record => doc_instance)
    components[:edit_form][:items].first.merge!(:parent_id => component_session[:treatment_id])
  end

  def configuration
    c = super
    component_session[:treatment_id] = component_session[:parent_id]
    component_session[:episode_id] = c[:episode_id] if c[:episode_id]
    c.merge(
        editOnDblClick: (((User.current.field_staff?  and  User.current.clinical_staff.blank?) or Org.current.is_a? StaffingCompany)? false : true),
        title: 'Visit Frequencies',
        item_id: "visit_frequency_grid",
        columns: [{name: :discipline__to_s, label: "Discipline", editable: false, width:"20%"},
                  {name: :treatment_episode__certification_period, label: "Episode", editable: false, width:"20%"},
                  {name: :frequency_string, label: "Frequency", editable: false},
                  {name: :frequency_start_date, label: "Start Date", editable: false},
                  {name: :frequency_end_date, label: "End Date", editable: false},
                  {name: :frequency_status, label: "Status", editable: false, :getter => lambda {|l|l.frequency_status.to_s.titleize}},
                  action_column("visit_frequency_grid")
        ],
        scope: (c[:episode_based] ? {treatment_episode_id: component_session[:episode_id]} : c[:scope]),
        edit_form_window_config: {:height => "70%", :width => "60%"},
    )
  end

  def default_bbar
    [:add_in_form.action, :replace_frequency.action, :del.action]  if User.current.office_staff?
  end

  def default_context_menu
    [:add_in_form.action, :replace_frequency.action, :del.action] if User.current.office_staff?
  end

  action :add_in_form, text: "", tooltip: "Add Frequency", item_id: :add_visit_frequency
  action :edit_in_form, text: "", tooltip: "Edit Frequency"
  action :replace_frequency, text: "Replace Frequency", icon: false, disabled: true, item_id: :replace_visit_frequency
  edit_form_config        class_name: "VisitFrequencyEditForm"
  add_form_config        class_name: "VisitFrequencyAddForm"
  add_form_window_config title: "Add Frequency"
  edit_form_window_config title: "Edit Frequency"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
        this.getFrequencyStatus({frequency_id: record.get('id')}, function(result){
          this.actions.replaceFrequency.setDisabled(result[0] == "completed");
          this.actions.del.setDisabled(!result[1]);
        });
      }, this);
    }
  JS

  js_method :on_replace_frequency, <<-JS
    function(){
        var gridScope = this;
        var w = new Ext.window.Window({
          width: 300,
          height: 155,
          itemId: "replace_frequency_window",
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "",
              tooltip: "OK",
              iconCls: "ok_icon",
              listeners: {
                click: function(){
                  gridScope.getNewFrequency();
               }
              }
            },
            {
              text: "",
              tooltip: "Cancel",
              iconCls: "cancel_icon",
              listeners: {
                click: function(){w.close();}
              }
            }
          ],
            title: "Replace Frequency",
        }, this);
        w.show();
        this.loadNetzkeComponent({name: "frequency_replace_form", container:w, callback: function(w){
          w.show();
        }});
    }
  JS

  component :frequency_replace_form do
    {
        class_name: "ReplaceFrequencyForm",
        frequency_id: component_session[:selected_frequency_id]
    }
  end

  js_method :get_new_frequency, <<-JS
    function(){
      var newFrequency = Ext.ComponentQuery.query('#new_frequency')[0].value;
      var startDate = Ext.ComponentQuery.query('#start_date')[0].value;
      this.replaceFrequency({new_frequency: newFrequency, start_date: startDate});
    }
  JS

  endpoint :replace_frequency do |params|
    freq_valid = params[:new_frequency] ? VisitFrequency.parse_frequency(params[:new_frequency]).all?{|freq| VisitFrequency.frequency_string_valid?(freq) } : false

    if freq_valid
      result = ""
      begin
        ActiveRecord::Base.transaction do
          frequency = VisitFrequency.find(component_session[:selected_frequency_id])
          frequency.replace_frequency(params[:new_frequency], params[:start_date])
        end
      rescue ActiveRecord::RecordInvalid => e
        result = e.message
      end
      if result
        flash :error => result
        { :netzke_feedback => @flash }
      else
        {:refresh_grids => 1}
      end
    else
      flash :error => "Invalid Frequency: Please try again"
      { :netzke_feedback => @flash }
    end
  end

  js_method :refresh_grids, <<-JS
    function(){
      this.store.load();
      Ext.ComponentQuery.query("#replace_frequency_window")[0].close();
    }
  JS

  endpoint :get_frequency_status do |params|
    component_session[:selected_frequency_id] = params[:frequency_id]
    frequency = VisitFrequency.find(params[:frequency_id])
    result = []
    result[0] = frequency.frequency_status
    last_frequency = PatientTreatment.find_by_id(component_session[:parent_id]).visit_frequencies.
        where(:treatment_episode_id => component_session[:episode_id]).reorder('id').last
    result[1] = (last_frequency == frequency) and last_frequency.not_started?
    {:set_result => result}
  end

end