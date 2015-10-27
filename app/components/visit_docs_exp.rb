class VisitDocsExp < Mahaswami::Panel

  def configuration
    c = super
    component_session[:episode_id] = c[:episode_id] if c[:episode_id]
    component_session[:treatment_id] = c[:treatment_id] if c[:treatment_id]
    c.merge(
        layout: :border,
        header: false,
        item_id: :visit_document_explorer,
        items: [
            :visits.component,
            :details.component
        ]
    )
  end

  component :visits do
    {
        class_name: "Visits",
        region: :center,
        width: "65%",
        episode_id: component_session[:episode_id],
        treatment_id: component_session[:treatment_id],
        parent_id: component_session[:treatment_id],
        episode_based: true
    }
  end


  component :details do
   {
      region: :east,
      collapsible: true,
      collapsed: User.current.office_staff?,
      title: "Documents",
      width: "40%",
      class_name: "Documents",
      association: "documents",
      parent_model: "TreatmentVisit",
      parent_id: component_session[:visit_id],
      treatment_id: component_session[:treatment_id],
      episode_id: component_session[:episode_id],
      enable_pagination: false,
      item_id: "visit_doc_grid_#{component_session[:episode_id]}",
      visit_type_from_record: true,
      strong_default_attrs: {treatment_id: component_session[:treatment_id], visit_id: component_session[:visit_id]},
      scope: {visit_id: (component_session[:visit_id] || -1)}
   }
=begin
      class_name: "Netzke::Basepack::TabPanel",
      items: [
          :visit_docs.component(
              class_name: "Documents",
              association: "documents",
              parent_model: "TreatmentVisit",
              parent_id: component_session[:visit_id],
              treatment_id: component_session[:treatment_id],
              episode_id: component_session[:episode_id],
              enable_pagination: false,
              item_id: "visit_doc_grid_#{component_session[:episode_id]}",
              visit_type_from_record: true,
              strong_default_attrs: {treatment_id: component_session[:treatment_id], visit_id: component_session[:visit_id]},
              scope: {visit_id: (component_session[:visit_id] || -1)}
          )#,.merge((c[:editable] == false)? {bbar: [], context_menu: []}: {}),
=end
=begin
          :visit_attachments.component(
              height: 300,
              class_name: "Mahaswami::HasManyCollectionList",
              association: "attachments",
              parent_model: "TreatmentVisit",
              item_id: :visit_attachments_grid,
              parent_id: component_session[:visit_id],
              enable_pagination: false,
              columns: [ {name: :attachment_type__attachment_description, header: "Type" },
                         {name: :attachment_file_name, label: "File Name"},
                         { name: :attachment, label: "", getter: lambda{ |r| link_to("Download", r.attachment.url, :target => "_blank")}},

              ],
              add_form_window_config: {
                  title: "Add Attachment"
              },
              add_form_config: {
                  class_name: "VisitAttachmentForm",
              },
              #bbar: (c[:editable] == false) ? [] :[:add_in_form.action, :del.action],
              #context_menu: (c[:editable] == false) ? [] :[:add_in_form.action, :del.action]
          ),
          :treatment_medication.component(
              class_name: "TreatmentMedications",
              association: "medications",
              parent_model: "TreatmentVisit",
              title: 'Medications',
              item_id: "visit_medication_grid",
              parent_id: component_session[:visit_id],
              visit_id: component_session[:visit_id],
              treatment_id: component_session[:treatment_id],
              enable_pagination: false
          ),#.merge((c[:editable] == false)? {bbar: [], context_menu: []}: {}),
=end
    #  ],
    #  :border => true,
    #  :active_tab => 0
   #}
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();

      var documentEventRefresh = false;
      this.down('#visit_grid').on('itemclick',function(view, record){
        this.setVisitId({visit_id : record.get('id')}, function(result){
          this.down('#visit_doc_grid_' + this.episodeId).store.load();
          //this.down('#visit_attachments_grid').store.load();
          //this.down('#visit_medication_grid').store.load();
        }, this);
      }, this);

      this.down('#visit_grid').store.on('load', function(){
        if(documentEventRefresh == false){
          this.resetSessionContext({}, function(){
            this.down('#visit_doc_grid_' + this.episodeId).store.load();
              //this.down('#visit_attachments_grid').store.load();
              //this.down('#visit_medication_grid').store.load();
          }, this);
        } else {
          documentEventRefresh = false;
        }
      }, this);

      this.down('#visit_doc_grid_' + this.episodeId).store.on('load', function(store){
        if(store.documentEventRefresh){
          store.documentEventRefresh = false;
          documentEventRefresh = true;
          this.down('#visit_grid').store.load();
        }
      }, this);
    }
  JS

  endpoint :reset_session_context do |params|
    component_session[:visit_id] = nil
    {:set_result => true}
  end

  endpoint :set_visit_id do |params|
    component_session[:visit_id] = params[:visit_id]
    {:set_result => true}
  end

end