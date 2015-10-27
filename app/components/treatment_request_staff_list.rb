class TreatmentRequestStaffList < Mahaswami::HasManyCollectionList
  association "request_staffs"
  title "Requirements"
  parent_model "TreatmentRequest"

  def initialize(conf = {}, parent_id = nil)
    super
    components[:add_form][:items].first.merge!(:parent_id => config[:parent_id])
    components[:edit_form][:items].first.merge!(:parent_id => config[:parent_id], :request_staff_id => component_session[:request_staff_id])
  end

  def configuration
    super.merge(
      height: 300,
      enable_pagination: false,
      rows_per_page: 50,
      bbar: [:add_in_form.action, :edit_in_form.action, :del.action, :broadcast.action],
      context_menu: [:add_in_form.action, :edit_in_form.action, :del.action],
      columns: [
          {name: :to_s, label: "Requirement", editable: false, width: "30%"},
          {name: :staff_name, label: "Staff", width: "40%"}
      ]
    )
  end

  action :broadcast, text: "", tooltip: "Broadcast Requests", icon: :broadcast, itemId: :broadcast_button

  add_form_window_config title: "Add Staffing"
  add_form_config class_name: "TreatmentRequestStaffingForm", mode: :add
  action :add_in_form, text:  "", tooltip: "Add"

  edit_form_window_config title: "Edit Staffing"
  edit_form_config class_name: "TreatmentRequestStaffingForm", mode: :edit
  action :edit_in_form, text:  "", tooltip: "Edit"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.selectRecord({record_id: record.get('id')});
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
    treatment_request = TreatmentRequest.find(config[:parent_id])
    treatment_request.initiate_staffing
    {:set_result => true}
  end

  endpoint :select_record do |params|
    component_session[:request_staff_id] = params[:record_id]
  end

end