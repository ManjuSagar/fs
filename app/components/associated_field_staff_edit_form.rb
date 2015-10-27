class AssociatedFieldStaffEditForm < Mahaswami::FormPanel

  def configuration
    c = super
    component_session[:org_user_id] ||= c[:record_id] if c[:record_id]
    debug_log component_session[:org_user_id]
    c.merge(
        model: "OrgUser",
        strong_default_attrs: {:org_id => Org.current.id},
        layout: :border,
        items: [
            {name: :user__full_name, field_label: "Field Staff", read_only: true, scope: :field_staffs, region: :north},
            :visit_types.component
        ]
    )
  end

  component :visit_types do
    {
        region: :center,
        class_name: "OrgFieldStaffVisitTypeList",
        strong_default_attrs: {:org_user_id => component_session[:org_user_id]},
        scope: {:org_user_id => component_session[:org_user_id]},
        org_user_id: component_session[:org_user_id]
    }
  end


  js_method :on_apply, <<-JS
    function(){
      console.log(this);
      var fsVtRates = this.down('grid[name=visit_types]');
      fsVtRates.onApply();
      this.callParent();
    }
  JS

end