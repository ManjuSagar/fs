class PatientsListExplorer < Mahaswami::Panel

  def configuration
    s = super
    s.merge({
      title: "Active Patients",
      layout: :border,
      items: [
          :search_panel.component,
          :patients_list.component
      ]
    })
  end

  component :search_panel do
    {
      class_name: "FilterAndSearchPanel",
      context: "active_patients",
      region: :north,
      xtype: :fieldset,
      margin: 0,
      hidden: true,
      title: "Filter Conditions"
    }
  end

  component :patients_list do
    {
      class_name: "PatientsList",
      region: :center,
      margin: 0,
      header: false,
      scope: patients_list_scope(component_session[:dates])
    }
  end

  def patients_list_scope(dates)
    return :active if dates.nil?
    if dates.empty?
      return :active
    else
      ids = Patient.filter_active_patients(dates[0], dates[1]).map(&:id)
      return ids.empty? ? "id = -1" : "id in (#{ids.join(', ')})"
    end
  end

  js_method :init_component,<<-JS
    function(){
      this.resetSessionContext();
      this.callParent();
      this.down('#apply_filter').on('click', function( ele, e, eOpts){
        var socFromDate = this.down('#soc_from_date').value;
        var socToDate = this.down('#soc_to_date').value;

        var canSend = false;
        if(socFromDate != null && socToDate != null){
          canSend = true;
        } else if(socFromDate == null && socToDate == null){
          canSend = true;
        }
        if(canSend){
            this.filterActivePatients({soc_from_date: socFromDate, soc_to_date: socToDate}, function(){
              this.down('#active_patients').store.load();
            }, this);
        }else{
          Ext.MessageBox.alert("Status", "Both <b>From</b> and <b>To</b> dates are required to filter.");
        }
      }, this);
    }
  JS

  endpoint :reset_session_context do |params|
    component_session[:dates] = nil
  end

  endpoint :filter_active_patients do |params|
    args = []
    if params[:soc_from_date] and params[:soc_to_date]
      args << params[:soc_from_date]
      args << params[:soc_to_date]
    end
    component_session[:dates] = args
    {}
  end

end