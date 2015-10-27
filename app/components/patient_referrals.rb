class PatientReferrals < Mahaswami::GridPanel

  def initialize(conf = {}, parent = nil)
    super
  end

  def configuration
    super.merge(
        model: 'TreatmentRequest',
        title: 'Referrals',
        item_id: :treatment_request_grid,
        columns: [{name: :patient__full_name, label: "Patient", editable: false},
                  {name: :request_date, label: "Referred Date", editable: false},
                  {name: :referred_physician__full_name, label: "Referring Physician", editable: false, width: "15%"},
                  {name: :request_status, label: "Status", editable: false, :getter => lambda {|l| (l.request_status == :pending_soc)? "Pending SOC" : l.request_status.to_s.titleize}, width: "15%"},
                  action_column("treatment_request_grid")
                  ],
        scope: :org_scope
    )

  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action, :check_eligibility.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Referral"
  action :edit_in_form, text: "Edit Referral"
  add_form_config        class_name: "ReferralNewForm", mode: :new
  edit_form_config        class_name: "ReferralEditForm", mode: :edit
  add_form_window_config width: "52%", height: "70%", title: "Add Referral"
  edit_form_window_config width: "52%", height: "85%", title: "Edit Referral"

  action :check_eligibility, text: "Check Eligibility (Medicare)", icon: false, disabled: true

  def perform_event(comp_name, record, event)
    if event == :mark_as_referral_received
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        var w = new Ext.window.Window({
          width: "25%",
          height: "18%",
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "OK",
              listeners: {
                click: function(){
                  g.sendUpdatedReferralReceivedDate(w, "#{record.id}")
               }
              }
            },
            {
              text: "Cancel",
              listeners: {
                click: function(){w.close();}
              }
            }
          ],
            title: "Referral Received Date",
        });
        w.show();
        g.loadNetzkeComponent({name: "date_component", container:w, callback: function(w){
          w.show();
        }});
      JS
    elsif event == :admit
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        var w = new Ext.window.Window({
          width: "25%",
          height: "18%",
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "OK",
              listeners: {
                click: function(){
                  g.setStartOfCareDate(w, "#{record.id}")
               }
              }
            },
            {
              text: "Cancel",
              listeners: {
                click: function(){w.close();}
              }
            }
          ],
            title: "SOC Date",
        });
        w.show();
        g.loadNetzkeComponent({name: "soc_date_component", container:w, callback: function(w){
          w.show();
        }});
      JS
    else
      super
    end
  end

  component :soc_date_component do
    {
        class_name: "Netzke::Basepack::Panel",
        title: false,
        header: false,
        items:[{name: :date, field_label: "SOC Date", xtype: "datefield", item_id: :soc_date, value: Date.current, margin: 5, allowBlank: false, dateFormat: 'm-d-Y', labelWidth: 150}]
    }
  end

  js_method :set_start_of_care_date, <<-JS
    function(w, record_id){
      var socDate = w.down('#soc_date').value;
      this.updateSocDate({soc_date: socDate, treatment_request_id: record_id}, function(result){
        if(result){
          w.close();
          this.store.load();
        }
        else{
          Ext.MessageBox.alert("Status", "Invalid Date. Please try again.");
        }
      }, this);
    }
  JS

  endpoint :update_soc_date do |params|
    result = false
    unless params[:soc_date].nil?
      date =  params[:soc_date].to_date
      ActiveRecord::Base.transaction do
        treatment_request = TreatmentRequest.find(params[:treatment_request_id])
        treatment_request.soc_date = date
        treatment_request.admit! if treatment_request.may_admit?
        result = true
      end
    end
    {:set_result => result}
  end

    component :date_component do
      {
        class_name: "Netzke::Basepack::Panel",
        title: false,
        header: false,
        items:[{name: :date, field_label: " Referral Received Date", xtype: "datefield", item_id: :date, value: TreatmentRequest.referral_date, margin: 5, allowBlank: false, dateFormat: 'Y-m-d', labelWidth: 150}]
      }
    end

    js_method :send_updated_referral_received_date, <<-JS
      function(w, record_id){
        var refDate = w.down('#date');
        var date = refDate.value;
        this.updateReferralReceivedDate({treatment_request_id: record_id, ref_date: date});
      w.close();
    }
    JS

  endpoint :update_referral_received_date do |params|
    ActiveRecord::Base.transaction do
     treatment_request = TreatmentRequest.find(params[:treatment_request_id])
     date = params[:ref_date].to_date if params[:ref_date]
     treatment_request.referral_received_date = date
     treatment_request.save!
     treatment_request.mark_as_referral_received!
   end
    {:refresh_referral_grid => true}
  end

  js_method :refresh_referral_grid, <<-JS
    function(args){
      this.store.load();
    }
  JS

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
        this.selectRecord({request_id: record.get('id')});
      }, this);

      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.checkEligibility.setDisabled(selModel.getCount() != 1);
      }, this);
    }
  JS

  endpoint :select_record do |params|
    session[:treatment_request_id] = params[:request_id]
    component_session[:treatment_request_id] = params[:request_id]
  end

  js_method :on_check_eligibility,<<-JS
    function(){
      var gridScope = this;
      var w = new Ext.window.Window({
          width: "80%",
          height: "90%",
          modal: true,
          layout:'fit',
          title: "Eligibility Check Report",
        });
        w.show();
        gridScope.loadNetzkeComponent({name: "check_medicare_eligibility_details", container:w, callback: function(w){
          w.show();
        }});
    }
  JS

  component :check_medicare_eligibility_details do
    {
        class_name: "CheckMedicareEligibilityDetails",
        treatment_request_id: component_session[:treatment_request_id],
        lazy_loading: true,
    }
  end
end