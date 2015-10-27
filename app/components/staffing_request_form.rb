class StaffingRequestForm < Mahaswami::FormPanel
  # To change this template use File | Settings | File Templates.

  def initialize(conf = {}, parent = nil)
    @requirement = StaffingRequirement.find(conf[:parent_id])
    super
  end

  def configuration
    c = super
    c.merge(
        model: "StaffingRequest",
        items: [
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
            {name: :staff__full_name, field_label: "Staff", item_id: :staff_id, defaultIfSingleItem: false},
        ],
        strong_default_attrs: default_attrs(c[:parent_id])
    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.resetSessionContext();
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
    if config[:mode] == :edit
      record = StaffingRequirement.find(config[:parent_id])
      component_session[:selected_discipline_id] = record.discipline_id
      component_session[:selected_visit_type_id] = record.visit_type_id
    else
      sr = StaffingRequirement.find(config[:parent_id])
      component_session[:selected_discipline_id] = sr.discipline_id
      component_session[:selected_visit_type_id] = sr.visit_type_id
    end
  end

  def staff__full_name_combobox_options(params)
    return unless params["filter"]
    patient_preference = filter_param_value(params["filter"], "patient_preference")
    record = @requirement.staffing_master.staffable
    debug_log "Record = #{record.inspect}"
    preferred_languages = record.language_preference_specified? ? record.patient.languages : nil
    preferred_gender =  record.preferred_gender
    discipline = (component_session[:selected_discipline_id].nil?)? nil : record.disciplines.find(component_session[:selected_discipline_id])
    visit_type = (component_session[:selected_visit_type_id].nil?)? nil : Org.current.visit_types.find(component_session[:selected_visit_type_id])
    patient_address = record.patient.address_string
    staffs = Org.current.field_staffs + Org.current.staffing_companies
    values = if patient_preference == StaffingRequest::DONT_APPLY_PATIENT_PREFERENCE
       staffs.select{|s|
         s.qualified_for_staffing?(Org.current, discipline, visit_type)
       }
     else
       staffs.select{|s|
         s.qualified_for_staffing?(Org.current, discipline, visit_type, preferred_languages, preferred_gender, patient_address)
       }
     end
    {:data => values.collect{|x| ["#{x.class.name}_#{x.id}", x.full_name]}}
  end

  def default_attrs(parent_id)
    sr = StaffingRequirement.find(parent_id)
    {:staffing_requirement_id => sr.id, :discipline_id => sr.discipline_id, :visit_type_id => sr.visit_type_id, :send_notification => true}
  end

  def filter_param_value(filter_param, param_name)
    param = filter_param.detect{|f| f["property"] == param_name}
    param["value"] if param
  end
end
