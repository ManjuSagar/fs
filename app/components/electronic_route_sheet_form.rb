class ElectronicRouteSheetForm < Mahaswami::FormPanel
  
  def initialize(conf ={}, parent_id = nil)
    super
    config[:record] = ElectronicRoutesheet.new
  end
  
  def configuration
    c = super
    component_session[:treatment_id] ||= c[:parent_id]
    fs_is_independent = User.current.independent_fs?
    c.merge(
    header: false,
    autoScroll: true,
    bbar: [],
    model: 'ElectronicRoutesheet',
      :items => (fs_is_independent ? [] : [{name: :supervised_user_id, field_label: "Supervised User", xtype: 'combo', store: ElectronicRoutesheet.supervised_users_list(component_session[:treatment_id]), allowBlank: false}]) +
        [{name: :treatment_episode, field_label: "Episode", xtype: 'combo', item_id: :episode_id, store: ElectronicRoutesheet.treatment_episodes_list(component_session[:treatment_id]), allowBlank: false},
        {name: :visit_type_id, field_label: "Visit Type", xtype: 'combo', item_id: :vt_id, store: ElectronicRoutesheet.visit_types_list(component_session[:treatment_id], component_session[:episode_id]), allowBlank: false},
        {name: :visit_date, field_label: "Visit Date", allowBlank: false},
        {
            layout: :hbox,
            border: false,
            items: [
                {
                    name: :start_time_hour,
                    field_label: 'Start Time ',
                    xtype: :numberfield,
                    maxValue: 24,
                    minValue: 00,
                    flex: 1
                },
                {
                    xtype: :label,
                    text: ":"
                },
                {
                    name: :start_time_min,
                    field_label: ' ',
                    xtype: :numberfield,
                    label_separator: '',
                    label_width: 5,
                    maxValue: 60,
                    minValue: 00,
                    flex: 1
                }
            ],
            flex: 1,
        },
        {name: :visit_end_date, field_label: "Visit End Date", allowBlank: false, margin: '5px 0 0 0'},
        {
            layout: :hbox,
            margin: '5 0',
            border: false,
            items: [
                {
                    name: :end_time_hour,
                    field_label: 'End Time ',
                    xtype: :numberfield,
                    maxValue: 23,
                    minValue: 00,
                    flex: 1
                },
                {
                    xtype: :label,
                    text: ":"
                },
                {
                    name: :end_time_min,
                    field_label: ' ',
                    xtype: :numberfield,
                    label_separator: '',
                    label_width: 5,
                    maxValue: 59,
                    minValue: 00,
                    flex: 1
                }
            ],
            flex: 1,
        },
        {name: :location_latitude, item_id: :location_latitude, xtype: 'textfield', read_only: true },
        {name: :location_longitude, item_id: :location_longitude, xtype: 'textfield', read_only: true},
        {name: :patient_signature, xtype: 'signatureCapture', margin: '0 0 0 20'},
        {
            xtype: 'panel',
            border: false,
            layout: {
                type: 'accordion',
                fill: false,
            },
            items: [
                {
                    xtype: 'panel',
                    title: "Vitals",
                    border: false,
                    collapsed: false,
                    layout: :column,
                    defaults: {padding: 1, hideTrigger: true, mouseWheelEnabled: false},
                    columns: 2,
                    items: [
                        {name: :systolic_bp, field_label: "Systolic BP", xtype: 'numberfield'},
                        {name: :diastolic_bp, field_label: "Diastolic BP", xtype: 'numberfield',},
                        {name: :bp_read_location,  field_label: 'BP Read Location', xtype: :combo, store: TreatmentVital::BP_LOCATION, editable: false, hideTrigger: false, mouseWheelEnabled: true},
                        {name: :bp_read_position, field_label: 'BP Read Position', xtype: :combo, store: TreatmentVital::BP_POSITION, editable: false, hideTrigger: false, mouseWheelEnabled: true},
                        {name: :heart_rate, field_label: "Heart Rate", xtype: 'numberfield'},
                        {name: :respiration_rate, field_label: "Respiration Rate", xtype: 'numberfield'},
                        {name: :temperature_in_fht, field_label: "Temperature(&degF)", xtype: 'numberfield',},
                        {name: :blood_sugar, field_label: "Blood Sugar", xtype: 'numberfield'},
                        {name: :sugar_read_period, field_label: "Sugar Read Period", xtype: :combo, store:TreatmentVital::SUGAR_READ_PERIOD, editable: false, hideTrigger: false, mouseWheelEnabled: true},
                        {name: :weight_in_lbs, field_label: "Weight(lbs)", xtype: 'numberfield'},
                        {name: :oxygen_saturation, field_label: "Oxygen Saturation", xtype: 'numberfield'},
                        {name: :pain, field_label: "Pain", xtype: 'numberfield'},

    ]
                }
            ]
        }

      ],
		strong_default_attrs: {treatment_id: component_session[:treatment_id]}
    )
  end

	js_method :init_component, <<-JS
    function(){
      this.callParent();
			this.refreshComboBoxes();

			this.down("#episode_id").on('select', function(ele) {
        this.down("#vt_id").reset();
        this.selectEpisodeId({episode_id: ele.value});
      }, this);
			
		}
	JS

  js_method :on_apply,<<-JS
    function(){
      var formScope = this;
      if(formScope.setByMe == true) {
        formScope.setByMe = false;
        this.callParent();
        return;
      }
      var values = this.getForm().getValues();
      this.checkVisitIsOverlapped({values: values}, function(res){
        if (res) {
          Ext.MessageBox.confirm("Warning:", res, function(btn){
            if (btn == 'yes') {
              Ext.Function.defer(function(){
                formScope.setByMe = true;
                formScope.onApply();
              }, 10);
            }
          });
        } else {
          Ext.Function.defer(function(){
            formScope.setByMe = true;
            formScope.onApply();
          }, 10);
        }
      },this);
    }
  JS

  endpoint :check_visit_is_overlapped do |params|
    params[:values] = params[:values].merge({"visited_user__full_name" => User.current.id })
    res = TreatmentVisit.check_visit_is_overlapped(component_session[:treatment_id], params[:values])
    res = res ? (res + "<br/><br/>" + "Would you like to proceed?") : false
    {set_result: res}
  end

  endpoint :select_episode_id do |params|
    list = ElectronicRoutesheet.visit_types_list(component_session[:treatment_id], params[:episode_id].to_i)
    {:refresh_visit_type_id => list}
  end

  js_method :refresh_visit_type_id,<<-JS
    function(newStore){
      this.down("#vt_id").bindStore(newStore);
    }
  JS

  endpoint :refresh_combo_boxes do |params|
		{:refresh_combo_store => [:episode_id, :vt_id]}
	end
  
  js_method :afterRender, <<-JS
    function() {
      this.callParent();
      this.getLocation();
    }
  JS

  js_method :get_location, <<-JS
      function() {
      console.log("S");
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(this.showPosition, this.showError);
      } else {
        alert("Geolocation is not supported by your device.");
      }
    }
  JS

  js_method :show_position, <<-JS
    function(position) {
      lat=position.coords.latitude;
      lon=position.coords.longitude;
        console.log(lat);
        console.log(lon);
      Ext.ComponentQuery.query("#location_latitude")[0].setValue(lat);
      Ext.ComponentQuery.query("#location_longitude")[0].setValue(lon);
    }
  JS

  js_method :show_error, <<-JS
    function(error) {
      switch(error.code)
      {
      case error.PERMISSION_DENIED:
          x.innerHTML="User denied the request for Geolocation."
      break;
      case error.POSITION_UNAVAILABLE:
          x.innerHTML="Location information is unavailable."
      break;
      case error.TIMEOUT:
          x.innerHTML="The request to get user location timed out."
      break;
      case error.UNKNOWN_ERROR:
          x.innerHTML="An unknown error occurred."
      break;
      }
    }
  JS

end
