class TreatmentStaffForm < Mahaswami::FormPanel

  def configuration
    c = super
    component_session[:treatment_id] ||= c[:parent_id]
    component_session[:treatment_staff_id] ||= c[:treatment_staff_id]
    @treatment = PatientTreatment.find(component_session[:treatment_id]) if component_session[:treatment_id]
    c.merge(
        model: "TreatmentStaff",
        title: "Add Staff",
        items: [
            {name: :discipline__discipline_description, field_label: "Discipline", item_id: :discipline_id, defaultIfSingleItem: false, editable: false,
             scope: "id in (select DISTINCT discipline_id from treatment_disciplines d where d.treatment_id = #{component_session[:treatment_id]})"},
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
            {name: :staff__full_name, field_label: "Staff", item_id: "staff_id", defaultIfSingleItem: false, editable: false}
        ] + co_pay_column_if_required(c[:parent_id]),
    )
  end

  def co_pay_column_if_required(treatment_id)
    co_pay_column = []
    treatment = PatientTreatment.find(treatment_id)
    insurance_company = treatment.treatment_request.insurance_company
    co_pay_column << {name: :co_pay_amt, field_label: "Copay Amount"} if insurance_company.present? and insurance_company.co_pay_applicable
    co_pay_column
  end

  def staff__full_name_combobox_options(params)
    return unless params["filter"]
    patient_preference = filter_param_value(params["filter"], "patient_preference")
    record = PatientTreatment.find(component_session[:treatment_id])
    staffs = record.staffs_for_treatment({discipline_id: component_session[:selected_discipline_id],
                                         visit_type_id: component_session[:selected_visit_type_id],
                                         treatment_staff_id: component_session[:treatment_staff_id],
                                         patient_preference: patient_preference})
    {:data => staffs.collect{|x| ["#{x.class.name}_#{x.id}", x.full_name]}}
  end

  def visit_type__to_s_combobox_options(params)
    values = VisitType.get_visit_types(component_session[:selected_discipline_id])
    if component_session[:treatment_staff_id]
      visit_type = TreatmentStaff.get_visit_type(component_session[:treatment_staff_id])
      values << [visit_type.id, visit_type.to_s] if visit_type
      values = values.uniq
    end
    {:data => values}
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.resetSessionContext();
      this.query("#discipline_id")[0].on('select', function(ele) {
        this.selectDisciplineId({discipline_id: ele.getValue()});
      }, this);
      this.query("#visit_type_id")[0].on('select', function(ele){
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

  endpoint :reset_session_context do |params|
    if config[:mode] == :edit and component_session[:treatment_staff_id]
      record = TreatmentStaff.find(component_session[:treatment_staff_id])
      component_session[:selected_discipline_id] = record.discipline_id
      component_session[:selected_visit_type_id] = record.visit_type_id
    else
      component_session[:selected_discipline_id] = nil
      component_session[:selected_visit_type_id] = nil
      {:refresh_combo_store => [:visit_type_id, :staff_id]}
    end
  end

  endpoint :select_discipline_id do |params|
    component_session[:selected_discipline_id] = params[:discipline_id]
    component_session[:selected_visit_type_id] = nil
    {:refresh_combo_store => [:visit_type_id, :staff_id]}
  end

  endpoint :select_visit_type_id do |params|
    component_session[:selected_visit_type_id] = params[:visit_type_id]
    {:refresh_combo_store => :staff_id}
  end

  def filter_param_value(filter_param, param_name)
    param = filter_param.detect{|f| f["property"] == param_name}
    param["value"] if param
  end

end