class CommunicationNotes < Mahaswami::HasManyCollectionList
      association "communication_notes"
      parent_model "PatientTreatment"
      
      def initialize(conf = {}, parent_id = nil)
        super
        return unless component_session[:treatment_id]
        doc_instance = PatientTreatment.find(component_session[:treatment_id]).communication_notes.build
        components[:add_form][:items].first.merge!(:parent_id => component_session[:treatment_id], :record => doc_instance)
        components[:edit_form][:items].first.merge!(:parent_id => component_session[:treatment_id])
      end

      def configuration
        c = super
        component_session[:treatment_id] = component_session[:parent_id]
        c.merge(
          model: "CommunicationNote",
          title: "Communication Notes",
          item_id: "comm_note_id",
          parent_id: c[:parent_id],
          columns: [
            {name: :treatment__to_s, label: "Patient", editable: false},
            {name: :treatment_episode__certification_period, label: "Episode", editable: false, width: "20%"},
            {name: :note_type_display, label: "Note Type", editable: false, width: "20%"},
            {name: :note_date, label: "Date", editable: false},
            {name: :attachment, width: "8%", label: "Attachment", getter: lambda { |r| link_to("Download", r.printable_content.url, :target => "_blank") if r.printable_content? }},
            {name: :note_status, label: "Status", editable: false, :getter => lambda {|l|l.note_status.to_s.titleize}, width: "15%"},
            action_column("comm_note_id")
          ],
          scope: (c[:episode_commnotes] ? {treatment_episode_id: c[:episode_id]} : c[:scope])
        )
      end
      add_form_config  class_name: "CommunicationNotesForm", mode: :add
      edit_form_config        class_name: "CommunicationNotesForm", mode: :edit
      add_form_window_config width: "60%", height: "80%"
      edit_form_window_config width: "60%", height: "80%"
      action :add_in_form, text: "Add Note"
      action :edit_in_form, text: "Edit Note"

      def default_bbar
        return [] if (Org.current.is_a? StaffingCompany)
        actions = [:add_in_form.action, :edit_in_form.action, :del.action]
        actions << :medical_order.action if User.current.office_staff?
        actions
      end

      def default_context_menu
        return [] if (Org.current.is_a? StaffingCompany)
        [:add_in_form.action, :edit_in_form.action, :del.action]
      end
      
      action :medical_order, text: "Create Medical Order", :disabled => true, :icon => false
      
      js_method :init_component, <<-JS
        function(){
          this.callParent();
          this.on('itemclick', function(view, record){
            this.selectNoteId({comm_note_id: record.get('id')}, function(result){
              this.actions.medicalOrder.setDisabled(!result);
            });             
          });
        }
      JS
      
      endpoint :select_note_id do |params|
        component_session[:selected_note_id] = params[:comm_note_id]
        result = CommunicationNote.find(params[:comm_note_id]).completed?
        {:set_result => result}  
      end
      
      
      js_method :on_medical_order, <<-JS
        function(){
          this.createMedicalOrder({},function(reference){
            Ext.ComponentQuery.query('#medical_order_grid')[0].store.load();
            Ext.MessageBox.alert('Status', "Medical Order(Reference #"+ reference + ") created successfully.");
          });
        }      
      JS

      endpoint :create_medical_order do |params|
        note = CommunicationNote.find(component_session[:selected_note_id])
        note.create_medical_order
        {:set_result => note.medical_order.order_reference}
      end
      
      def perform_event(comp_name, record, event)
        if event == :sign
          <<-JS
            var g = Ext.ComponentQuery.query("##{comp_name}")[0];
            g.setSessionContext({note_id: "#{record.id}"}, function(){
              var w1 = new Ext.window.Window({
                width: "25%",
                height: "25%",
                modal: true,
                layout:'fit',
                title: "Electronic Signature",
              });
              w1.show();
              g.loadNetzkeComponent({name: "verify_user_authentication", container:w1, callback: function(w){
                w.show();
                w.on('close', function(){
                  if (w.signRes === true) {
                    g.performAction(#{record.id}, "#{event.name}");
                    g.store.load();
                    w1.close();
                  }
                }, this);
              }});
            }, this);
          JS
        else
          super
        end
      end

      endpoint :set_session_context do |params|
        component_session[:note_id] = params[:note_id]
      end

      component :verify_user_authentication do
        {
            class_name: "VerifyUserAuthentication",
            record_klass: "CommunicationNote",
            record_id: component_session[:note_id]
        }
      end

end
