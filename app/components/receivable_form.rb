class ReceivableForm < Mahaswami::FormPanel

  def configuration
    super.merge(
      model: "Receivable",
      items: [
        {name: :receivable_date, field_label: "Date", value: Date.current, allow_blank: false},
        {name: :receivable_type, field_label: "Type", xtype: 'combo', store: Receivable::RECEIVABLE_TYPES, item_id: :receivable_type, allow_blank: false},
        {name: :source__description, field_label: "Supply", item_id: :supply_id, allow_blank: false},
        {name: :purpose},
        {name: :service_units, field_label: "Service Units", item_id: :service_units, minValue: 0, hideTrigger: true, keyNavEnabled: false, mouseWheelEnabled: false, allow_blank: false},
        {name: :receivable_amount, field_label: "Amount", item_id: :receivable_amount, xtype: :numberfield, minValue: 0, hideTrigger: true, keyNavEnabled: false, mouseWheelEnabled: false, allow_blank: false},
        {name: :hcpcs_code, field_label: "HCPCS Code", item_id: :hcpcs_code},
        {name: :revenue_code, field_label: "Revenue Code"}
      ]
    )
  end

  def source__description_combobox_options(params)
    values = []
    values =  if params[:query].blank?
                Org.current.supplies
              else
                Supply.where(["org_id = ? AND (upper(supply_hcpcs_code) LIKE ? OR upper(supply_description) LIKE ?)", Org.current.id, "%#{params[:query]}%".upcase, "%#{params[:query]}%".upcase])
              end
    values.collect!{|s| ["#{s.class.name}_#{s.id}", "(#{s.supply_hcpcs_code}) - #{s.supply_description}"]}
    {:data => values}
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      var supplyId = this.down('#supply_id');
      var hcpcsCode = this.down('#hcpcs_code');
      var serviceUnits = this.down('#service_units');
      var receivableAmount = this.down('#receivable_amount');
      supplyId.hide();

      this.down('#receivable_type').on('change', function(ele){
        this.checkSupplyTypeSelected({receivable_type: ele.value}, function(result){
          hcpcsCode.setReadOnly(result);
          if(result)
            supplyId.show();
          else
            supplyId.hide();
        }, this);
      }, this);

      supplyId.on('change', function(ele){
        this.setHcpcsCodeAndAmount({supply_id: ele.value, service_units: serviceUnits.value}, function(result){
          hcpcsCode.setValue(result[0]);
          if(serviceUnits.value == null)
            serviceUnits.setValue(1);
          receivableAmount.setValue(result[1]);
        }, this);
      }, this);

      serviceUnits.on('change', function(ele){
        this.setHcpcsCodeAndAmount({supply_id: supplyId.value, service_units: ele.value}, function(result){
          hcpcsCode.setValue(result[0]);
          receivableAmount.setValue(result[1]);
        }, this);
      }, this);
    }
  JS

  endpoint :check_supply_type_selected do |params|
    result = (Receivable::SUPPLY_TYPE == params[:receivable_type])
    {:set_result => result }
  end

  endpoint :set_hcpcs_code_and_amount do |params|
    supply_id = params[:supply_id] ? params[:supply_id].split("_").last : nil
    supply = Org.current.supplies.find_by_id(supply_id)
    res = if supply
            unit = params[:service_units] ? params[:service_units] : 1
            supply_price = supply.supply_price || 0
            [supply.supply_hcpcs_code, supply_price * unit]
          else
            ["", ""]
          end
    {:set_result => res}
  end

end