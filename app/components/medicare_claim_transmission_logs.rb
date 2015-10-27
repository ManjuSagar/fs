class MedicareClaimTransmissionLogs < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge(
         model: "MedicareClaimTransmissionLog",
         title: 'Electronic Transmission Log',
         editOnDblClick: false,
         border: false,
         columns: [
             {name: :org_name, label: :"Health Agency", width: "17%", addHeaderFilter: true, editable: false},
             {name: :claim_number, label: :"Invoice #", width: "7%", addHeaderFilter: true, editable: false},
             {name: :transmission_status, label: "Transmission Status", width: "15%", addHeaderFilter: true, editable: false,
              getter: lambda{|r| get_transmission_status(r)}, filter1:
                 {xtype: 'combo', store: MedicareClaimTransmissionLog::TRANSMISSION_STATUS}},
             {name: :claim_edi_file_name, label: "File Name", width: "25%", addHeaderFilter: true, editable: false},
             {name: :created_at, label: "Date", width: "25%", addHeaderFilter: true, editable: false},
             {name: :type_of_response, label: "Response", width: "10%", addheaderFilter: true,
                   filter1: {xtype: 'combo', store: MedicareClaimTransmissionLog::RESPONSES},editable: false},
             {name: :type_of_file, label: "File Type", width: "10%", addHeaderFilter: true, editable: false,
                  filter1: {xtype: 'combo', store: MedicareClaimTransmissionLog::FileType}},

               ]
    )
  end

  action :download, text: "Download", icon: false, disabled: true

  def default_bbar
    [:download.action]
  end

  def get_transmission_status(r)
    (r.invoice.transmission_status == 'pending_trn' ? 'Pending TRN' : r.invoice.transmission_status.to_s.titleize)
  end

  js_method :on_download, <<-JS
    function() {
      this.downloadEdiFile();
    }
  JS

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.getSelectionModel().on('select', function(selModel){
        this.actions.download.setDisabled(selModel.getCount() == 0);
      }, this);
      //HACK:: After reloading a store we are setting the same url for the purpose of after load complete download will start
      this.store.on('load', function(){
        if(this.url) window.location = this.url;
        this.url = null;
      }, this);
    }
  JS

  js_method :download_edi_file,<<-JS
    function(testMode){
      var record = this.getSelectionModel().selected.items[0];
      this.downloadEdi({record_id: record.get('id')}, function(url) {
        this.url = window.location.protocol + "//" + window.location.host + url + "?target=_blank";
        this.doNotRememberAfterStoreReload = true;
        this.store.load();
        this.doNotRememberAfterStoreReload = false;
     },this);
    }
  JS

  endpoint :download_edi do |params|
    url = MedicareClaimTransmissionLog.download_url_path(params[:record_id])
    {set_result: url}
  end

end