class OrgFieldStaffVisitTypeList < Mahaswami::GridPanel

  def initialize(conf = {}, parent_id = nil)
    super
    components[:add_form][:items].first.merge!(:org_user_id => config[:org_user_id])
    components[:edit_form][:items].first.merge!(:org_user_id => config[:org_user_id])
  end

  def configuration
    c = super
    component_session[:org_user_id] ||= c[:org_user_id]
    c.merge(
        model: "OrgFieldStaffVisitType",
        editOnDblClick: false,
        infinite_scroll: false,
        enable_pagination: false,
        title: "Rates",
        columns: [
            {name: :approved, label: "", editable: true},
            {name: :visit_type_display, label: "Visit Type", editable: false, width: "30%"},
            {name: :visit_rate, label: "Visit Rate", precision: 8, scale: 2},
            {name: :hourly_rate, label: "Hourly Rate", precision: 8, scale: 2}
        ]
    )
  end

  def default_bbar
    [:apply.action]
  end

  def default_context_menu
    []
  end

  def get_data(*args)
    org_user = Org.current.org_users.unscoped.find(component_session[:org_user_id])
    org_visit_types = OrgFieldStaffVisitType.where(:org_user_id => org_user.id)

    res = {}
    visit_types = org_visit_types.collect{|x| [x.visit_type.id, true, x.visit_type.visit_type_display, x.visit_rate, x.hourly_rate]}

    visit_types_for_discipline = Org.current.visit_types.where(discipline_id: org_user.user.license_type.discipline_id)

    visit_types_without_discipline = Org.current.visit_types.without_discipline
    visit_types += (visit_types_for_discipline + visit_types_without_discipline).select{|x| org_visit_types.any?{|o| o.visit_type == x} == false}.
                                                collect{|x| [x.id, false, x.visit_type_display, 0, 0]}
    res[:data] = visit_types
    res[:total] = visit_types.size
    res
  end

  def post_data_endpoint(params)
    modified_data = ActiveSupport::JSON.decode(params["#{:update}d_records"]) if params["#{:update}d_records"]
    modified_data.each do |rec|
      if rec.keys.include?("approved")
        if rec["approved"] == true
          debug_log "Creating Org Visit Type"
          OrgFieldStaffVisitType.create!(:org_user_id => component_session[:org_user_id], :visit_type_id => rec["id"],
                                         :visit_rate => rec["visit_rate"], :hourly_rate => rec["hourly_rate"])
        else
          debug_log "Deleting Org Visit Type"
          org_visit_type = OrgFieldStaffVisitType.find_by_org_user_id_and_visit_type_id(component_session[:org_user_id], rec["id"])
          org_visit_type.destroy if org_visit_type.present? and org_visit_type.visit_type.discipline.nil?
        end
      elsif (rec.keys.include?("visit_rate") and rec.keys.include?("hourly_rate"))
        debug_log "Updating Org Visit Type Rates"
        org_visit_type = OrgFieldStaffVisitType.find_by_org_user_id_and_visit_type_id(component_session[:org_user_id], rec["id"])
        org_visit_type.update_attributes({:visit_rate => rec["visit_rate"], :hourly_rate => rec["hourly_rate"]}) if org_visit_type.present?
      elsif rec.keys.include?("visit_rate")
        debug_log "Updating Org Visit Type Visit Rate"
        org_visit_type = OrgFieldStaffVisitType.find_by_org_user_id_and_visit_type_id(component_session[:org_user_id], rec["id"])
        org_visit_type.update_attributes({:visit_rate => rec["visit_rate"]}) if org_visit_type.present?
      elsif rec.keys.include?("hourly_rate")
        debug_log "Updating Org Visit Type Hourly Rate"
        org_visit_type = OrgFieldStaffVisitType.find_by_org_user_id_and_visit_type_id(component_session[:org_user_id], rec["id"])
        org_visit_type.update_attributes({:hourly_rate => rec["hourly_rate"]}) if org_visit_type.present?
      end
    end
    {:refresh_data => true}
  end

end