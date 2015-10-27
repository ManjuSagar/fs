class Staffing < Mahaswami::Panel
  include Mahaswami::NetzkeBase

  def initialize(conf = {}, parent = nil)
    super
  end

  def configuration
    c = super
    component_session[:treatment_request_id] = c[:treatment_request_id] if c[:treatment_request_id]
    @patient_id = TreatmentRequest.find(component_session[:treatment_request_id]).patient_id
    @staffing_requirement_id = nil
    c.merge(
        {
          layout: :border,
          height: 800,
          title: "Staffing",
          item_id: :staffing_grid,
          items: [
              {region: :center,
               border: true,
               layout: :border,
               items: [
                   :treatment_request_staffs.component,
                   :staffing_requests.component
               ]
              },
              {region: :east,
               width: 600,
               border: true,
               layout: :fit,
               items: [{class_name: "StaffingMap", patient_id: @patient_id}]
              }
          ]
        })
  end

  component :treatment_request_staffs do
    {
        layout: :fit,
        region: :center,
        item_id: :treatment_request_staff_grid,
        class_name: "TreatmentRequestStaffList",
        parent_id: component_session[:treatment_request_id]
    }
  end

  component :staffing_requests do
    {
        layout: :fit,
        region: :south,
        height: "50%",
        class_name: "StaffingRequests",
        association: "staffing_requests",
        parent_model: "StaffingRequirement",
        item_id: "staffing_requests_grid",
        finalize_staffing: false,
        scope: staffs_scope,
        parent_id: @staffing_requirement_id
    }
  end

  def staffs_scope
    treatment_request_staff_id = component_session[:treatment_request_staff_id]
    return {} if treatment_request_staff_id.nil?
    staff = TreatmentRequestStaff.find_by_id(treatment_request_staff_id)
    return {} unless staff
    staffing_requirement = staff.staffing_requirement
    @staffing_requirement_id = staffing_requirement.nil?? -1 : staffing_requirement.id
     {:staffing_requirement_id => @staffing_requirement_id}
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var view = this.down('#treatment_request_staff_grid');
      view.getSelectionModel().on('selectionchange', function(selModel){
         var selectedRecord = selModel.selected.first();
         if(selectedRecord){
           this.selectTreatmentRequestStaffId({treatment_request_staff_id: selectedRecord.get('id')}, function(res){
           this.down('#staffing_requests_grid').getStore().load();
           },this);
         }
      }, this);
    }
  JS

  endpoint :select_treatment_request_staff_id do |params|
    component_session[:treatment_request_staff_id] = params[:treatment_request_staff_id]
  end


end