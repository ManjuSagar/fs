class StaffingRequirementNewForm < Mahaswami::FormPanel

  def configuration
    c= super
    component_session[:treatment_id] ||= c[:parent_id]
    c.merge(
        model: "StaffingRequirement",
        strong_default_attrs: {staffable_id: component_session[:treatment_id]},
        items: [
          {name: :discipline__to_s, field_label: "Discipline", item_id: :discipline_id, defaultIfSingleItem: false},
          {name: :visit_type__to_s, field_label: "Visit Type", item_id: :visit_type_id, defaultIfSingleItem: false},
          {name: :narrative, field_label: "Narrative", xtype: :textarea, rows: 8}
        ]
    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.resetSessionContext({staffing_requirement_id: this.record.id});
      this.query("#discipline_id")[0].on('select', function(ele) {
        this.selectDisciplineId({discipline_id: ele.getValue()});
      }, this);
    }
  JS

  endpoint :reset_session_context do |params|
    if config[:mode] == :edit
      sr = StaffingRequirement.find(params[:staffing_requirement_id])
      component_session[:selected_discipline_id] = sr.discipline_id
    else
      component_session[:selected_discipline_id] = nil
      {:refresh_combo_store => :visit_type_id}
    end
  end

  endpoint :select_discipline_id do |params|
    component_session[:selected_discipline_id] = params[:discipline_id]
    {:refresh_combo_store => :visit_type_id}
  end

  def get_combobox_options_endpoint(params)
    if params[:column] == "discipline__to_s"
      values = PatientTreatment.find(component_session[:treatment_id]).disciplines.collect{|d| [d.id, d.to_s]}
      {:data => values}
    elsif params[:column] == "visit_type__to_s"
      unless component_session[:selected_discipline_id].blank?
        values = Org.current.visit_types.where(:discipline_id  => component_session[:selected_discipline_id]).collect{|x| [x.id, x.to_s]}
      else
        values = Org.current.visit_types.where(:discipline_id => nil).collect{|x| [x.id, x.to_s]}
      end
      {:data => values}
    else
      super
    end
  end

end