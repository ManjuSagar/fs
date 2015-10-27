class StaffingRequests < Mahaswami::HasManyCollectionList

  def initialize(conf = {}, parent = nil)
    super
    components[:edit_form][:items].first.merge!(:parent_id => config[:parent_id], :record_id => component_session[:selected_staffing_request_id])
    components[:add_form][:items].first.merge!(:parent_id => config[:parent_id])
  end

  def configuration
    c = super
    c.merge(
        model: "StaffingRequest",
        title: "Staffing Requests",
        border: 0,
        item_id: :staffing_requests_grid,
      columns: [
          {name: :requested_date_time, editable: false, label: "Requested Date", width: "30%"},
          {name: :staff_full_name, label: "Requested To", editable: false, width: "30%"},
          {name: :request_status, label: "Status", width: "25%", editable: false, :getter => lambda {|l| l.status_display }},
          action_column("staffing_requests_grid")
      ],
      scope: c[:scope].nil?? :org_scope : c[:scope],
      #enable_pagination: false,
      rows_per_page: 50
    )
  end

  def human_action_name(event)
    if event.name == :decline
      "FS Decline"
    elsif event.name == :interested
      "FS Interested"
    else
      event.title
    end
  end

  add_form_config  class_name: "StaffingRequestForm", mode: :add
  edit_form_config class_name: "StaffingRequestForm", mode: :edit
  add_form_window_config title: "Add Staffing"
  edit_form_window_config title: "Edit Staffing"

  def default_bbar
     finalize_action = (config[:finalize_staffing] == false)? [] : [:finalize_staffing.action]
     [:add_in_form.action] + finalize_action
  end

  def default_context_menu
    [:add_in_form.action]
  end

  action :add_in_form, text: "", tooltip: "Add Staff Request"
  action :edit_in_form, text: "", tooltip: "Edit Staff Request"
  action :finalize_staffing, text: "Finalize Staffing"

  def perform_event(comp_name, record, event)
    @last_staffing_requirement_id = record.staffing_requirement_id
    if [:select, :undo, :cancel].include?(event.name)
      <<-JS
        var staffsGrid = Ext.ComponentQuery.query('##{comp_name}')[0];
        staffsGrid.performAction(#{record.id}, '#{event.name}');
        var requestStaffGrid = staffsGrid.up('#staffing_grid').down('#treatment_request_staff_grid');
        var treatmentStaffGrid = staffsGrid.up('#staffing_grid').down('#treatment_staff_grid');
        if (requestStaffGrid != null)
          requestStaffGrid.store.load();
        else if (treatmentStaffGrid != null)
          treatmentStaffGrid.store.load();
      JS
    else
      super
    end
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.selectStaffingRequestId({staffing_request_id: record.get('id')});
      });

    }
  JS

  js_method :on_finalize_staffing, <<-JS
    function(){
      this.finalizeStaffing({}, function(result){
        if(result){
          this.store.load();
          this.up('#staffing_grid').down('#staffing_requests_grid').store.load();
        }
      });
    }
  JS

  endpoint :finalize_staffing do |params|
    requirement = StaffingRequirement.find_by_id(config[:parent_id])
    result = false
    if requirement
      requirement.finalize_staffing! if requirement.may_finalize_staffing?
      result = true
    end
    {:set_result => result}
  end

  endpoint :select_staffing_request_id do |params|
    component_session[:selected_staffing_request_id] = params[:staffing_request_id]
  end

end