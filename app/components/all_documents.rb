class AllDocuments < Mahaswami::GridPanel
  include ActionView::Helpers::NumberHelper
  include DocumentsCompRelated
  include PrintPatientProfile
  include ButtonsOfOasisHeader

  def initialize(conf = {}, parent_id = nil)
    super
    return unless @treatment
    mo_instance = @treatment.medical_orders.build(treatment_episode_id: component_session[:episode_id])
    cn_instance = @treatment.communication_notes.build(treatment_episode_id: component_session[:episode_id])
    components[:medical_order_add_form][:items].first.merge!(strong_default_attrs: {treatment_id: @treatment.id}, :parent_id => @treatment.id, :record => mo_instance)
    components[:communication_notes_form][:items].first.merge!(strong_default_attrs: {treatment_id: @treatment.id}, :parent_id => @treatment.id, :record => cn_instance)
    if component_session[:document_definition_id]
      document_definition = DocumentDefinition.find(component_session[:document_definition_id])
      patient_name = @treatment.patient.full_name
      mr_num = @treatment.patient.patient_reference
      doc_instance, title = if component_session[:doc_id]
                              [Document.find(component_session[:doc_id]), "Edit #{document_definition.document_name} Patient: #{patient_name} (MR# #{mr_num})"]
                            else
                              [("Documents::" + document_definition.document_form_template.document_class_name).constantize.new.
          configuration[:model].constantize.new(:treatment_id => @treatment.id, treatment_episode_id: component_session[:episode_id]), "New #{document_definition.document_name} Patient: #{patient_name} (MR# #{mr_num})"]
                              end
      components[:add_document].merge!(:title => title)
      if doc_instance.id
        components[:add_document][:items].first.merge!(:record_id => doc_instance.id)
      else
        components[:add_document][:items].first.merge!(:record => doc_instance)
      end
      klass_name = "Documents::" + document_definition.document_form_template.document_class_name
      components[:add_document][:items].first.merge!(:class_name => klass_name, :klass_name => klass_name,
                                                     :strong_default_attrs => {:document_definition_id => component_session[:document_definition_id],
                                                                                                        :treatment_id => @treatment.id, treatment_episode_id: component_session[:episode_id]}, :treatment_id => @treatment.id)
      components[:add_document][:items].first.delete(:model)
    end
  end

  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:episode_id] = s[:episode_id] if s[:episode_id]
    @treatment = PatientTreatment.find_by_id(component_session[:treatment_id]) if component_session[:treatment_id]
    @episode = @treatment.treatment_episodes.find(component_session[:episode_id])
    if @episode and @treatment
      #component_session[:doc_actions] =  document_actions(@treatment, @episode)
      @doc_actions =  document_actions(@treatment, @episode)
    end
    s.merge(
        model: "AllDocument",
        treatmentDischarged: @treatment.discharged?,
        treatmentHeld: @treatment.on_hold?,
        title: "Documents",
        editOnDblClick: false,
        infinite_scroll: true,
        rows_per_page: 25,
        enable_column_hide: false,
        columns: [
          {name: :documentable_type, hidden: true},
          {name: :documentable_id, hidden: true},
          {name: :treatment_episode_id, hidden: true},
          {name: :category, editable: false, width: "10%", getter: lambda {|r| "<b>#{r.category}</b>"}, addHeaderFilter: true},
          {name: :document_date_display, label: "Date", editable: false, filter1: {xtype: :datefield, attrType: :date }},
          {name: :staff, editable: false, width: "10%", addHeaderFilter: true},
          {name: :document_valid, editable: false, label: "Valid"},
          {name: :status,editable: false, width: "15%", addHeaderFilter: true},
          {name: :description, editable: false, width: "20%", addHeaderFilter: true},
          {name: :attachment, width: "16%", label: "Attachment", getter: lambda{ |r| download_links(r) }},
          action_column(s[:item_id])
        ],
        scope: ["treatment_episode_id = ? AND ((staff is not null AND documentable_type = ?) OR documentable_type <> ?)", component_session[:episode_id], "Document", "Document"]
    )
  end

  def download_links(doc)
    links = []
    if doc.documentable_type == "MedicalOrder"
      links << link_to("Printable Order", doc.documentable.printable_order.url, :target => "_blank") if doc.documentable.printable_order?
      links << link_to("Signed Order", doc.documentable.signed_order.url, :target => "_blank") if doc.documentable.signed_order.exists?
      links.join(" | ")
    elsif doc.documentable_type == "TreatmentAttachment"
      link_to("Download", doc.documentable.attachment.url, :target => "_blank")
    end
  end

  def default_bbar
    return [:md_order.action, :comm_note.action, :attachment.action, :print_document.action, :del.action] if (User.current.field_staff? && User.current.clinical_staff.blank?)
   actions =  [{text: "Add", item_id: 'menu', menu:  ([:md_order.action, :comm_note.action] + @doc_actions ), cls: "my-style"}, :attachment.action, :del.action,
               {text: "Print", item_id: 'print_menu', menu: [:print_document.action, :print_profile.action], cls: "my-style"}]
      if(@episode.treatment_last_episode?)
        (@treatment.on_hold?) ? actions << :unhold.action : actions << :hold.action
        (@treatment.on_hold?) ? '' : actions << :rc.action
        (@treatment.discharged?) ? actions << :undo.action :  actions << :dc.action
      end
    actions
  end

  def default_context_menu
    [{text: "Add Document", menu: @doc_actions},  :md_order.action, :comm_note.action, :attachment.action, :del.action]
  end

  def current_record(record_id)
    self.config[:model].constantize.find(record_id).documentable
  end

  # action :document_notes, text: "Document Notes", tooltip: "Add Document Notes", icon: :add_new, disabled: true
  action :md_order, text: "Add MD Order", tooltip: "Add MD Order",  item_id: 'add_md_order'
  action :comm_note, text: "Add Communication Note", tooltip: "Add Communication Note"
  action :attachment, text: "Attach", tooltip: "Add Attachment", cls: "my-style", item_id: 'attachment_button'
  action :print_document,  text: ((User.current.field_staff?) ? "Print" : "Document"),
         tooltip: "Print Document", icon: :print, item_id: 'print_menu'
  action :print_profile, text: "Profile", tooltip: "Print profile", icon: :print
  action :hold, text: "Hold", tooltip: "HOLD", cls: "my-style", item_id: 'hold_button'
  action :unhold, text: "Unhold", tooltip: "UNHOLD", cls: "my-style", item_id: 'unhold_button'
  action :rc, text: "RC", tooltip: "RC", cls: "my-style", item_id: 'rc_button'
  action :undo, text: "UNDO", tooltip: "UNDO DC", cls: "my-style", item_id: 'undo_button'
  action :dc, text: "DC", tooltip: "DC", cls: "my-style", item_id: 'dc_button'
  action :del, text: "Delete", tooltip: "Delete Document", cls: "my-style", item_id: 'del_button', icon: ''

  def action_column(grid_component_name = nil, width = nil)
    comp_name = grid_component_name || self.class.name.underscore
    {name: :actions, label: "", editable: false,
     :getter => lambda {|x| x.events_for_current_state.collect{|r|
       link_to_function(human_action_name(x, r), perform_event(comp_name, x, r), {id: "record_#{x.id}"})}.join(" | ")
     }
    }.merge(width.nil? ? {flex: 1} : {width: width})
  end

  def human_action_name(doc, event)
    if event.name == :what_if
      "$?"
    elsif event.name == :send_to_physician and doc.documentable_type == "MedicalOrder"
      doc.documentable.physician.default_email? ? "Mark Sent" : "Email Order"
    elsif event.name == :mark_order_received
      "Receive"
    else
      event.title
    end
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      var treatmentDischarged = this.down('#treatment_discharged');
      var treatmentHeld = this.down('#treatment_held');
      this.on('itemdblclick', function(view, record, e){
        this.showItem(record.get("documentable_id"), record.get("documentable_type"));
      }, this);
       this.getSelectionModel().on('selectionchange', function(selModel){
         var selectedRecord = selModel.selected.first();
         if(selectedRecord){
           doc_type = selectedRecord.get("documentable_type")
             if(doc_type == "MedicalOrder" || doc_type=="TreatmentAttachment"|| doc_type =="TreatmentDiscipline" || doc_type == "TreatmentActivity"){
               this.actions.printDocument.setDisabled(true);
             }else{
               this.actions.printDocument.setDisabled(false);
            }
            if(doc_type == 'TreatmentDiscipline' || doc_type == 'TreatmentActivity'){
              this.canDeleteActivityRecord({},function(res){
                if(res == false){
                this.actions.del.setDisabled(true);
                }else{
                this.actions.del.setDisabled(false);
               }
              },this);
             }
           var documentable_id = selectedRecord.get("documentable_id");
           var episodeId = selectedRecord.get("treatment_episode_id")
           if (doc_type == "Document" || doc_type == "CommunicationNote"){
              this.canDeleteRecord({record_id: documentable_id, doc_type: doc_type, episode_id: episodeId}, function(res){
                this.actions.del.setDisabled(!res);
              },this);
           }
         }
       }, this);
      this.getView().getRowClass = function(row, index) {
          var status = row.get('status')
        if (status == 'Correction Requested'){
          rowColor = 'red-color';
        }else if(status == 'HOLD-OFF' || status == 'HOLD-ON') {
          rowColor = 'light-green-color';
        }else{
         rowColor = '';
        }
        return rowColor;
      };

      if(this.treatmentDischarged){
        this.actions.rc.setDisabled(true);
        this.actions.hold.setDisabled(true);
        this.actions.undo.setDisabled(false);
      } else {
        this.actions.rc.setDisabled(false);
        this.actions.dc.setDisabled(false);
        this.actions.undo.setDisabled(true);
      }
      btn = Ext.ComponentQuery.query('#menu')[0];
      printButton = Ext.ComponentQuery.query('#print_menu')[0];
      delButton = Ext.ComponentQuery.query('#del_button')[0];
      attachButton = Ext.ComponentQuery.query('#attachment_button')[0];
      if (btn !=null || btn != undefined){
        btn.on('click', function(){
          btn.addCls('button-bg-color');
        },this);

        btn.on('mouseout', function(){
         btn.removeCls('button-bg-color');
        },this);
        }
         attachButton.on('click', function(){
           attachButton.addCls('button-bg-color');
         },this);

        attachButton.on('mouseout', function(){
          attachButton.removeCls('button-bg-color');
        },this);

      if (printButton !=null || printButton != undefined){
        printButton.on('click', function(){
         printButton.addCls('button-bg-color');
        },this);

        printButton.on('mouseout', function(){
          printButton.removeCls('button-bg-color');
        },this);
      }
      delButton.on('click', function(){
        delButton.addCls('button-bg-color');
      },this);
      delButton.on('mouseout', function(){
        delButton.removeCls('button-bg-color');
      },this);
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      menu = Ext.ComponentQuery.query('#menu')[0];
      this.documentsMenuUpdate(menu);
    }
  JS

  endpoint :can_delete_activity_record do |params|
    res = (( User.current.office_staff?) ? true : false)
    {set_result: res}
  end

  endpoint :can_delete_record do |params|
    doc_type =  params[:doc_type]
    episode = TreatmentEpisode.includes(:treatment).find(params[:episode_id])
    org =  episode.treatment.agency if episode
    res = if doc_type == "Document"
            document = Document.org_scope(org).find(params[:record_id]) if params[:record_id]
            document.deletable?
          elsif doc_type == "CommunicationNote"
            comm = CommunicationNote.org_scope(org).find(params[:record_id]) if params[:record_id]
            comm.deletable?
          end
    {set_result: res}
  end

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

  js_method :show_item, <<-JS
    function(record_id, documentable_type) {
      if (documentable_type == "Document"){
        this.setDocumentContext({document_id: record_id}, function(res){
          this.formDisplayComponentNotesAddition("add_document");
        }, this);
      }
      else if(documentable_type == "MedicalOrder"){
        this.setMoId({mo_id: record_id}, function(res){
          this.formDisplayComponentNotesAddition("medical_order_edit_form");
        }, this);
      }
      else if(documentable_type == "CommunicationNote"){
        this.setCommunicationId({communication_id: record_id}, function(res){
          this.formDisplayComponentNotesAddition("communication_notes_edit_form");
        }, this);
      }
    }
  JS

  endpoint :set_mo_id do |params|
    component_session[:mo_id] = params[:mo_id]
    {}
  end

  endpoint :set_communication_id do |params|
    component_session[:communication_id] = params[:communication_id]
    {}
  end

  js_method :form_display_component,<<-JS
    function(comp_name, btn){
      var g =this;
      var clinicalStaff;
      this.checkForClinicalStaff({}, function(res){
        clinicalStaff = res;
      },this);
      var grid = Ext.ComponentQuery.query('#'+g.itemId)[0];
      this.loadNetzkeComponent({name: comp_name, callback: function(w){
        w.show();
          w.on('close', function(){
            if (w.closeRes === "ok") {
              if(btn.text == 'Hold'){
                this.onHoldChangeStatus(grid,'HD','On Hold','#4F9FB2',clinicalStaff);
              }else if(btn.text == 'Unhold'){
                this.onHoldChangeStatus(grid,'AC','Active', '#000000',clinicalStaff);
              }else{
                history.go(0);
              }
            }
          }, this);
        btn.removeCls('button-bg-color');
      }, scope: this});
    }
  JS

  js_method :on_hold_change_status, <<js
    function(grid, status1, status2, color, clinicalStaff ){
      var patientInfo = Ext.ComponentQuery.query('#patient_info')[0];
      var pChart = Ext.ComponentQuery.query('#p_chart')[0];
      var rootNode = pChart.getRootNode();
      var socNode = rootNode.childNodes[2];
       if(socNode == undefined)
      {
        socNode = rootNode.childNodes[1];
      }
      var socNodeText = socNode.data.text;
      var colour = color;
      var status;
      var text = socNodeText.split('<')[0]+"<font color="+colour+">("+status1+")</font>"
      socNode.set('text', text);
       if(clinicalStaff == false){
         status = patientInfo.items.items[3];
       }else{
         status = patientInfo.items.items[4];
       }

      status.setText(status2);
      socNode.save();
      var g = grid;
      if(g){g.reload();}
    }
js

  endpoint :check_for_clinical_staff do |params|
    res = (User.current.clinical_staff?) ? true : false
    {set_result: res}
  end

  js_method :form_display_component_notes_addition,<<-JS
    function(comp_name, btn){
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

  component :medical_order_edit_form do
    form_config = {
        class_name: "MedicalOrderEditForm",
        bbar: [],
        parent_id: (@treatment.id if @treatment),
        record_id: (component_session[:mo_id] if component_session[:mo_id]),
        header: false
    }

    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        width: "60%",
        height: "90%",
        :auto_width => true,
        :auto_height => true,
        :title => "Edit MO Order",
        :button_align => "right",
        header: {
            titlePosition: 0,
            items:[{xtype:'button',text: "View Medications", item_id: :md_oder_medication}]
        },
        :items => [form_config]
    }
  end

  component :communication_notes_edit_form do
    form_config = {
        class_name: "CommunicationNotesForm",
        parent_id: (@treatment.id if @treatment),
        record_id: (component_session[:communication_id] if component_session[:communication_id]),
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

  endpoint :get_treatment_id do|params|
    treatment_id, document_id =   if params[:documentable_type] == "DocumentNote"
                                    doc_note = params[:documentable_type].constantize.find(params[:record_id])
                                    [doc_note.document.treatment_id, doc_note.document_id ]
                                  else
                                    [params[:documentable_type].constantize.find(params[:record_id]).treatment_id, nil]
                                  end
    {set_result: [treatment_id, document_id]}
  end

  endpoint :check_selected_record_is_document do |params|
    all_document = AllDocument.find(params[:doc_id])
    result = all_document.documentable_type == "Document"
    component_session[:document_id] = result ? all_document.documentable_id : nil
    {set_result: result}
  end

  js_method :on_md_order,<<-JS
    function(){
      this.formDisplayComponentNotesAddition("medical_order_add_form");
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
        :title => "Add MO Order",
        :button_align => "right",
        header: {
            titlePosition: 0,
            items:[{xtype:'button',text: "View Medications", item_id: :md_oder_medication}]
        },
        :items => [form_config]
    }
  end

  js_method :on_comm_note,<<-JS
    function(){
      this.formDisplayComponentNotesAddition("communication_notes_form");
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
        header: {
            titlePosition: 0,
            items:[{xtype:'button',text: "View Medications", item_id: :comm_note_medication}]
        },
        :items => [form_config]
    }
  end

  js_method :on_attachment,<<-JS
    function(){
      this.formDisplayComponentNotesAddition("treatment_attachment", btn);
    }
  JS

  component :treatment_attachment do
    form_config = {
        :class_name => "TreatmentAttachmentForm",
        :model => "TreatmentAttachment",
        :strong_default_attrs => {treatment_id: @treatment.id, treatment_episode_id: component_session[:episode_id]},
        :record => TreatmentAttachment.new,
        :bbar => false,
        :prevent_header => true
        }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :auto_width => true,
        :auto_height => true,
        :title => "Add Attachment",
        :button_align => "right",
        :items => [form_config]
    }
  end

  js_method :on_add_document, <<-JS
    function(){
      this.formDisplayComponentNotesAddition("add_document");
    }
  JS

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
        :width => "97%",
        :height => "90%",
        :button_align => "right",
        header: view_and_order_buttons,
        :items => [form_config]
    }
  end

  def perform_event(comp_name, record, event)
    if record.documentable_type == "Document" and [:submit, :sign].include?(event.name)
      <<-JS
       var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.selectDocumentKlassAndId({document_klass: "#{record.documentable_type}", document_id: "#{record.documentable_id}"}, function(){
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
                g.performAction("#{record.id}", "#{event.name}");
                w1.close();
              }
            }, this);
          }});
        }, this);
      JS
    elsif record.documentable_type == "Document" and [:approve].include?(event.name)
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.checkHippsCode({doc_id: "#{record.documentable_id}", episode_id: "#{record.treatment_episode_id}"}, function(response){
          if(response[0] == false && response[1] == false){
            var msg = "ROC HIPPS Code is not same as RC HIPPS Code. Discharge the Patient."
            Ext.MessageBox.alert("<b><i>Warning:</i></b>", msg);
          } else if(response[0] == false && response[1] == true){
            var msg = "Manually delete already generated RAP and regenerate RAP."
            Ext.MessageBox.alert("<b><i>Warning:</i></b>", msg);
          } else {
            g.setLoading(true);
            g.performAction(#{record.id}, "#{event.name}");
            g.setLoading(false);
          }
          }, this);
      JS
    elsif [:unlock].include?(event.name)
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.selectDocumentKlassAndId({document_klass: "#{record.documentable_type}", document_id: "#{record.documentable_id}"}, function(){
          g.loadNetzkeComponent({name: "popup_window", callback: function(w){
            w.show();
            w.on('close', function(){
              if (w.closeRes === "ok") {
                g.store.load();
                g.showItem(#{record.documentable_id}, "Document");
              }
            }, this);
          }});
        }, this);
      JS
    elsif record.documentable_type == "MedicalOrder" and [:mark_order_received, :sign].include?(event.name)
      if event == :mark_order_received
        <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.selectDocumentKlassAndId({document_klass: "#{record.documentable_type}", document_id: "#{record.documentable_id}"}, function(){
          g.loadNetzkeComponent({name: "signed_order_upload", callback: function(w){
            w.show();
            w.on('close', function(){
              if (w.closeRes === "ok") {
                g.performAction(#{record.id}, "#{event.name}");
              }
            }, this);
          }, scope: g});
        }, this);
        JS
      elsif event == :sign
        <<-JS
          var g = Ext.ComponentQuery.query("##{comp_name}")[0];
          g.selectDocumentKlassAndId({document_klass: "#{record.documentable_type}", document_id: "#{record.documentable_id}"}, function(){
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
                  //g.store.load();
                  w1.close();
                }
              }, this);
            }});
          }, this);
        JS
      end
    elsif record.documentable_type == "CommunicationNote" and event == :sign
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.selectDocumentKlassAndId({document_klass: "#{record.documentable_type}", document_id: "#{record.documentable_id}"}, function(){
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
                //g.store.load();
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

  endpoint :select_document_klass_and_id do |params|
    component_session[:document_klass] = params[:document_klass]
    component_session[:document_id] = params[:document_id]
  end

  endpoint :check_hipps_code do |params|
    episode = TreatmentEpisode.find(params[:episode_id])
    rc_doc = episode.recertified_doc
    roc_doc = episode.valid_roc_doc
    previous_episode = episode.previous_episode

    document_dates_condition_56_to_60_days = (roc_doc.present? and rc_doc.present? and rc_doc.document_date.between?(previous_episode.episode_55th_day, previous_episode.end_date) and
        roc_doc.document_date.between?(previous_episode.episode_55th_day, previous_episode.end_date+1))

    document_dates_condition_within_55days = (roc_doc.present? and rc_doc.present? and rc_doc.document_date.between?(episode.start_date, episode.episode_55th_day) and
        roc_doc.document_date.between?(episode.start_date, episode.episode_55th_day))

    no_visits_within_55_days = (episode.treatment_visits.empty? and rc_doc.present? and roc_doc.present?) and document_dates_condition_within_55days
    no_visits_within_55_to_60 = (episode.treatment_visits.empty? and not episode.first_episode? and rc_doc.present? and roc_doc.present? and
        document_dates_condition_56_to_60_days)
    with_visits_within_55_days = (episode.present? and episode.treatment_visits.size > 0 and roc_doc.present? and rc_doc.present? and
        document_dates_condition_within_55days)
    rap_invoice = episode.rap_invoice
    visits_within_55_to_60_days =  (episode.treatment_visits.present? and not episode.first_episode? and document_dates_condition_56_to_60_days and rap_invoice.present?)

    if (no_visits_within_55_days or no_visits_within_55_to_60 or with_visits_within_55_days or visits_within_55_to_60_days)
      rc_hipps_code = rc_doc.subm_hipps_code
      roc_doc_hips_code = roc_doc.calculate_hipps_code[1]
      res = (rc_hipps_code == roc_doc_hips_code)
      {set_result: [res, visits_within_55_to_60_days]}
    else
      {set_result: true}
    end
  end

  endpoint :get_hipps_code_and_amount do |params|
    doc = OasisEvaluation.find_by_id(params[:doc_id].to_i)
    doc ||= OasisRecertification.find_by_id(params[:doc_id].to_i)
    doc ||= OasisResumptionOfCare.find_by_id(params[:doc_id].to_i)
    score, bill_amount = doc.treatment_episode.score_hipps_code_and_bill_amount({doc: doc, regenerate_hipps_code: true}) if doc.treatment_episode
    hipps_code = score.hipps_code
    hipps_code ||= ""
    bill_amount = bill_amount ? number_to_currency(bill_amount, :format => "%n") : 0
    {set_result: [hipps_code, bill_amount]}
  end

  component :verify_user_authentication do
    {
        class_name: "VerifyUserAuthentication",
        record_klass: component_session[:document_klass],
        record_id: component_session[:document_id]
    }
  end

  component :signed_order_upload do
    form_config = {
        class_name: "MedicalOrderUploads",
        record_id: component_session[:document_id],
        bbar: false,
        header: false,
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :auto_width => true,
        :auto_height => true,
        :title => "Upload File",
        :button_align => "right",
        :items => [form_config]
    }
  end

  component :popup_window do
    {
        class_name: "PopupWindow",
        comp_name: "UnlockReasons",
        params: {document_id: component_session[:document_id]},
        width: 700,
        height: 270,
        title: "Correction Type"
    }
  end

  js_method :on_print_document, <<-JS
    function(){
    var selModel = this.getSelectionModel();
      if (selModel.getCount() != 1) {
        Ext.MessageBox.alert('Status', 'Please select record to view.');
      }else{
        var record = selModel.selected.first();
        var recordId = record.get("documentable_id");
        var documentableType = record.get("documentable_type")
        var episodeId = record.get("treatment_episode_id")
      if(record.get("documentable_type") == "Document"){
        this.viewReport({document_id: recordId, documentable_type: documentableType, episode_id: episodeId});
      }else if(record.get("documentable_type") == "CommunicationNote"){
        this.communicationReport({note_id: recordId, documentable_type: documentableType, episode_id: episodeId});
      }
     }
    }
  JS

  js_method :on_print_profile,<<-JS
    function(){
      this.printProfile();
     }
  JS

  js_method :on_dc, <<-JS
     function(){
       var btn = this.down('#dc_button');
       btn.addCls('button-bg-color');
       this.setEventName("discharge");
       this.formDisplayComponent("treatment_activity_form", btn);

    }
  JS

  js_method :on_print_profile,<<-JS
    function(){
      this.printProfile();
     }
  JS

  js_method :on_dc, <<-JS
     function(){
       var btn = this.down('#dc_button');
       btn.addCls('button-bg-color');
       this.setEventName("discharge");
       this.formDisplayComponent("treatment_activity_form", btn);

    }
  JS

  js_method :on_rc, <<-JS
    function(){
       var btn = this.down('#rc_button');
       btn.addCls('button-bg-color');
      this.formDisplayComponent("recertification_form",btn);
    }
  JS

  js_method :on_undo, <<JS
    function(){
       var btn = this.down('#undo_button');
       btn.addCls('button-bg-color');
      this.setLoading(true);
      this.undoTreatment({}, function(){
        this.setLoading(false);
        window.location.reload();
        btn.removeCls('button-bg-color');
      }, this);
    }
JS

  js_method :on_hold, <<JS
    function(){
       var btn = this.down('#hold_button');
       btn.addCls('button-bg-color');
       this.setEventName("hold");
      this.formDisplayComponent("treatment_activity_form",btn);
    }
JS

  js_method :on_unhold, <<JS
    function(){
      var btn = this.down('#unhold_button');
      btn.addCls('button-bg-color');
      this.setEventName("unhold");
      this.formDisplayComponent("treatment_activity_form",btn);
    }
JS

  js_method :on_del, <<-JS
    function(){
      if (this.getSelectionModel().selected.length == 1){
        var recordIds = [];
        var clinicalStaff;
         this.checkForClinicalStaff({}, function(res){
          clinicalStaff = res;
         },this);
        this.getSelectionModel().selected.each(function(r){
          recordIds.push(r.getId());
        });
        var selectedRecord = this.getSelectionModel().selected.first();
        var doc_type = selectedRecord.get("documentable_type");
        var record_id = selectedRecord.get("id");
        var doc_status = selectedRecord.get("status");
        var grid = Ext.ComponentQuery.query('#'+this.itemId)[0];
        Ext.Msg.confirm(this.i18n.confirmation, this.i18n.areYouSure, function(btn){
          if(btn == 'yes') {
            this.canChangeEvent({id: record_id},function(res){
              if(res == true){
                if(doc_type == 'TreatmentActivity' && doc_status == 'HOLD-OFF'){
                    this.changeActivityStatus({status: 'hold'}, function(res){
                      grid.reload();
                    },this);
                   this.onHoldChangeStatus('','HD','On Hold','#4F9FB2',clinicalStaff);
                }else if(doc_type == 'TreatmentActivity' && doc_status == 'HOLD-ON'){
                    this.changeActivityStatus({status: 'unhold'}, function(){
                      grid.reload();
                    },this);
                    this.onHoldChangeStatus('','AC','Active','#4F9FB2',clinicalStaff);
                }else{
                  this.store.load();
                }
              }
            },this);
              this.deleteData({records: Ext.encode(recordIds)}, function(){
              },this);
          }else{
            this.store.load();
          }
        }, this);
      }
    }
  JS

  endpoint :can_change_event do |params|
    activity = AllDocument.where(treatment_episode_id: component_session[:episode_id], category: "All Disciplines",
                                 documentable_type: "TreatmentActivity").order('id DESC').first
    res = ((activity && activity.id == params[:id]) ? true : false)
    {set_result: res}
  end

  endpoint :change_activity_status do |params|
    if params['status'] == 'hold'
      treatment = PatientTreatment.org_scope.where(id: component_session[:treatment_id]).last
      res = treatment.hold! if treatment.may_hold?
      {set_result: res}
    else
      treatment = PatientTreatment.org_scope.where(id: component_session[:treatment_id]).last
      res = treatment.unhold! if treatment.may_unhold?
      {set_result: res}
    end
  end

  endpoint :set_event_name do |params|
    component_session[:event_name] = params
  end

  js_method :launch_doc_report, <<-JS
    function(report_options) {
      var reportUrl = report_options[0];
      reportUrl = window.location.protocol + "//" + window.location.host + reportUrl;
      var reportTitle = report_options[1];
      if (Ext.isGecko) {
        window.location = reportUrl;
      } else {
        Ext.create('Ext.window.Window', {
            width : 800,
            height: 600,
            layout : 'fit',
            title : reportTitle,
            itemId: 'print_document',
            items : [{
                xtype : "component",
                id: 'myIframe',
                autoEl : {
                    tag : "iframe",
                    href : ""
                }
            }]
        }).show();

        Ext.getDom('myIframe').src = reportUrl;
      }
    }
  JS

  endpoint :view_report do |params|
    episode = TreatmentEpisode.includes(:treatment).find(params[:episode_id])
    org =  episode.treatment.agency if episode
    doc = Document.org_scope(org).find(params[:document_id])
    treatment = doc.treatment
    url = doc.combined_reports
    file_name = File.basename(url)
    certification_period = doc.treatment_episode
    report_title = "Patient : #{treatment.to_s}, Certification Period - #{certification_period}"
    {:launch_doc_report => ["/reports/generated/#{file_name[0..-5]}", report_title]}
  end

  endpoint :communication_report do |params|
    episode = TreatmentEpisode.includes(:treatment).find(params[:episode_id])
    org =  episode.treatment.agency if episode
    doc = CommunicationNote.org_scope(org).find(params[:note_id])
    session[:pre_generated_file_name] = doc.to_pdf
    certification_period = doc.treatment_episode
    report_title = "Patient : #{episode.treatment.to_s}, Certification Period - #{certification_period}"
    {:launch_doc_report => ["/reports/pre_generated", report_title]}
  end

end