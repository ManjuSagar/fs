class CommunicationNotesForm < Mahaswami::FormPanel
  include ButtonsOfOasisHeader

  def initialize(conf = {}, parent_id = nil)
    super
    config[:read_only] = true  if (record and record.completed?)
  end
  
  def configuration
    c = super
    component_session[:treatment_id] ||= c[:parent_id]
    sign_flag = if c[:record_id]
                  comm_note = CommunicationNote.find(c[:record_id])
                  comm_note.can_sign_comm_note?
                elsif c[:record]
                  true
                end
    c.merge(
      model: "CommunicationNote",
      show_print_icon_on_edit_form: (c[:mode] != :add),
      signDateAndPasswordRequired: sign_flag,
      trackResetOnLoad: true,
      items: [
        {name: :treatment_episode__certification_period, item_id: :episode_id, field_label: "Episode"},
        {name: :note_date_time, field_label: "Note Date", item_id: :note_date},
        {name: :note_type__type_description, field_label: "Note Type", item_id: :note_type_id},
        {name: :field_staff__full_name, field_label: "Field Staff", item_id: :field_staff_id, hidden: ((User.current.is_a? FieldStaff)? true : false)},
        {name: :note_content, field_label: "Note", enableKeyEvents: true, rows: 17}
      ],
      scope: :org_scope
    )
  end

  js_method :on_print,<<-JS
    function(){
      if(this.isDirty()) {
        Ext.MessageBox.confirm("Confirmation", "Do you want to save the changes and print?", function(btn){
          if(btn == "yes"){
            this.saveAndPrint = true;
            this.on("submitsuccess", function(){
              if (this.saveAndPrint){
                this.launchCommunicationNoteReport();
                this.saveAndPrint = false;
                 this.notifyOnSave = true;
              }
            },this);
            this.onApply();
            this.notifyOnSave = false;
          }else{this.launchCommunicationNoteReport();}
        }, this);
      }else{this.launchCommunicationNoteReport();}
    }
  JS

  js_method :launch_communication_note_report, <<-JS
    function(){
      this.getCommunicationNoteFileUrl({record_id: this.record.id}, function(res){
        if(res){
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        }
      },this);
    }
  JS

  endpoint :get_communication_note_file_url do |params|
    org = PatientTreatment.find(component_session[:treatment_id]).agency
    cn = CommunicationNote.org_scope(org).find(params[:record_id])
    session[:pre_generated_file_name] = cn.to_pdf
    {:set_result => true}
  end

  component :launch_report do
    {
        class_name: "LaunchReport",
        title: "Communication Note",
        width: '60%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      var viewMedicationButton = Ext.ComponentQuery.query('#comm_note_medication')[0]
        viewMedicationButton.on('click', function(){
          this.onMedicationsClick();
        },this);
      var date = this.down("#note_date");
      date.on('change', function(el){
        if( el.isValid()){
          this.setDate({note_date: date.value}, function(){
            this.refreshComboStore("note_type_id");
          }, this);
        }
      },this);
      this.setDate({note_date: date.value});
      freeFormTemplateWindowEvents(this);
    }
  JS

  endpoint :set_date do |params|
    component_session[:note_date] = params[:note_date].to_date if params[:note_date]
    {}
  end

  component :free_form_template_explorer_component do
    {   :header => false,
        :border => false,
        :class_name => "FreeFormTemplateExplorer"
    }
  end

  endpoint :select_template_category do |params|
    session[:selected_template_category] = params[:template_category]
  end


  def note_type__type_description_combobox_options(params)
    unless component_session[:note_date].nil?
      treatment = PatientTreatment.find(component_session[:treatment_id])
      org = treatment.patient.org if treatment
      values = OrderType.active_scope(org, component_session[:note_date]).collect{|x| [x.id, x.type_description]}
    else
      values = OrderType.all.collect{|x| [x.id, x.type_description]}
    end
    {:data => values}
  end

  def get_combobox_options_endpoint(params)
    if params[:column] == "treatment_episode__certification_period"
      {:data => PatientTreatment.find(component_session[:treatment_id]).treatment_episodes.collect{|e|[e.id, e.certification_period]}}
    elsif params[:column] == "field_staff__full_name"
      unless component_session[:treatment_id].blank?
          treatment = PatientTreatment.find(component_session[:treatment_id])
          staffs = treatment.fs_and_sc_staffs
          staffs = [User.current] if User.current.is_a?(FieldStaff)
          {:data => staffs.collect{|x| [x.id, x.full_name]}.uniq}
       else
          {}
       end
    else
      super
    end
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end
end
