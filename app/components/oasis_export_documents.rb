class OasisExportDocuments < Mahaswami::GridPanel

  def configuration
    c = super
    c.merge(
        model: 'OasisExport',
        checkboxModel: true,
        edit_on_dbl_click: false,
        infinite_scroll: false,
        enable_pagination: false,
        columns: [
            {name: :oasis_document__document_definition__document_name, header: 'OASIS', editable: false, width: "13%", addHeaderFilter: true},
            {name: :oasis_document__treatment__to_s, header: 'Patient', width: "13%", editable: false, addHeaderFilter: true},
            {name: :oasis_document_date_display, header: 'Date', width: "10%", editable: false, filter1: {xtype: "datefield"}},
            {name: :export_status, label: "Status", editable: false, :getter => lambda {|l| export_status(l)}, width: "10%", filter1: {xtype: "combo", store: OasisExport::STATUS_STORE}},
            {name: :exported_date_display, header: 'Exported', editable: false, width: "10%", addHeaderFilter: true},
            {name: :record_type, header: 'Record Type', editable: false, width: "13%", addHeaderFilter: true},
            {name: :correction_num_display, header: 'Correction Num', editable: false, width: "13%", addHeaderFilter: true},
        ],
    scope: :org_scope
    )
  end


  def export_status(l)
    status = l.export_status.to_s
    status == 'ready_for_export' ? 'Ready' : status.titleize
  end

  def default_bbar
    [:export.action]
  end

  def default_context_menu
    [:export.action]
  end

  action :export, text: "Export", icon: false

  js_method :on_export, <<-JS
    function() {
      this.exportOasisDocuments(false);
    }
  JS

  js_method :export_oasis_documents,<<-JS
    function(testMode){
      var ids = []
      Ext.each(this.getSelectionModel().selected.items, function(s) {
        ids.push(s.getId());
      });
      this.exportDocuments({document_ids: ids, test_mode: testMode}, function(url) {
        this.url = window.location.protocol + "//" + window.location.host + url + "?target=_blank";
        this.doNotRememberAfterStoreReload = true;
        this.store.load();
        this.doNotRememberAfterStoreReload = false;
     },this);
    }
  JS


  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.actions.export.disable();
      this.on('itemclick', function(view, record){
        this.selectRecord({record_id: record.get('id')}, function(res){
          if(res) {
            var model = this.getSelectionModel();
            model.deselect(record);
          }
        }, this);
      });

      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.export.setDisabled(selModel.getCount() == 0);
      }, this);
      //HACK:: After reloading a store we are setting the same url for the purpose of after load complete download will start
      this.store.on('load', function(){
        if(this.url) window.location = this.url;
        this.url = null;
      }, this);
    }
  JS

  endpoint :select_record do |params|
    component_session[:oasis_export_id] = params[:record_id]
    export = OasisExport.org_scope.find(component_session[:oasis_export_id])
    res = export.rejected?
    {set_result: res}.merge(res ? {:netzke_feedback => "Rejected OASIS document can't be Exported"} : {})
  end

  endpoint :export_documents do |params|
    test_mode_flag = (params[:test_mode] == true)
    url = OasisExport.export_oasis_document(Org.current, params[:document_ids], test_mode_flag)
    {set_result: url}
  end

  endpoint :undo_export_to_ready do |params|
    OasisExport.undo_exported_to_ready(params[:document_ids])
    {set_result: true}
  end

  component :edit_oasis_form do
    #document = Document.find_by_id(component_session[:document_id])
    document = Document.first
    form_config = {
        :class_name => "Documents::#{document.document_form_template.document_class_name}",
        :model => config[:model],
        :persistent_config => config[:persistent_config],
        :bbar => false,
        :prevent_header => true,
        :mode => config[:mode]
        # :record_id gets assigned by deliver_component dynamically, at the moment of loading
    }

    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :title => "Edit #{document.document_definition.document_name}",
        :button_align => "right",
        :items => [form_config]
    }
  end


end