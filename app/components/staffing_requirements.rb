class StaffingRequirements < Mahaswami::GridPanel

  def initialize(conf = {}, parent_id = nil)
    super
    components[:add_form][:items].first.merge!(:parent_id => config[:parent_id])
    components[:edit_form][:items].first.merge!(:parent_id => config[:parent_id])
  end

  def configuration
    c = super
    c.merge(
        model: "StaffingRequirement",
        title: "Staffing",
        item_id: c[:item_id],
        bbar: (c[:item_id] == "treatment_staffing_requirement" ? default_bbar : [:broadcast_staffing_request.action]),
        columns: [
            {name: :to_s, header: "Requirement", editable: false, width: "25%"},
            {name: :staffing_master__created_date_time, header: "Created Date", editable: false, width: "20%"},
        ] + ((c[:item_id] == "treatment_staffing_requirement")? [{name: :staffing_status, header: "Status", editable: false,
              width: "10%", :getter => lambda {|l|l.staffing_status.to_s.titleize}}, action_column("treatment_staffing_requirement")] : [])
    )
  end

  def default_bbar
    [ :add_in_form.action, :edit_staffing_requirement.action, :del.action]
  end

  def default_context_menu
    [ :add_in_form.action, :edit_staffing_requirement.action]
  end

  action :add_in_form, text: "", tooltip: "Add Staffing"
  action :edit_staffing_requirement, text: "", tooltip: "Edit Staffing", icon: :edit
  edit_form_config class_name: "StaffingRequirementNewForm", mode: :edit
  edit_form_window_config width: "40%", height: "40%"
  add_form_config class_name: "StaffingRequirementNewForm", mode: :add
  add_form_window_config width: "40%", height: "40%"

  action :broadcast_staffing_request, text: "Broadcast Staffing Request", icon: false

  js_method :init_component, <<-JS
    function(){
      this.on('itemdblclick',function(dataview, record, item, index, e){
        this.editFormForStaffingRequirement();
        return false;
      });
      this.resetSessionContext();
      this.callParent();

      this.on('itemclick', function(view, record){
        this.selectStaffingRequirementId({staffing_requirement_id: record.get('id')});
      });
    }
  JS

  endpoint :reset_session_context do |params|
    component_session[:selected_staffing_requirement_id] = nil
  end

  js_method :edit_form_for_staffing_requirement, <<-JS
    function(){
      this.broadcastedStaffingRequest({}, function(response){
          if(response[1] == "treatment_request_staffing_requirement"){
            this.launchStaffingRequestGrid(response[2]);
          }else if(response[0] && response[1] == "treatment_staffing_requirement"){
            this.launchStaffingRequestGrid(response[2]);
          }else if(!response[0] && response[1] == "treatment_staffing_requirement"){
            this.onEditInForm();
          }
      });
    }
  JS

  js_method :on_edit_staffing_requirement, <<-JS
    function(){
      this.editFormForStaffingRequirement();
    }
  JS

  js_method :on_broadcast_staffing_request, <<-JS
    function(){
      this.sendBroadcastStaffingRequest();
    }
  JS

  endpoint :send_broadcast_staffing_request do |params|
    request = TreatmentRequest.find(config[:parent_id])
    request.initiate_staffing
    {:refresh_grids => true}
  end

  js_method :refresh_grids, <<-JS
    function(flag){
      Ext.ComponentQuery.query('#treatment_request_staffing_requirement')[0].store.load();
      Ext.ComponentQuery.query('#allocated_staffs')[0].store.load();
    }
  JS

  endpoint :broadcasted_staffing_request do |params|
    set_results = [false]
    sr = StaffingRequirement.find(component_session[:selected_staffing_requirement_id])
    set_results[0] = true unless sr.staffing_requests.empty?
    set_results[1] = config[:item_id]
    set_results[2]  = "Patient: #{sr.staffing_master.patient_full_name} - Requirement: #{sr.to_s}"
    {set_result: set_results}
  end

  js_method :launch_staffing_request_grid, <<-JS
    function(windowTitle){
      var w = new Ext.window.Window({
          title: windowTitle,
          modal: true,
          layout: 'fit',
          width: "60%",
          height: "50%",
        });
        w.show();
        this.loadNetzkeComponent({name: "staffing_requests", container:w, callback: function(w){
          w.show();
          }
        });

        w.on('close', function(){
          this.store.load();
        }, this);
    }
  JS

  component :staffing_requests do
    {
        class_name: "StaffingRequests",
        header: false,
        parent_id: component_session[:selected_staffing_requirement_id],
        association: "staffing_requests",
        parent_model: "StaffingRequirement"
    }
  end

  endpoint :select_staffing_requirement_id do |params|
    component_session[:selected_staffing_requirement_id] = params[:staffing_requirement_id]
  end

end