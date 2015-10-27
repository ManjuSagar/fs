class MedicareRemittances < Mahaswami::Panel
  def configuration
    c = super
    c.merge(
        layout: {type: 'border'},
        header: false,
        item_id: :remittances_grid,
        items: [
            :medicare_remits_list.component,
            :medicare_remit_claim_details.component
        ]
    )
  end

  component :medicare_remits_list do
    {
        region: :west,
        width: "50%",
        class_name: "MedicareRemitsList",
        item_id: :medicare_remits_list_grid,
        auto_scroll: true,
        medicare_remittance_id: (component_session[:medicare_remittance_id] || -1)
    }
  end

  component :medicare_remit_claim_details do
    {
        class_name: "MedicareRemitClaimDetails",
        item_id: :claim_details_grid,
        title: "Medicare Remittance Claims",
        auto_scroll: true,
        border: true,
        region: :center,
        scope: {medicare_remittance_id: (component_session[:medicare_remittance_id] || -1)},
    }
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.down('#medicare_remits_list_grid').on('itemclick',function(view, record){
        this.setRemittanceId({remit_id : record.get('id')}, function(result){
          this.down('#claim_details_grid').store.load();
        }, this);
      }, this);
    }
  JS

  endpoint :set_remittance_id do |params|
    component_session[:medicare_remittance_id] = params[:remit_id]
    {}
  end
end