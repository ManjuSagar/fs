class PhysicianForm < Mahaswami::FormPanel

  def initialize(conf = {}, parent_id = nil)
    super
  end

  def configuration
    c = super
    c.merge(
        model: "OrgPhysician",
        cityStatePrefill: false,
        item_id: 'physician_form',
        items: [{
            border: false,
            margin: '0 0 5% 0',
            items: [{
                border: false,
                layout: :hbox,
                style: 'margin: 0 0 5% 1%;',
                bodyStyle: 'padding-top: 10px; padding-right: 1%',
                items: [
                    {name: :npi_number, field_label: 'Search Physician', flex: 2, xtype: :netzkeremotecombo, hide_trigger: true,
                            enable_key_events: true, margin: "0 4% 0 0", allow_blank: false, emptyText: 'NPI',
                              label_width: '50%', item_id: 'npi_number'},
                    {name: :pecos_verification, field_label: 'PECOS Verification', item_id: "pecosVerification", flex: 1,
                        read_only: true, margin: "0 0 0 5%", xtype: :checkbox, label_width: '170%'}
                ]
            },
            {
                 border: false,
                 layout: :hbox,
                 style: 'margin-left: 1%;',
                 bodyStyle: 'padding-top: 10px; padding-right: 1%',
                 items: [
                    {name: :first_name, field_label: 'Name', emptyText: 'First Name', allow_blank: false, flex: 3,
                        label_width: '67%', margin: "0 5% 0 0", read_only: true, item_id: 'firstName'},
                    {name: :last_name, field_label: '', emptyText: 'Last Name', flex: 1.8, margin: "0 5% 0 0",
                        read_only: true, item_id: 'lastName'},
                    {name: :suffix, field_label: '', emptyText: 'Suffix', flex: 0.6, item_id: 'suffix'},
                 ]
            },
            {                
                border: false,
                layout: :hbox,
                style: 'margin-left: 1%;',
                bodyStyle: 'padding-top: 10px; padding-right: 1%',
                items: [
                    {name: :street_address, field_label: 'Address', emptyText: 'Street Address', label_width: '33%',
                        flex: 4.7, margin: "0 5% 0 0", allow_blank: false, item_id: 'streetAddress'},
                    {name: :suite_number, field_label: '', emptyText: 'Suite #', flex: 0.58, item_id: 'suiteNumber'}
                ]
            },
            {
                border: false,
                layout: :hbox,
                style: 'margin-left: 1%;',
                bodyStyle: 'padding-top: 10px; padding-right: 1%',
                items: [
                    {name: :city, field_label: 'City/State/Zip', flex: 5.5, emptyText: 'City', label_width: '46%',
                      margin: "0 5% 0 0", allow_blank: false, item_id: 'city'},
                    {name: :state, field_label: '', xtype: 'combo', flex: 1.4, emptyText: 'State', margin: "0 5% 0 0",
                      store: State.all.collect{|x|[x.state_code, x.state_description]}, editable: false, item_id: 'state'},
                    {name: :zip_code, field_label: '', flex: 0.85, emptyText: 'ZIP Code', item_id: 'zipCode'}
                ]
            },
            {
                border: false,
                layout: :hbox,
                style: 'margin-left: 1%;',
                bodyStyle: 'padding-top: 10px; padding-right: 1%',
                items: [
                    {name: :phone_number, field_label: 'Phone', flex: 3.9, label_width: '81%',  margin: "0 5% 0 0",
                       emptyText: "Primary Phone", item_id: 'phoneNumber', input_mask: '(999) 999-9999'},
                    {name: :personal_phone_number_1, field_label: '', flex: 2, emptyText: "Alternate Phone", margin: "0 5% 0 0",
                       input_mask: '(999) 999-9999', item_id: 'phone_number_2', value: component_session[:contact_1]},
                    {name: :fax_number, field_label: '', flex: 2, input_mask: '(999) 999-9999', emptyText: 'Fax',
                            label_separator: '', item_id: 'faxNumber'},
                ]
            },
            {
                border: false,
                layout: :hbox,
                style: 'margin-left: 1%;',
                bodyStyle: 'padding-top: 10px; padding-right: 1%',
                items: [
                    {name: :email, field_label: 'Email', emptyText: 'Email Address',width: '75%', label_width: '41%',
                                allow_blank: true, item_id: 'email', vtype: 'email'}
                ]
            }]
        }]
    )
  end

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      var npiNumber = Ext.ComponentQuery.query('#npi_number')[0];
      var item_ids = ["firstName", "lastName", "suffix", "streetAddress", "suiteNumber", "city", "state",
                            "zipCode", "phoneNumber", "faxNumber", "pecosVerification"];
      npiNumber.on('keyup', function(t, e) {
        if(e.getKey()!= e.ENTER){
          Ext.each(item_ids, function(item_id){
            this.down("#"+item_id).setValue('');
          },this);
        }
      },this);
      npiNumber.on('select', function() {
        this.loadPhysicianDetails({npi_number: npiNumber.value}, function(result) {
          Ext.each(item_ids, function(item_id){
          var value = '';
          if(item_id == 'streetAddress'){
            value = result['addressLine1'];
          }else if(item_id == "suiteNumber"){
            value = result["addressLine2"].substring(0, 10);
          }else if(item_id == "zipCode"){
            value = result["zipCode"].substring(0,5);
          }else if(item_id == "phoneNumber"){
            value = this.formattedValues(result["phoneNumber"]);
          }else if(item_id == "faxNumber") {
            value = this.formattedValues(result["faxNumber"]);
          } else {
            value = result[item_id];
          }
          if(value){this.down("#"+item_id).setValue(value);}
          }, this);
        });
      }, this);
    }
  JS

  js_method :formatted_values, <<-JS
  function(data) {
    var res = '';
    if(data) {
      res = "("+data.substring(0,3)+") "+data.substring(3,6)+"-"+data.substring(6);
    }
    return res;
  }
  JS

  def get_combobox_options_endpoint(params)
    res = if params["query"].blank?
            [[]]
          else
            physicians = NpiRegistryPhysician.where("lower(npi_number) like '%#{params["query"]}%'").limit(25)
            physicians.collect{|x| [x.npi_number, "#{x.npi_number} (#{x.last_name})"]}
          end
    {:data =>  res}
  end


  endpoint :load_physician_details do |params|
    physician = NpiRegistryPhysician.where(npi_number: params[:npi_number]).first
    fields = ["first_name", "last_name", "suffix", "address_line1", "address_line2", "suite_number", "city", "state", "zip_code",
     "phone_number", "fax_number", "pecos_verification"]
    res = {}
    fields.each{|x| res[x] = physician[x]}
    {set_result: res}
  end

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      var npi_number = Ext.ComponentQuery.query('#npi_number')[0];
      npi_number.store.on('load', function(){
        npi_number.store.removeAt(0);
      });
    }
  JS
 end
