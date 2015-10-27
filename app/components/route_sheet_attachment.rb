class RouteSheetAttachment < VisitAttachmentForm

  def configuration
    s = super
    component_session[:visit_id] = s[:visit_id] if s[:visit_id]
    type = nil
    visit_start_date = nil
    if component_session[:visit_id]
      visit = TreatmentVisit.find(component_session[:visit_id])
      type = visit ? AttachmentType.route_sheet(visit.treatment.patient.org.id) : nil
      visit_start_date = visit.visit_start_date if visit
    end
    s.merge(
        model: "VisitAttachment",
        header: false,
        bbar: [],
        record: VisitAttachment.new(visit_id: component_session[:visit_id], attachment_type: type),
        file_upload: true,
        strong_default_attrs: {visit_id: component_session[:visit_id], attachment_type: type },
        items:[
            {name: :attachment_type__attachment_description, field_label: "Type", read_only: true, manually_required: true},
            {name: :attachment, field_label: "Select File", xtype: 'fileuploadfield', getter: lambda {|r| ""}, display_only: true, manually_required: true},
            {name: :attachment_date, field_label: "Date", manually_required: true, value: visit_start_date, item_id: :attachment_date}
        ]
    )
  end

end