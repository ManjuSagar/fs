module EdiFileDownloadForPrivateInsuranceInvoices

  def self.included(klass)
    klass.class_eval do
      js_method :on_edi_download, <<-JS
        function() {
          if(this.selectedRecordIds.length > 0)
          {
            this.checkSameInsuranceCompany({record_ids: this.selectedRecordIds}, function(res){
              if(res){
                this.downloadEdiFile({record_ids: this.selectedRecordIds, test_mode: 'P'}, function(res){
                  if(res[0]) {
                    var msg = "The following claim number having problem:<br/><br/>";
                    Ext.each(res[1], function(error, index){
                      msg = msg + error[0].toString() + " : " + error[1] + "<br/>";
                    }, this);
                    msg = msg + "<br/>" + "Please contact FasterNotes support at (888) 255-8508 <br/> to set up batch claim transmission."
                    Ext.Msg.show({
                      title: 'Send Error',
                      msg: msg,
                      buttons: Ext.Msg.OK,
                      icon: Ext.Msg.ERROR,
                    });
                  } else if (res[1]) {
                    this.url = window.location.protocol + "//" + window.location.host + res[1] + "?target=_blank";
                    this.doNotRememberAfterStoreReload = true;
                    this.store.load();
                    this.doNotRememberAfterStoreReload = false;
                  }
                });
              } else {
                Ext.MessageBox.alert("Status", "Select same insurance company receivables.");
              }
            });
          }
        }
      JS

      endpoint :download_edi_file do |params|        
        private_receivables = PrivateReceivable.org_scope.where(id: params[:record_ids])
        private_claims = private_receivables.group_by(&:private_insurance_invoice).keys
        errors_present, url = PrivateInsuranceInvoice.get_edi_url_and_claims_mark_as_sent(private_claims, params, private_receivables)
        {set_result: [errors_present, url]}
      end

      endpoint :check_same_insurance_company do |params|
        receivables = PrivateReceivable.org_scope.find(params[:record_ids])
        res = (receivables.map(&:payer_id).uniq.size == 1)
        {set_result: res}
      end

    end
  end

end