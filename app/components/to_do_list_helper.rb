module ToDoListHelper
  include Netzke


  def self.included(klass)
    klass.include ButtonsOfOasisHeader
    klass.component :add_document do
      form_config = {
          :class_name => component_session[:kn],
          :border => true,
          :bbar => false,
          :prevent_header => true,
          :record_id => component_session[:r_id],
          :treatment_id => component_session[:tid],
          :grid_item_id => config[:item_id],
          :klass_name => component_session[:kn],
          :strong_default_attrs => {:treatment_id => component_session[:tid], :episode_id => component_session[:eid],
                                    :document_definition_id => component_session[:ddid]},
      }
      {
          :lazy_loading => true,
          :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
          :width => "90%",
          :height => "80%",
          :title => component_session[:title],
          :button_align => "right",
          header: view_and_order_buttons,
          :items => [form_config]
      }
    end

    klass.component :communication_notes_edit_form do
      form_config = {
          class_name: "CommunicationNotesForm",
          parent_id: component_session[:tid],
          record_id: component_session[:r_id],
          bbar: [],
          header: false
      }

      {
          :lazy_loading => true,
          :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
          width: 650,
          height: 550,
          :auto_width => true,
          :auto_height => true,
          :title => "Edit Communication Note",
          :button_align => "right",
          header: {
              titlePosition: 0,
              items:[{xtype:'button',text: "View Medications", item_id: :comm_note_medication}]
          },
          :items => [form_config]
      }
    end

    klass.component :medical_order_edit_form do
      form_config = {
          class_name: "MedicalOrderEditForm",
          parent_id: component_session[:tid],
          record_id: component_session[:r_id],
          bbar: [],
          header: false
      }

      {
          :lazy_loading => true,
          :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
          width: 650,
          height: 550,
          :auto_width => true,
          :auto_height => true,
          :title => "Edit MO Order",
          :button_align => "right",
          header: {
              titlePosition: 0,
              items:[{xtype:'button',text: "View Medications", item_id: :comm_note_medication}]
          },
          :items => [form_config]
      }
    end

    klass.js_method :init_component, <<-JS
    function() {
      this.callParent();
      //this.getView().on('refresh', function(){
        //this.addRowColor();
      //}, this);
      this.on('itemdblclick', function(view, record, e){
        this.showItem(record.get("record_type"), record.get("id"), record.get("action_type"));
      }, this);
    }
    JS

    klass.js_method :show_item, <<-JS
    function(record_type, record_id, action_type) {
      this.getTreatmentId({record_type: record_type, record_id: record_id}, function(res) {
        var treatmentId = res.treatmentId;
        var episodeId = res.episodeId;
        if (action_type == "medical_order")
          this.setMedicalOrder({record_id: record_id, treatment_id: treatmentId, episode_id: episodeId}, function () {
          this.formDisplayComponent('medical_order_edit_form');
          }, this);
        else if (action_type == "visit")
          launchPatientWindow({component_class_name: "TreatmentVisits", treatment_id: treatmentId, params: {episode_id: episodeId}, grid_item_id: this.itemId});
        else if (action_type == "visit_document")
          launchPatientWindow({component_class_name: "VisitEditForm", treatment_id: treatmentId, height: "80%", width: "50%",
            params: {visit_id: record_id, record_id: record_id, title: "Visit", treatment_id: treatmentId, episode_id: episodeId}, grid_item_id: this.itemId});
        else if (action_type == "routesheet")
          launchPatientWindow({component_class_name: "VisitEditForm", treatment_id: treatmentId, height: "80%", width: "50%",
            params: {visit_id: record_id, record_id: record_id, title: "Visit", treatment_id: treatmentId, episode_id: episodeId}, grid_item_id: this.itemId});
        else if (action_type == "document") {
          this.setContext({record_id: record_id, document_definition_id: res.documentDefinitionId,  treatment_id: treatmentId, episode_id: episodeId}, function() {
            this.formDisplayComponent('add_document');
          }, this);
        }
        else if (action_type == "communication_note"){
           this.setCommNote({record_id: record_id, treatment_id: treatmentId, episode_id: episodeId}, function() {
            this.formDisplayComponent('communication_notes_edit_form');}, this);
        }
      });
    }
    JS

    klass.js_method :form_display_component,<<-JS
    function(comp_name){
      this.loadNetzkeComponent({name: comp_name, callback: function(w){
        w.show();
        w.on('close', function(){
          if (w.closeRes === "ok") {
            this.store.load();
          }
        }, this);
      }, scope: this});
    }
    JS

    klass.endpoint :set_comm_note do |params|
      component_session[:tid] = params[:treatment_id]
      component_session[:eid] = params[:episode_id]
      component_session[:r_id] = params[:record_id]
      {}
    end

    klass.endpoint :set_medical_order do |params|
      component_session[:tid] = params[:treatment_id]
      component_session[:eid] = params[:episode_id]
      component_session[:r_id] = params[:record_id]
      {}
    end

    klass.endpoint :set_context do |params|
      document_definition = DocumentDefinition.find(params[:document_definition_id])
      treatment = PatientTreatment.find_by_id(params[:treatment_id]) if params[:treatment_id]
      patient_name = treatment.patient.full_name
      mr_num = treatment.patient.patient_reference
      title = "Edit #{document_definition.document_name} Patient: #{patient_name} (MR# #{mr_num})" if params[:record_id]
      klass_name = "Documents::" + document_definition.document_form_template.document_class_name
      component_session[:title] = title
      component_session[:kn] = klass_name
      component_session[:tid] = params[:treatment_id]
      component_session[:eid] = params[:episode_id]
      component_session[:ddid] = params[:document_definition_id]
      component_session[:r_id] = params[:record_id]
      {}
    end

    klass.endpoint :get_treatment_id do|params|
      if params[:record_type] == "medical_order"
        medical_order = MedicalOrder.find_by_id(params[:record_id])
        {set_result: {treatment_id: medical_order.treatment_id, episode_id: medical_order.treatment_episode_id}}
      elsif params[:record_type] == "visit"
        visit = Org.current.treatment_visits.find_by_id(params[:record_id])
        {set_result: {treatment_id: visit.treatment_id, episode_id: visit.treatment_episode_id}}
      elsif params[:record_type] == "communication_note"
        communication_note = CommunicationNote.find_by_id(params[:record_id])
        {set_result: {treatment_id: communication_note.treatment_id, episode_id: communication_note.treatment_episode_id} }
      elsif params[:record_type] == "document"
        document = Document.find(params[:record_id])
        {set_result: {treatment_id: document.treatment_id, episode_id: document.treatment_episode_id, document_definition_id: document.document_definition_id}}
      end
    end
  end
end