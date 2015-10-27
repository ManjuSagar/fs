module DocumentsCompRelated

  def self.included(klass)
    klass.class_eval do
      def document_actions(treatment, episode, attachments_required = false, routesheet_required = false)
        doc_actions = []
        required_doc_defs = get_document_definitions(treatment, episode)
        doc_actions += doc_actions_based_on_type(required_doc_defs, "add")
        if attachments_required
          doc_actions += doc_actions_based_on_type(required_doc_defs, "attach")
        end

        if routesheet_required
          self.class.action :routesheet, {text: "Attach Route Sheet", icon: false, handler: "onAttachRoutesheetClick"}
          doc_actions << :routesheet.action
        end

        doc_actions
      end


      def doc_actions_for_updating_menu(treatment, episode)
        doc_actions = []
        required_doc_defs = get_document_definitions(treatment, episode)
        doc_actions += get_actions_based_on_type(required_doc_defs, "add")
        doc_actions
      end


      def get_document_definitions(treatment, episode)
        doc_actions = []
        org = treatment.patient.org
        selected_definitions = org.document_definitions
        discipline_docs = DocumentDefinition.discipline_doc_defns_scope(org)
        documents = episode.documents.where("document_type like ?","%Oasis%").order("document_date DESC")
        oasis_eval = episode.documents.where("document_type like ?","%OasisEvaluation%")
        cancel_eval = cancel_documents("OasisEvaluation", episode)
        oasis_eval = if (oasis_eval.empty? or (oasis_eval - cancel_eval).empty?)
                       []
                     else
                       oasis_eval - cancel_eval
                     end

        recertification = episode.documents.where(["document_type in (?)",["OasisRecertification","OasisResumptionOfCare"]])
        canceled_rc_docs = episode.documents.includes(:treatment_visit).where(["document_type in (?) and
               visit_id is not null and treatment_visits.draft_status = true", ["OasisRecertification","OasisResumptionOfCare"]]).order("documents.document_date DESC")

        recertification = if (recertification.empty? or (recertification - canceled_rc_docs).empty?)
                            []
                          else
                            recertification - canceled_rc_docs
                          end
        cancel_documents = cancel_documents("Oasis", episode)
        document = (documents - cancel_documents).first
        visit_document_check = (document.present? and document.treatment_visit.present? and document.treatment_visit.draft_status == false)
        treatment_latest_document_type = if visit_document_check
                                           document
                                         elsif document and document.treatment_visit.nil?
                                           document
                                         else
                                           nil
                                         end
        latest_doc_class = treatment_latest_document_type && treatment_latest_document_type.document_type.present? ? treatment_latest_document_type.document_type : ''

        latest_doc = if episode.first_episode? == false and recertification.empty?
                       "RC"
                     elsif episode.first_episode? and oasis_eval.empty?
                       ''
                     else
                       latest_doc_class
                     end
        possible_class_names = OasisFlow.get_all_possible_oasis_docs(latest_doc)
        oasis_c1_docs = DocumentDefinition.joins("INNER JOIN document_form_templates
           ON document_definitions.document_form_template_id = document_form_templates.id").where(
            ["document_form_templates.document_class_name IN (?) AND org_id = ?", possible_class_names, org.id])
          oasis_c1_docs = (treatment.private_insurance?  ? DocumentDefinition.oasis_c1_scope(org) : oasis_c1_docs)

        required_doc_defs = if episode.start_date < Date.new(2015,01,01)
                              selected_definitions
                            else
                              discipline_docs + oasis_c1_docs
                            end
      end

      def cancel_documents(type, episode)
        episode.documents.includes(:treatment_visit).where("document_type like ? and
               visit_id is not null and treatment_visits.draft_status = true","%#{type}%").order("documents.document_date DESC")
      end

      def get_actions_based_on_type(definitions, prefix)
        doc_actions = []
        definitions.each {|d|
          action_name = "#{prefix}_#{d.document_code.downcase}".to_sym
          list = {text: "#{prefix.capitalize} #{d.document_name}", icon: false, document_class_name: d.document_class_name}
          doc_actions << list
        }
        doc_actions
      end


      def doc_actions_based_on_type(definitions, prefix)
        doc_actions = []
        definitions.each {|d|
          action_name = "#{prefix}_#{d.document_code.downcase}".to_sym
          self.class.action action_name, {text: "#{prefix.capitalize} #{d.document_name}", icon: false, document_class_name: d.document_class_name,
                                          handler: "on#{prefix.capitalize}DocumentClick"}
          doc_actions << action_name.action
        }
        doc_actions
      end

      js_method :documents_menu_update, <<-JS
        function(menu){
          if(menu != null || menu != undefined){
            menu.on('click', function(){
              this.getActions({}, function(res){
                menu = Ext.ComponentQuery.query('menu');
                docMenu = menu[0];
                list = docMenu.items.items;
                docMenu.removeAll();
                g = this;
                Ext.each(res, function(el, index){
                  var action = new Ext.Action({
                    text: el["text"],
                    handler: function(){
                      if(el["text"] == 'Add MD Order'){
                        g.onAddMdOrderClick();
                      } else if(el["text"] == 'Add Communication Note'){
                        g.onAddCommNoteClick();
                      } else {
                        g.onAddDocumentClick({documentClassName: el.documentClassName});
                      }
                    },
                  });
                  docMenu.add(action);
                },this);
              },this);
            },this);
          }
        }
      JS

      endpoint :get_actions do |params|
        doc_actions = [{text: 'Add MD Order'}, {text: 'Add Communication Note'}]
        doc_actions = doc_actions + doc_actions_for_updating_menu(@treatment, @episode)
        {set_result: doc_actions}
      end

      js_method :on_add_document_click, <<-JS
        function(params) {
          this.setDocumentContext({document_class_name: params.documentClassName}, function() {
            this.onAddDocument();
          }, this);
        }
      JS

      js_method :on_add_md_order_click, <<-JS
        function(params) {
          this.onMdOrder();
        }
      JS

      js_method :on_add_comm_note_click, <<-JS
        function(params) {
          this.onCommNote();
        }
      JS

      js_method :on_attach_document_click, <<-JS
        function(params) {
          this.setDocumentContext({document_class_name: params.documentClassName}, function() {
            this.onAttachDocument();
          }, this);
        }
      JS

      js_method :on_attach_routesheet_click, <<-JS
        function(params) {
          this.onAttachRoutesheet();
        }
      JS
    end
  end
end
