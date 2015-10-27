class MedicalOrderAddForm < Mahaswami::FormPanel
 include ButtonsOfOasisHeader

  def initialize(conf = {}, parent_id = nil)
    super
    component_session[:treatment_id] ||= config[:parent_id]
  end

  def configuration
    c = super
    c.merge(
      signDateAndPasswordRequired: true,
      model: "MedicalOrder",
      items: [
        {name: :treatment_episode__certification_period, field_label: "Episode", item_id: :episode_id, scope: :org_scope},
        {name: :order_date, field_label: "Order Date", item_id: :order_date},
        {name: :order_type__type_description, field_label: "Order Type", item_id: :order_type_id},
        {name: :physician__full_name, field_label: "Physician", item_id: :physician_id},
        {name: :field_staff__full_name, field_label: "Field Staff", item_id: :field_staff_id},
        {name: :order_content, field_label: "Order Content", enableKeyEvents: true, rows: 15, item_id: :order_content}
      ]
    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      var medicationButton = Ext.ComponentQuery.query('#md_oder_medication')[0];
      if(medicationButton){
        medicationButton.on('click', function(){
        this.onMedicationsClick();
      },this)
      }
      var date = this.down("#order_date");
      date.on('change', function(el){
        if( el.isValid()){
          this.setDate({order_date: date.value}, function(){
            this.refreshComboStore("order_type_id");
          }, this);
        }
      },this);
      this.setDate({order_date: date.value});
      freeFormTemplateWindowEvents(this);
    }
  JS

  component :free_form_template_explorer_component do
    {   :header => false,
        :border => false,
        :class_name => "FreeFormTemplateExplorer"
    }
  end

  endpoint :set_date do |params|
    component_session[:order_date] = params[:order_date].to_date if params[:order_date]
    {}
  end

  endpoint :select_template_category do |params|
    session[:selected_template_category] = params[:template_category]
  end

  def order_type__type_description_combobox_options(params)
    unless component_session[:order_date].nil?
      treatment = PatientTreatment.find(component_session[:treatment_id])
      org = treatment.patient.org if treatment
      values = OrderType.active_scope(org, component_session[:order_date]).collect{|x| [x.id, x.type_description]}
    else
      values = OrderType.all.collect{|x| [x.id, x.type_description]}
    end
    {:data => values}
  end

  def physician__full_name_combobox_options(params)
    {:data => PatientTreatment.find(component_session[:treatment_id]).treatment_physicians.collect{|p|[p.physician.id, p.physician.full_name]}}
  end

  def field_staff__full_name_combobox_options(params)
    unless component_session[:treatment_id].blank?
      treatment = PatientTreatment.find(component_session[:treatment_id])
      staffs = treatment.fs_and_sc_staffs
      staffs = [User.current] if (User.current.is_a?(FieldStaff) and User.current.clinical_staff.blank?)
      {:data => staffs.collect{|x| [x.id, x.full_name]}.uniq}
    else
      {}
    end
  end

  def treatment_episode__certification_period_combobox_options(params)
    {:data => PatientTreatment.find(component_session[:treatment_id]).treatment_episodes.collect{|e|[e.id, e.certification_period]}}
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end
end