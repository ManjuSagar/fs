class FieldStaffStaffingRequestList < Mahaswami::HasManyCollectionList
      association  "staffing_requests"
      parent_model "FieldStaff"

  def configuration
    s = super
    component_session[:request_filter] ||= StaffingRequest::ACTIVE
    s.merge(
      dockedItems: [{
          xtype: 'toolbar',
          dock: 'top',
          items: [{
                    xtype: :checkboxfield,
                    name: :active_box,
                    boxLabel: "Active",
                    item_id: :active_filter_box,
                    inputValue: "ACTIVE",
                    checked: "checked",
                    margin: '0 20 -5 0',
                  },
                  {
                    xtype: :checkboxfield,
                    name: :archive_box,
                    boxLabel: "Archive",
                    item_id: :archive_filter_box,
                    inputValue: "ARCHIVE",
                    margin: '0 0 -5 0'
                  }]
      }],
      bbar: [],
      context_menu: [],
      editOnDblClick: false,
      title: "Staffing Requests",
      parent_id: User.current.id,
      item_id: :field_staff_staffing_request_grid,
      columns: [
          {name: :staffing_requirement__to_s, label: "Requirement", editable: false, width: "15%"},
          {name: :requested_date_time, editable: false, label: "Requested Date"},
          {name: :staffing_requirement__staffing_master__health_agency__to_s, label: "Requested From", width: "20%", editable: false},
          {name: :staffing_requirement__staffing_master__patient__location, label: "Location", width: "20%", editable: false},
          {name: :request_status, label: "Status", editable: false, :getter => lambda {|l|l.request_status.to_s.titleize}},
          action_column("field_staff_staffing_request_grid")
      ],
      scope: (["scope_with_params,fs_staffing_request"] + component_session[:request_filter])
    )
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      var activeBox = this.down("#active_filter_box");
      var archiveBox = this.down("#archive_filter_box");
      var checkboxes = [activeBox, archiveBox];
      Ext.each(checkboxes, function(checkbox, index){
        checkbox.on('change', function(){
          this.addOrRemoveFilter({active: activeBox.value, archive: archiveBox.value}, function(res){
            this.store.load();
          }, this);
        }, this);
      }, this);
    }
  JS

  endpoint :add_or_remove_filter do |params|
    component_session[:request_filter] = StaffingRequest.get_statuses(params)
    {set_result: true}
  end

end