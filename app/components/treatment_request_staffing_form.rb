class TreatmentRequestStaffingForm < Mahaswami::FormPanel

  def configuration
    c = super
    component_session[:treatment_request_id] ||= c[:parent_id]
    component_session[:request_staff_id] ||= c[:request_staff_id]
    c.merge(
        model: "TreatmentRequestStaff",
        title: "Staff",
        item_id: :request_staff_add_form,
        items: [
            {name: :discipline__to_s, field_label: "Discipline", item_id: :discipline_id, defaultIfSingleItem: false, editable: false},
            {name: :visit_type__to_s, field_label: "Visit Type", item_id: :visit_type_id, defaultIfSingleItem: false, editable: false},
            {
                xtype: 'radiogroup',
                fieldLabel: "Filter Staff",
                labelAlign: 'left',
                item_id: :patient_preference,
                columns: 1,
                items: [
                    {
                        xtype: 'radiofield',
                        name: "apply_patient_preference",
                        inputValue: "0",
                        field_label: "",
                        boxLabel: 'Based on patient preference'
                    },
                    {
                        xtype: 'radiofield',
                        name: "apply_patient_preference",
                        inputValue: "1",
                        field_label: "",
                        boxLabel: 'Show all staffs'
                    }
                ]
            },
            {name: :staff__full_name, item_id: :staff_id, field_label: "Staff", defaultIfSingleItem: false, editable: false},
        ]
    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.resetSessionContext();

      this.down('#discipline_id').on('select', function(ele) {
        this.selectDisciplineId({discipline_id: ele.getValue()});
      }, this);

      this.down('#visit_type_id').on('select', function(ele) {
        this.selectVisitTypeId({visit_type_id: ele.getValue()});
      }, this);

      this.setStaffFilter(this.record.apply_patient_preference);
      this.down('#patient_preference').on('change', function(ele) {
        this.setStaffFilter(this.down("[name=apply_patient_preference]").getGroupValue());
      }, this);
    }
  JS

  js_method :set_staff_filter, <<-JS
    function(filter_value){
      var staffStore = this.down('#staff_id').store;
      staffStore.remoteFilter = true;
      staffStore.clearFilter();
      staffStore.filter([{property: "patient_preference", value: filter_value}]);
    }
  JS

  endpoint :select_discipline_id do |params|
    component_session[:selected_discipline_id] = params[:discipline_id]
    component_session[:selected_visit_type_id] = nil
    {:refresh_combo_store => [:visit_type_id, :staff_id]}
  end

  endpoint :select_visit_type_id do |params|
    component_session[:selected_visit_type_id] = params[:visit_type_id]
    {:refresh_combo_store => :staff_id}
  end

  endpoint :reset_session_context do |params|
    if config[:mode] == :edit and component_session[:request_staff_id]
      record = TreatmentRequestStaff.find(component_session[:request_staff_id])
      component_session[:selected_discipline_id] = record.discipline_id
      component_session[:selected_visit_type_id] = record.visit_type_id
    else
      component_session[:selected_discipline_id] = nil
      component_session[:selected_visit_type_id] = nil
      {:refresh_combo_store => [:visit_type_id, :staff_id]}
    end
  end

  def staff__full_name_combobox_options(params)
    return unless params["filter"]
    patient_preference = filter_param_value(params["filter"], "patient_preference")
    record = TreatmentRequest.find(component_session[:treatment_request_id])
    staffs = record.staffs_for_referral({discipline_id: component_session[:selected_discipline_id],
                       visit_type_id: component_session[:selected_visit_type_id],
                       request_staff_id: component_session[:request_staff_id],
                       patient_preference: patient_preference})
    {:data => staffs.collect{|x| ["#{x.class.name}_#{x.id}", x.full_name]}}
  end

  def discipline__to_s_combobox_options(params)
    values = TreatmentRequest.find(component_session[:treatment_request_id]).disciplines.collect{|d| [d.id, d.to_s]}
    {:data => values}
  end

  def visit_type__to_s_combobox_options(params)
    values = VisitType.get_visit_types(component_session[:selected_discipline_id])

    if component_session[:request_staff_id]
      visit_type = TreatmentRequestStaff.get_visit_type(component_session[:request_staff_id])
      values << [visit_type.id, visit_type.to_s] if visit_type
    end
    values = values.uniq
    {:data => values}
  end

  def filter_param_value(filter_param, param_name)
    param = filter_param.detect{|f| f["property"] == param_name}
    param["value"] if param
  end

end