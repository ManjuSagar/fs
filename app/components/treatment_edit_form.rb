class TreatmentEditForm < Mahaswami::FormPanel
  def configuration
    c = super
    c.merge(
        model: "PatientTreatment",
        items: [
            {name: :treatment_request__name, field_label: "Patient", :read_only => true},
            {name: :treatment_start_date, field_label: "Start Date"},
            {name: :treatment_end_date, field_label: "End Date"},
            :disciplines.component,
            :visit_types.component,

            :details.component(
                :name => :details,
                :title => "Details",
                :class_name => "Netzke::Basepack::TabPanel",
                :items => [
                           :physicians.component(
                               class_name: "Mahaswami::HasManyCollectionList",
                               association: "treatment_physicians",
                               parent_model: "PatientTreatment",
                               title: "Physicians",
                               parent_id: session[:selected_treatment_id],
                               columns: [{name: :physician__full_name, label: "Physician", editable: false, width: "40%"},
                                         {name: :primary_referral_flag, label: "Primary Physician?", editable: false, width: "40%"},
                                         {name: :require_cc_flag, label: "Require CC?", editable: false, width: "18%"}
                                        ],
                               bbar: ((Org.current.is_a? StaffingCompany) ? [] : [:add_in_form.action,:edit_in_form.action, :del.action]),
                               context_menu: ((Org.current.is_a? StaffingCompany) ? [] : [:add_in_form.action,:edit_in_form.action, :del.action])
                           ),
                           :staffs.component(
                               class_name: "TreatmentStaffList",
                               parent_id: session[:selected_treatment_id],
                           ),
                           :episodes.component(
                              class_name: "Mahaswami::HasManyCollectionList",
                              association: "treatment_episodes",
                              parent_model: "PatientTreatment",
                              title: "Episodes",
                              parent_id: session[:selected_treatment_id],
                              columns: [{name: :start_date, label: "Start Date", editable: false},
                                       {name: :end_date, label: "End Date", editable: false}
                                      ],
                              bbar: ((Org.current.is_a? StaffingCompany) ? [] : [:add_in_form.action,:edit_in_form.action, :del.action]),
                              context_menu: ((Org.current.is_a? StaffingCompany) ? [] : [:add_in_form.action,:edit_in_form.action, :del.action])                               
                           ),
                           :communication_notes.component(
                               class_name: "CommunicationNotes",
                               parent_id: session[:selected_treatment_id]
                           ),
                           :visits.component(
                               class_name: "TreatmentVisits",
                               parent_id: c[:record_id]
                           ),
                           :medical_orders.component(
                               class_name: "MedicalOrders",
                               parent_id: session[:selected_treatment_id]
                           ),
                           :visit_frequencies.component(
                               class_name: "VisitFrequencies",
                               item_id: :visit_frequency_grid,
                               parent_id: session[:selected_treatment_id]
                           ),
                           :staffing.component(
                               class_name: "StaffingRequirements",
                               item_id: "treatment_staffing_requirement",
                               scope: "staffing_master_id in (select id from staffing_masters where
                                      staffable_type='PatientTreatment' and staffable_id=#{(session[:selected_treatment_id].nil?)?
                                      0 : session[:selected_treatment_id]})"
                           ),
                           :treatment_docs.component(
                              height: 300,
                              class_name: "Documents",
                              association: "documents",
                              parent_model: "PatientTreatment",
                              parent_id: session[:selected_treatment_id],
                              item_id: :treatment_doc_grid
                           ),
                           :treatment_attachments.component(
                               height: 300,
                               class_name: "Mahaswami::HasManyCollectionList",
                               association: "attachments",
                               parent_model: "PatientTreatment",
                               parent_id: session[:selected_treatment_id],
                               columns: [ {name: :attachment_type__attachment_description, header: "Type" },
                                          {name: :attachment_name, label: "Name"},
                                          {name: :attachment_file_name, label: "File Name"},
                                          { name: :attachment, label: "", getter: lambda{ |r| link_to("Download", r.attachment.url, :target => "_blank")}},

                               ],
                               add_form_window_config: {
                                   title: "Add Attachment"
                               },
                               add_form_config: {
                                   file_upload: true,
                                   class_name: "Mahaswami::FormPanel",
                                   items:[
                                       {name: :attachment_type__attachment_description, field_label: "Type"},
                                       {name: :attachment_name, field_label: "Name"},
                                       {name: :attachment, field_label: "Select File", xtype: 'fileuploadfield', getter: lambda {|r| ""}, display_only: true}
                                   ]},
                               bbar: ((Org.current.is_a? StaffingCompany) ? [] : [:add_in_form.action, :del.action]),
                               context_menu: ((Org.current.is_a? StaffingCompany) ? [] : [:add_in_form.action, :del.action])
                           ),
                           :treatment_disciplines.component(
                               class_name: "TreatmentDisciplines",
                               association: "treatment_disciplines",
                               parent_model: "PatientTreatment",
                               title: 'Disciplines',
                               item_id: :treatment_discipline_grid,
                               parent_id: session[:selected_treatment_id],
                           ),
                           :treatment_medication.component(
                               class_name: "TreatmentMedications",
                               association: "medications",
                               parent_model: "PatientTreatment",
                               title: 'Medications',
                               item_id: :treatment_medication_grid,
                               parent_id: session[:selected_treatment_id]                               
                           ),
                            ],
                :width => "70%",
                :height=> 300,
                :border => true,
                :active_tab => 0
            )

        ]
    )

  end
  component :visit_types do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        association: :visit_types,
        scope: :without_discipline,
        columns: 2,
        read_only: false

    }
  end

  component :disciplines do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        association: :disciplines,
        read_only: false
    }
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var formScope = this;
      var disciplines = Ext.ComponentQuery.query('checkbox[name=discipline_ids]');
      Ext.each(disciplines, function(ele, index){
        if (ele.value){
          formScope.checkDisciplineDischarged({discipline_id: ele.inputValue}, function(response){
            if (response){
              ele.readOnly = true;
              var boxLabel = ele.boxLabelEl.id;
              Ext.query('#' + boxLabel)[0].style.color = 'red';
            }
          });
        }
      });
    }
  JS

  endpoint :check_discipline_discharged do |params|
    discipline_id = params[:discipline_id].to_i
    treatment_id = session[:selected_treatment_id]
    result = TreatmentDiscipline.find_by_discipline_id_and_treatment_id(discipline_id, treatment_id).discharged?
    result = result || PatientTreatment.find(treatment_id).discharged?
    {:set_result => result}
  end

end
