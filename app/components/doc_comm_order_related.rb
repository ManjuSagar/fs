module DocCommOrderRelated


  def self.included(klass)
    klass.class_eval do
      include ButtonsOfOasisHeader
      component :add_document do
        form_config = {
            :class_name => "Mahaswami::FormPanel",
            :border => true,
            :bbar => false,
            :prevent_header => true,
            :grid_item_id => config[:item_id]
        }
        {
            :lazy_loading => true,
            :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
            :width => "93%",
            :height => "80%",
            :button_align => "right",
             header: view_and_order_buttons,
            :items => [form_config]
        }
      end

      js_method :on_md_order,<<-JS
        function(){
          this.formDisplayComponent("medical_order_add_form");
        }
      JS

      component :medical_order_add_form do
        form_config = {
            class_name: "MedicalOrderAddForm",
            bbar: [],
            header: false
        }

        {
            :lazy_loading => true,
            :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
            width: 600,
            height: 550,
            :auto_width => true,
            :auto_height => true,
            header: {
                titlePosition: 0,
                items:[ medications_button('md_oder_medication') ]
                },
            :title => "Add MO Order",
            :button_align => "right",
            :items => [form_config]
        }
      end

      js_method :on_comm_note,<<-JS
        function(){
          this.formDisplayComponent("communication_notes_form");
        }
      JS

      component :communication_notes_form do
        form_config = {
            class_name: "CommunicationNotesForm",
            signDateAndPasswordRequired: true,
            bbar: [],
            mode: :add,
            header: false
        }

        {
            :lazy_loading => true,
            :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
            width: 600,
            height: 550,
            :auto_width => true,
            :auto_height => true,
            :title => "Add Communication Note",
            :button_align => "right",
            :items => [form_config],
            header: {
                titlePosition: 0,
                items: [ medications_button('comm_note_medication') ]
            }
        }
      end

      js_method :on_add_document, <<-JS
        function(){
          this.formDisplayComponent("add_document");
        }
      JS

      js_method :form_display_component,<<-JS
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

      endpoint :set_document_context do |params|
        doc_definition = if params[:document_id]
                           Document.find(params[:document_id]).document_definition
                         else
                           treatment = PatientTreatment.find(component_session[:treatment_id])
                           treatment.document_definition(params[:document_class_name])
                         end

        component_session[:form_class_name] = doc_definition.document_class_name
        component_session[:document_definition_id] = doc_definition.id
        component_session[:document_name] = doc_definition.document_name
        component_session[:doc_id] = params[:document_id]
        {:set_result => 1}
      end
    end
  end

end