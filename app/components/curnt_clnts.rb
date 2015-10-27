class CurntClnts < ConsltngCmpnyHAs

  def configuration
    s = super
    s.merge(
        border: false,
        editOnDblClick: false,
        title: "Current Clients",
        columns: [
            {name: :health_agency__org_name, label: "Agency", cls: 'heading', editable: false, width: '20%'},
            {name: :health_agency__phone_number, label: "Phone", cls: 'heading', editable: false, width: '12%'},
            {name: :health_agency__fax_number, label: "Fax", cls: 'heading', editable: false, width: '12%'},
            {name: :health_agency__email, label: "Email", cls: 'heading', editable: false, width: '15%'},
            {name: :health_agency__zip_code, label: "Zip", cls: 'heading', editable: false, width: '6%'},
            {name: :health_agency__npi_number, label: "NPI", cls: 'heading', editable: false, width: '10%'},
            {name: :health_agency__cms_certification_number, cls: 'heading', label: "PTAN", editable: false, width: '7%', renderer: :format_fed_tax_number},
            {name: :health_agency__fed_tax_number, label: "TIN", cls: 'heading', editable: false, width: '10%', renderer: :format_fed_tax_number},
            {name: :active, label: "Remove", renderer: :remove_image_renderer, cls: 'heading', width: "7%"}
        ]
    )
  end

  js_method :format_fed_tax_number,<<-JS
    function(value){
      return value.substring(0,2) + '-' + value.substring(2, value.length);
    }
  JS

  js_method :remove_image_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store) {
      var recordId = record.get("id");
      var imageClick = 'Ext.ComponentQuery.query(\"#current_client_list\")[0].performAction(\"' + recordId + '\");';
      return "<div style='cursor:pointer;margin:0 0 0 20px;' onclick="+ imageClick +"><img src='/assets/wrong.png'/></div>"
    }
  JS

  js_method :perform_action,<<-JS
    function(recordId){
      Ext.MessageBox.confirm('Confirm', 'Are you sure?', function(result){
        if(result == "yes")
          this.removeHealthAgency({cha_id: recordId});
      }, this);
    }
  JS

  endpoint :remove_health_agency do |params|
    cha = ConsultingCompanyHealthAgency.find(params[:cha_id])
    cha.destroy
    {:refresh_grids => 1}
  end

  js_method :refresh_grids,<<-JS
    function(){
      this.store.load();
      this.up('#consultant_profile_explorer').down("#pending_client_list").store.load();
    }
  JS
end