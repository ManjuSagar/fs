class AuditsList < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge(
        model: "Audit",
        editOnDblClick: false,
        columns: [
            {name: :auditable_type, label: "Audit Type", addHeaderFilter: true},
            {name: :user__full_name, label: "Audited User", addHeaderFilter: true},
            {name: :action, label: "Action", addHeaderFilter: true},
            {name: :remote_address, label: "IP Address", addHeaderFilter: true},
            {name: :created_at, label: "Date", addHeaderFilter: true},
        ],
        scope: :org_scope
    )
  end

  def default_bbar
    []
  end

  def default_context_menu
    []
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.on("celldblclick", function(){
        return false;
      });
    }
  JS

end