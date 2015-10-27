class PendngClnts < ConsltngCmpnyHAs

  def configuration
    s = super
    s.merge(
        border: false,
        title: "Pending Clients",
        editOnDblClick: false,
        columns: [
            {name: :health_agency__org_name, label: "Agency", cls: 'heading', editable: false, width: '30%'},
            {name: :health_agency__phone_number, label: "Phone", cls: 'heading', editable: false, width: '15%'},
            {name: :health_agency__fax_number, label: "Fax", cls: 'heading', editable: false, width: '15%'},
            {name: :health_agency__email, label: "Email", cls: 'heading', editable: false, width: '30%'},
            {name: :active, label: "Add", cls: 'heading', renderer: :add_image_renderer, width: "9%"}
        ]
    )
  end

  js_method :add_image_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store) {
      var recordId = record.get("id");
      var imageClick = 'Ext.ComponentQuery.query(\"#pending_client_list\")[0].performAction(\"' + recordId + '\");';
      return "<div style='cursor:pointer;margin:0 0 0 8px;' onclick="+ imageClick +"><img src='/assets/right1.png'/></div>"
    }
  JS

  js_method :perform_action,<<-JS
    function(recordId){
      this.addHealthAgency({cha_id: recordId});
    }
  JS

  endpoint :add_health_agency do |params|
    cha = ConsultingCompanyHealthAgency.find(params[:cha_id])
    cha.activate
    cha.save!
    {:refresh_grids => 1}
  end

  js_method :refresh_grids,<<-JS
    function(){
      this.store.load();
      this.up('#consultant_profile_explorer').down("#current_client_list").store.load();
    }
  JS
end