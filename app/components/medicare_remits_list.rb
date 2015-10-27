class MedicareRemitsList < Mahaswami::GridPanel
  def configuration
    c = super
    c.merge(
        model: 'MedicareRemittance',
        title:  "Medicare Remittances",
        edit_on_dbl_click: false,
        columns: [
            {name: :check_eft_date_display, header: "Check Date", editable: false, width: '13%', addHeaderFilter: true},
            {name: :check_eft_type, header: "Check/EFT Type", editable: false, width: '16%', addHeaderFilter: true},
            {name: :check_eft_amount, header: "Check/EFT Amount", align: 'right', editable: false, width: '19%', renderer: :formattedAmount},
            {name: :check_eft_number, header: "Check/EFT Number",width: '22%', editable: false, addHeaderFilter: true},
            {name: :total_no_of_claims, header: "Total Claims", width: '13%', editable: false},
            {name: :medicare_remittance_file_name, header: "File Name ", width: '25%', editable: false, addHeaderFilter: true},

        ],
        scope: :org_scope
    )
  end

  def default_bbar
    [:add_in_form.action, :view_remit_summary.action]
  end

  def default_context_menu
    [:add_in_form.action, :view_remit_summary.action]
  end
  action :add_in_form, text: "", item_id: 'upload_medicare_button', icon: :upload, tooltip: "Upload Remittance File"
  add_form_config class_name: "RemittanceUploads"
  add_form_window_config title: "Upload Remits"
  action :view_remit_summary, text: "", tooltip: "View Remittance Summary", disabled: true, item_id: 'view_remit_claim_button', icon: :view_details

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.viewRemitSummary.setDisabled(selModel.getCount() == 0);
      }, this);
    }
  JS

  js_method :on_view_remit_summary, <<-JS
    function(){
      this.loadNetzkeComponent({name: "popup_window", callback: function(w){
        w.show();
        w.on('close', function(){
          if (w.closeRes === "ok") {
            this.store.load();
          }
        }, this);
      }});
    }
  JS

  component :popup_window do
    {
        class_name: "PopupWindow",
        comp_name: "MedicareRemittanceSummary",
        params: {medicare_remittance_id: config[:medicare_remittance_id]},
        width: '50%',
        height: '95%',
        title: "Remittance Summary"
    }
  end

end