class Audits < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
        layout: :border,
        header: false,
        items: [
            :audits_list.component,
            :audit_details.component
        ]
    )
  end

  component :audits_list do
    {
        class_name: "AuditsList",
        item_id: :audits_list,
        region: :center
    }
  end

  component :audit_details do
    {
        class_name: "AuditDetails",
        item_id: :audit_detail_list,
        region: :east,
        width: 500,
        audit_id: component_session[:audit_id]
    }
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.resetSessionContext();
      this.down("#audits_list").on("itemclick", function(view, record){
        this.selectAuditId({audit_id: record.get("id")}, function(result){
          this.down("#audit_detail_list").store.load();
        }, this);
      }, this);
    }
  JS

  endpoint :reset_session_context do |params|
    component_session[:audit_id] = nil
  end

  endpoint :select_audit_id do |params|
    component_session[:audit_id] = params[:audit_id]
  end


end