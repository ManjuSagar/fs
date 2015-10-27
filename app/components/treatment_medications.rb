class TreatmentMedications < Mahaswami::HasManyCollectionList
  include ButtonsOfOasisHeader

  association "medications"
  parent_model "PatientTreatment"

  def initialize(conf = {}, parent_id = nil)
     super
     return unless component_session[:parent_id]
     if config[:parent_model] == 'PatientTreatment' 
       medication_instance = TreatmentMedication.new(:treatment_id => component_session[:treatment_id])
     else
       medication_instance = TreatmentMedication.new(:treatment_id => component_session[:treatment_id], :visit_id => component_session[:visit_id])
     end
     components[:add_form][:items].first.merge!(:record => medication_instance, treatment_id: component_session[:treatment_id], visit_id: component_session[:visit_id], parent_model: config[:parent_model])
     components[:edit_form][:items].first.merge!(treatment_id: component_session[:treatment_id], visit_id: component_session[:visit_id], parent_model: config[:parent_model])
  end
  
  def configuration
    c = super
    if c[:parent_model] == "TreatmentVisit"
      component_session[:visit_id] = component_session[:parent_id]
      component_session[:treatment_id] = c[:treatment_id]
    else
      component_session[:treatment_id] = component_session[:parent_id]
      component_session[:visit_id] = nil
    end
    c.merge(
      title: c[:title]|| 'Medications',
      item_id: c[:item_id],
      columns: [ {name: :medication_name, header: "Name", editable: false, 
					     getter: get_medication_name, width: "15%"},
				 {name: :dosage_form, header: "Dosage Form", editable: false},
				 {name: :frequency, header: "Frequency", editable: false},
                 {name: :purpose, header: "Purpose", editable: false, width: "20%"},
				 {name: :start_date, header: "Start Date", editable: false},
				 {name: :end_date, header: "End Date", editable: false},
				 {name: :medication_status, header: "Status", width: "10%", editable: false,
				         getter: lambda{|r| "#{r.medication_status.to_s.titleize}"+ medication_status_display(r)}},
				 action_column(c[:item_id])
      ],
      bbar: false,
      tbar: c[:show_tool_bar]== true ? [:drug_interactions.action,:view_orders.action, '->',:add_in_form.action, :edit_in_form.action, :discontinue.action, :del.action, :print_medication_list.action ] : false,
      scope: (c[:episode_medications] ? {treatment_episode_id: c[:episode_id]} : (c[:scope] ? c[:scope].merge({treatment_id: component_session[:treatment_id]}) : {treatment_id: component_session[:treatment_id]}))
    )
  end

  def get_medication_name
    lambda{|r| r.medication_code ? "#{r.medication_name} (#{r.medication_code})" : "#{r.medication_name}"}
  end
  
  def medication_status_display(medication_record)
    medication_record.discontinued_date.present? ? " (#{medication_record.discontinued_date.strftime("%m/%d/%Y")})" : ""
  end
  
  def default_context_menu
    ((Org.current.is_a? StaffingCompany) ? [] : [:add_in_form.action, :edit_in_form.action, :discontinue.action, :del.action])
  end

  action :discontinue, :text => "", :disabled => true, icon: :discontinue
  action :add_in_form, text: "", tooltip: "Add", item_id: 'add_medication_button'
  action :edit_in_form, text: "", tooltip: "Edit", item_id: 'edit_medication_button'
  action :print_medication_list, text: "", tooltip: "Print medication list", icon: :print
  action :drug_interactions, item_id: "drug_interactions", text: "Drug Interactions", cls: "drug_interactions_button",
          url: "http://reference.medscape.com/drug-interactionchecker"
  action :view_orders, text: "View Orders", tooltip: "View Orders", cls: "drug_interactions_button"

  edit_form_config        class_name: "TreatmentMedicationForm"
  add_form_config        class_name: "TreatmentMedicationForm"
  edit_form_window_config     title: "Edit Medication", width: "35%"
  add_form_window_config     title: "Add Medication", width: "35%"
  
  js_method :init_component, <<-JS
    function(){
      this.callParent();
      btn = Ext.ComponentQuery.query('#drug_interactions')[0];
      if(btn){
        btn.on('click', function(){
          btn.addCls('button-bg-color');
        },this);
        btn.on('mouseout', function(){
         btn.removeCls('button-bg-color');
        },this);
      }
      this.on('itemclick', function(view, record){
        this.selectRecord({medication_id: record.get('id')}, function(result){
          this.actions.discontinue.setDisabled(!result[0]);
          this.actions.editInForm.setDisabled(!result[1]);
          this.actions.del.setDisabled(!result[1]);
        });
      }, this);
    }
  JS

  def perform_event(comp_name, record, event)
    if event == :continue
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.performAction(#{record.id}, "#{event.name}");
        var activeMedications = Ext.ComponentQuery.query("#active_medications_list")[0];
        if(activeMedications) activeMedications.store.load();
      JS
    else
      super
    end
  end
  
  component :medical_orders do
    {
        class_name: "MedicalOrders",
        treatment_id: component_session[:treatment_id],
        parent_id: component_session[:treatment_id],
        episode_orders: false,
        header: false,
    }
  end

  js_method :on_print_medication_list,<<-JS
    function(){
      var gridScope = this;
      var w = new Ext.window.Window({
        width: 300,
        height: 130,
        modal: true,
        layout:'fit',
        buttons: [
          {
            text: "",
            tooltip: "OK",
            iconCls: "ok_icon",
            listeners: {
              click: function(){
                gridScope.sendMedicationListDate(w);
             }
            }
          },
          {
            text: "",
            tooltip: "Cancel",
            iconCls: "cancel_icon",
            listeners: {
              click: function(){w.close();}
            }
          }
        ],
          title: "Date",
      }, this);
      w.show();
      this.loadNetzkeComponent({name: "medication_list_date_form", container:w, callback: function(w){
        w.show();
      }});
    }
  JS

  component :medication_list_date_form do
    {
        class_name: "Netzke::Basepack::Panel",
        header: false,
        items: [
            {name: :medication_list_date, field_label: "Date", xtype: :datefield, margin: 5, item_id: :medication_list_date, value: Date.current}
        ]
    }
  end

  js_method :send_medication_list_date,<<-JS
    function(w){
      medication_list_date = w.down("#medication_list_date").value;
      if(medication_list_date){
        this.launchMedicationList({date: medication_list_date});
         w.close();
      }
      else{
        Ext.MessageBox.alert("Status", "Invaild Date. Please try again.")
      }
    }
  JS

  endpoint :launch_medication_list do |params|
    {:view_medication_list => [component_session[:treatment_id], params[:date]]}
  end

  js_method :view_medication_list, <<-JS
    function(options) {
      var reportUrl = "/reports/medication_list/" + options[0] + "/" + options[1] + ".pdf";
      reportUrl = window.location.protocol + "//" + window.location.host + reportUrl;
      var reportTitle = "Medication List";
      if (Ext.isGecko) {
        window.location = reportUrl;
      } else {
        Ext.create('Ext.window.Window', {
            width : 800,
            height: 600,
            layout : 'fit',
            title : reportTitle,
            items : [{
                xtype : "component",
                id: 'myIframe1',
                autoEl : {
                    tag : "iframe",
                    href : ""
                }
            }]
        }).show();

        Ext.getDom('myIframe1').src = reportUrl;
      }
    }
  JS

  js_method :discontinue_medication, <<-JS
    function(w){
      discontinue_date = w.down("#discontinued_date").value;
      this.updateMedicationRecord({discontinue_date: discontinue_date});
    }
  JS
  
  endpoint :select_record do |params|
    result = []
    component_session[:selected_medication_id] = params[:medication_id]
    result << TreatmentMedication.find(params[:medication_id]).active?
    result << TreatmentMedication.find(params[:medication_id]).draft?    
    {:set_result => result}
  end
  
  js_method :on_discontinue, <<-JS
    function(){
        var gridScope = this;
        var w = new Ext.window.Window({
          width: 300,
          height: 130,
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "",
              tooltip: "OK",
              iconCls: "ok_icon",
              listeners: {
                click: function(){
                  gridScope.discontinueMedication(w);
                  w.close();
               }
              }
            },
            {
              text: "",
              tooltip: "Cancel",
              iconCls: "cancel_icon",
              listeners: {
                click: function(){w.close();}
              }
            }
          ],
            title: "Discontinue",
        }, this);
        w.show();
        this.loadNetzkeComponent({name: "medication_discontinue_form", container:w, callback: function(w){
          w.show();
        }});
    }
  JS
  
  js_method :discontinue_medication, <<-JS
    function(w){
      discontinue_date = w.down("#discontinued_date").value;
      this.updateMedicationRecord({discontinue_date: discontinue_date});
    }
  JS
  
  endpoint :update_medication_record do |params|
    result = false
    medication = nil
    discontinue_date = nil
    if params[:discontinue_date].present?
      medication = TreatmentMedication.find(component_session[:selected_medication_id])
      discontinue_date = params[:discontinue_date].to_date
      if medication.start_date and medication.end_date
        result = true if discontinue_date >= medication.start_date and discontinue_date <= medication.end_date
      elsif medication.start_date and medication.end_date.nil?
        result = true if discontinue_date >= medication.start_date
      end
    end
    if result
      medication.update_attribute(:discontinued_date, discontinue_date)
      medication.system_driven_event = true
      medication.discontinue! if medication.may_discontinue?
      medication.system_driven_event = false
      {refresh_grids: 1}
    else
      {:invalidate_discontinue_date => true}
    end
  end

  js_method :refresh_grids, <<-JS
    function(){
      this.store.load();
      var discontinuedList = this.up('panel').down("#discontinued_medications_list");
      if(discontinuedList)
        discontinuedList.store.load();
    }
  JS

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      var activeMedicationsList = Ext.ComponentQuery.query('#active_medications_list')[0];
      if(activeMedicationsList){
        var w = activeMedicationsList.up('window');
        if(w){
        var tool = w.tools.refresh
          tool.on('click', function(){
            activeMedicationsList.store.load();
            this.stopEvent();
          });
        }
      }
    }
  JS

  js_method :invalidate_discontinue_date, <<-JS
    function(){
      Ext.MessageBox.alert("Invalid Date", "You can discontinue only between start date and end date. <br/> Please try again.");
    }
  JS
  
  
  component :medication_discontinue_form
end
