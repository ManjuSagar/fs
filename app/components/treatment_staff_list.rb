class TreatmentStaffList < Mahaswami::HasManyCollectionList
  association "treatment_staffs"
  title "Requirements"
  parent_model "PatientTreatment"

  def initialize(conf = {}, parent_id = nil)
    super
    components[:add_form][:items].first.merge!(:parent_id => config[:parent_id])
    components[:edit_form][:items].first.merge!(:parent_id => config[:parent_id], :treatment_staff_id => component_session[:treatment_staff_id])
  end

  def configuration
    c = super
    c.merge(
        height: 300,
        columns: [
            {name: :to_s, label: "Requirement", editable: false, width: "30%"},
            {name: :staff_name, label: "Staff", width: "50%"}
        ] + co_pay_column_if_required(c[:parent_id]),
        #enable_pagination: false,
        rows_per_page: 50,
        scope: ["scope_with_params,not_clinical_staff"] + [c[:parent_id]]
    )
  end

  add_form_config class_name: "TreatmentStaffForm", mode: :add
  edit_form_config class_name: "TreatmentStaffForm", mode: :edit
  action :add_in_form, text: "", tooltip: "Add"
  action :edit_in_form, text: "",tooltip: "Edit"
  action :broadcast, text: "", tooltip: "Broadcast Request", icon: :broadcast, itemId: :broadcast_button

  def co_pay_column_if_required(treatment_id)
    co_pay_column = []
    treatment = PatientTreatment.find(treatment_id)
    insurance_company = treatment.treatment_request.insurance_company
    co_pay_column << {name: :copay_amount, label: "Copay Amount", align: 'right'} if insurance_company.present? and insurance_company.co_pay_applicable
    co_pay_column
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
        this.selectRecord({treatment_staff_id: record.get('id')});
      }, this);
    }
  JS

  js_method :on_broadcast, <<-JS
    function(){
      this.broadcastStaffingRequest({}, function(results){
        this.store.load();
        this.up('#staffing_grid').down('#staffing_requests_grid').store.load();
      }, this);
    }
  JS

  endpoint :broadcast_staffing_request do |params|
    treatment = PatientTreatment.find(config[:parent_id])
    treatment.initiate_staffing
    {:set_result => true}
  end

  endpoint :select_record do |params|
    component_session[:treatment_staff_id] = params[:treatment_staff_id]
  end

  def default_bbar
    return [] if (Org.current.is_a? StaffingCompany)
    [:add_in_form.action, :edit_in_form.action, :del.action, :broadcast.action]
  end

  def default_context_menu
    return [] if (Org.current.is_a? StaffingCompany)
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

end