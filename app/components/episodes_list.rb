class EpisodesList < Mahaswami::GridPanel        # TODO: Rename it to Patient List
  include PrintPatientProfile

  def configuration
    s = super
    patients_count = DenormalizedPatientList.org_scope.size
    s.merge(
        model: "DenormalizedPatientList",
        title: "Patients",
        edit_on_dbl_click: false,
        item_id: :episodes_list,
        enable_column_hide: false,
        rows_per_page: patients_count,
        enable_pagination: false,
        columns: [
                  {name: :patient_reference, label: "MR", width: "4%", addHeaderFilter: true, editable: false},
                  {name: :full_name, label: "Patient", width: "10%", addHeaderFilter: true, editable: false},
                  {name: :e_certification_period, label: "Episode", width:"10%", filter1: {xtype: 'datefield', attrType: 'date'}, editable: false},
                  {name: :patient_treatment_soc_date, label: "SOC", width: "7%", filter1: {xtype: 'datefield', attrType: 'date'}, editable: false},
                  {name: :patient_treatment_treatment_status_display, label: "Status", width: "5%", renderer: :status_renderer, filter1: {xtype: 'combo', store: PatientTreatment::COMBO_STORE_DISPLAY}, editable: false},
                  {name: :e_disciplines_display, label: "Disciplines", width: "10%", getter: lambda{|r| disciplines(r)}, renderer: :disciplines_renderer, filter1: {xtype: 'combo', store: Discipline::COMBO_STORE_DISPLAY}, editable: false},
                  {name: :e_eligibility_check_flag, label: "Eligibility", renderer: :state_renderer, width:"5%", getter: lambda{|r| eligibility_flag(r)}, filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :e_staffing_flag, label: "Staffed", renderer: :state_renderer, width:"4%", getter: lambda{|r| staffing_flag(r)}, filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :e_referral_received_flag, label: "Referral", renderer: :state_renderer, width:"5%", getter: lambda{|r| referral_flag(r) }, filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :e_oasis_document_completed_flag, label: "OASIS", renderer: :state_renderer, width:"4%", getter: lambda{|r| oasis_doc_flag(r) }, filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :e_plan_of_care_completed_flag, label: "POC", renderer: :state_renderer, width:"3%", getter: lambda{|r| poc_flag(r) }, filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :e_rap_status, label: "RAP", renderer: :state_renderer, getter: lambda{|r| rap_flag(r) }, width:"3%", filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :e_documents_status, label: "Docs", renderer: :state_renderer, getter: lambda{|r| doc_flag(r) }, width:"3%", filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :e_medical_orders_status, label: "Orders", renderer: :state_renderer, getter: lambda{|r| mo_flag(r) }, width:"4%", getter: lambda{|r| mo_flag(r) }, filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :e_discharged_flag, label: "DC/RC", renderer: :state_renderer, width:"4%", getter: lambda{|r| dc_flag(r) }, filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :e_final_claim_sent_flag, label: "FC", renderer: :state_renderer, width:"3%", getter: lambda{|r| fc_flag(r) }, filter1: {xtype: 'combo', store: flag_filter_store}, editable: false},
                  {name: :patient_record_type, label: "Type", width: "3%", hidden:true},
                  {name: :treatment_request_record_type, label: "Type", width: "3%", hidden:true},
                  {name: :patient_treatment_record_type, label: "Type", width: "3%", hidden:true},
                  {name: :patient_treatment_id, hidden:true},
                  {name: :treatment_request_id, hidden:true},
                  {name: :e_id, hidden:true},
                  {name: :patient_id, hidden: true},
                  action_column("episodes_list")
        ],
        scope: (s[:scope] ?  s[:scope] : :org_scope)
    )
  end

  def flag_filter_store
    style = 'width:15px;height:15px;'
    [["", "---"], ["right", "<img style=#{style} class='checked_image_class'>"], ["wrong", "<img style=#{style} class='cross_image_class'"],
     ["play", "<img style=#{style} class='progress_image_class'>"]]
  end

  def default_bbar
    " "
  end

  def default_context_menu
    [:view_patient_chart.action, :view_patient_schedule.action, :worksheet.action]
  end

  def is_episode_record?(r)
    r.patient_treatment_record_type == 1
  end

  def is_referral_record?(r)
    r.treatment_request_record_type == 3
  end

  def referral_flag(r)
    if is_episode_record?(r)
      't'
    elsif is_referral_record?(r)
      r.treatment_request_ref_received_flag
    else
      'f'
    end
  end

  def staffing_flag(r)
    if is_episode_record?(r)
       't'
    elsif is_referral_record?(r)
       r.treatment_request_staffing_flag
    else
      'f'
    end
  end

  def eligibility_flag(r)
    if is_episode_record?(r)
      r.e_eligibility_check_flag
    elsif is_referral_record?(r)
      r.treatment_request_eligibility_flag
    elsif r.patient_record_type == 2
      r.p_eligibility_flag
    end
  end

  def oasis_doc_flag(r)
    if is_episode_record?(r)
      r.e_oasis_document_completed_flag
    else
      'f'
    end
  end

  def poc_flag(r)
    if is_episode_record?(r)
      r.e_plan_of_care_completed_flag
    else
      'f'
    end
  end

  def rap_flag(r)
    if is_episode_record?(r)
      r.e_rap_status
    else
      'f'
    end
  end

  def doc_flag(r)
    if is_episode_record?(r)
      r.e_documents_status
    else
      'f'
    end
  end

  def mo_flag(r)
    if is_episode_record?(r)
      r.e_medical_orders_status
    else
      'f'
    end
  end

  def dc_flag(r)
    if is_episode_record?(r)
      r.e_discharged_flag
    else
      'f'
    end
  end

  def fc_flag(r)
    if is_episode_record?(r)
      r.e_final_claim_sent_flag
    else
      'f'
    end
  end

  def disciplines(r)
    if is_episode_record?(r)
      r.e_disciplines_display
    elsif is_referral_record?(r)
      r.treatment_request_disciplines_display
    end
  end


  action :view_patient_chart, text: "", tooltip: "Schedule", icon: :schedule
  action :view_patient_schedule, text: "", tooltip: "Chart", icon: :chart
  action :worksheet, text: "", tooltip: "Print", icon: :print
  action :add_patient, text: "", tooltip: "Add Patient", icon: :patient
  action :add_referral, text: "", tooltip: "Referral", icon: :page_add

  def action_column(grid_component_name = nil)
    comp_name = grid_component_name || self.class.name.underscore
    {name: :actions, flex: 1, label: "", editable: false,
     :getter => lambda {|x|
       if x.is_a? DenormalizedPatientList
         events_list =  if x.e_id
                          x.e_events
                        elsif x.treatment_request_id
                          x.treatment_request_events
                        end
         events = if events_list.present?
                    events_list.split(",")
                  else
                    []
                  end
         events.collect{|r|
           if x.e_id
             link_to_function(human_action_name(r.to_sym), "tE('#{x.e_id}', '#{r.to_sym}')")
           elsif x.treatment_request_id
             link_to_function(human_action_name(r.to_sym), "tR('#{x.treatment_request_id}', '#{r.to_sym}')")
           end
         }.join(" | ")
       end
     }}
  end

  def human_action_name(event)
    if event == :discharge
      "DC"
    elsif event == :recertification
      "RC"
    elsif event == :mark_as_referral_received
      "Referral Received"
    elsif event == :eligibility_check_complete
      "Eligibility Checked"
    elsif event == :donot_admit
      "Non-Admit"
    else
      event.to_s.titleize
    end
  end

  component :date_component do
    {
        class_name: "Netzke::Basepack::Panel",
        title: false,
        header: false,
        items:[{name: :date, field_label: " Referral Received Date", xtype: "datefield", item_id: :date, value: TreatmentRequest.referral_date, margin: 5, allowBlank: false, dateFormat: 'Y-m-d', labelWidth: 150}]
    }
  end

  component :soc_date_component do
    {
        class_name: "Netzke::Basepack::Panel",
        title: false,
        header: false,
        items:[{name: :date, field_label: "SOC Date", xtype: "datefield", item_id: :soc_date, value: Date.current, margin: 5, allowBlank: false, dateFormat: 'm-d-Y', labelWidth: 150}]
    }
  end

  endpoint :trigger_referral_event do |params|
    TreatmentRequest.find(params[:record_id]).send("#{params[:action]}!".to_sym)
    {:refresh_data => 1}
  end

  js_method :send_updated_referral_received_date, <<-JS
      function(w, record_id){
        var refDate = w.down('#date');
        var date = refDate.value;
        this.updateReferralReceivedDate({referral_id: record_id, ref_date: date});
      w.close();
    }
  JS

  endpoint :update_referral_received_date do |params|
    ActiveRecord::Base.transaction do
      treatment_request = TreatmentRequest.find(params[:referral_id])
      date = params[:ref_date].to_date if params[:ref_date]
      treatment_request.referral_received_date = date
      treatment_request.save!
      treatment_request.mark_as_referral_received!
    end
    {:refresh_data => 1}
  end

  js_method :set_start_of_care_date, <<-JS
    function(w, record_id){
      var socDate = w.down('#soc_date').value;
      this.updateSocDate({soc_date: socDate, referral_id: record_id}, function(result){
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
        treatment_request = TreatmentRequest.find(params[:referral_id])
        treatment_request.soc_date = date
        res = treatment_request.admit! if treatment_request.may_admit?
        result = true
      end
    end
    {:set_result => result}
  end

  endpoint :check_episode_visits do |params|
    episode = TreatmentEpisode.find(params[:episode_id])
    res = episode.treatment_visits.size > 0
    {set_result: res}
  end

  endpoint :get_dc_document do |params|
    doc = TreatmentEpisode.find(params[:episode_id]).transfer_without_discharge_document    
    {set_result: doc.present?}
  end

  js_method :status_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store){
      if (value == "P")
        return "<span style='color:#8B3AB2'>PE</span>"
      else if (value == "A")
      return "<span style='color:#000000'>AC</span>"
      else if (value == "D")
        return "<span style='color:#267FFF'>DC</span>"
      else if (value == "O")
        return "<span style='color:#4F9FB2'>HD</span>"
      else
       return value;
    }
  JS

  js_method :disciplines_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store) {
      if(value == "")
        return;
      data = JSON.parse(value);
      value = "<div>";
      value  += (Ext.Array.map(data, function(item){
        color = "#8B3AB2"; //Purple
        if (item.s == "P")
          color = "#8B3AB2"; //Purple
        if (item.s == "A")
          color = "black";  //Black
        if (item.s == "O")
          color = "#4F9FB2"; //Teal
        if (item.s == "D")
          color = "#267FFF"; //Blue
        return "<span style='color:" + color + "'>" + item.d + "</span>"
      }).join(", "));
      value += "</div>"
      return value;
    }
  JS

  js_method :state_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store) {
      var treatmentRequestId = record.get("treatment_request_id");
      var treatmentId = record.get("patient_treatment_id");
      var episodeId = record.get("e_id");
      var attrs = "' treatment_request_id='" + treatmentRequestId + "' treatment_id='" + treatmentId
                    + "' episode_id='" + episodeId + "' width=15 height=15";
      metadata.style="text-align:center";
      var class_name = 'unknown';
      if (colIndex == 7)
        class_name = 'eligibility';
      if (colIndex == 8)
        class_name = 'staffing';
      if (colIndex == 9)
        class_name = 'referral';
      if (colIndex == 13)
        class_name = 'documents';
      if (colIndex == 14)
        class_name = 'medical_order';
      var joinedAttrs = treatmentRequestId + ':' + treatmentId + ':' + episodeId + ':' + class_name;
      var imageClick = 'Ext.ComponentQuery.query(\"#episodes_list\")[0].displayWindow(\"'+joinedAttrs+'\");';
      var arr = ["staffing", "medical_order", "documents"];
      if(arr.indexOf(class_name) != -1){
        if(value == "t")
          return "<div style='cursor:pointer;' onclick="+ imageClick +"><img class='checked_image_class'"+class_name+attrs+"/></div>";
        else if(value == "f")
          return "<div style='cursor:pointer;' onclick="+ imageClick +"><img class='cross_image_class'"+class_name+attrs+"/></div>";
        else if(value == "n")
          return "<div style='cursor:pointer;' onclick="+ imageClick +"><img class='progress_image_class'"+class_name+attrs+"/></div>";
        else
          return "-"
      }else{
        if(value == "t")
          return "<img class='checked_image_class'"+class_name+attrs+"/>";
        else if(value == "f")
          return "<img class='cross_image_class'"+class_name+attrs+"/>";
        else if(value == "n")
          return "<img class='progress_image_class'"+class_name+attrs+"/>";
        else
          return "-"
        }
      }
  JS

  js_method :displayWindow,<<-JS
    function(joinedAttrs){
      var attrArr = joinedAttrs.split(":");
      var treatmentRequestId = attrArr[0];
      var treatmentId = attrArr[1];
      var episodeId = attrArr[2];
      var className = attrArr[3];
      var gridScope = this;
      if(className == "staffing"){
        if (treatmentId != 0)
          launchPatientWindow({component_class_name: "TreatmentStaffing", height: "80%", width: "90%", treatment_id: treatmentId,
            params: {episode_id: episodeId}, grid_item_id: gridScope.itemId});
        else if (treatmentRequestId != 0)
          launchPatientWindow({component_class_name: "Staffing", height: "80%", width: "90%", treatment_request_id: treatmentRequestId,
              params: {treatment_request_id: treatmentRequestId, treatment_id: null}, grid_item_id: gridScope.itemId});
        else
          Ext.MessageBox.alert('Status', 'Patient is yet to be admitted.');
      }else if(className == "medical_order"){
        if (treatmentId != 0)
          launchPatientWindow({component_class_name: "MedicalOrders", treatment_id: treatmentId, height: "60%", width: "60%",
            grid_item_id: this.itemId, params: {episode_id: episodeId, episode_orders: true}});
        else
            Ext.MessageBox.alert('Status', 'Patient is yet to be admitted.');
      }else if(className == "documents"){
        if (treatmentId != 0)
          launchPatientWindow({component_class_name: "Documents", treatment_id: treatmentId, height: "60%", width: "60%",
              grid_item_id: this.itemId, params: {parent_model: "PatientTreatment", association: "documents", treatment_id: treatmentId,
              episode_id: episodeId, episode_docs: true, item_id: "episode_documents"}});
        else
            Ext.MessageBox.alert('Status', 'Patient is yet to be admitted.');
      }
    }
  JS

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.actions.viewPatientChart.setDisabled(true);
      this.actions.viewPatientSchedule.setDisabled(true);
      this.actions.worksheet.setDisabled(true);
      this.on('itemclick', function(view, record){
        var recordType = this.getRecordType(record);
        this.actions.viewPatientChart.setDisabled(this.getSelectionModel().getCount() != 1);
        if (recordType == 3 || recordType == 1){
          this.actions.viewPatientSchedule.setDisabled(recordType != 1);
          this.actions.worksheet.setDisabled(this.getSelectionModel().getCount() != 1);
        }else{
          this.actions.viewPatientSchedule.setDisabled(true);
          this.actions.worksheet.setDisabled(true);
        }
      },this);
      this.on('itemdblclick', function(view, record, e){
        var mainApp = this.up("#app");
        var mainPanel = this.up("#main_panel");
        var recordType = this.getRecordType(record);
        this.viewChart(record,  recordType);
      }, this);
    }
  JS

  js_method :get_record_type, <<-JS
    function(record){
      var patientRecordType = record.get("patient_record_type");
      var treatmentRequestRecordType = record.get("treatment_request_record_type");
      var patientTreatmentRecordType = record.get("patient_treatment_record_type");
      if(patientRecordType){
        var recordType = patientRecordType;
      }else if(treatmentRequestRecordType){
        var recordType = treatmentRequestRecordType;
      }else if(patientTreatmentRecordType){
        var recordType = patientTreatmentRecordType;
      }
      return recordType;
    }
  JS

  js_method :view_chart, <<-JS
    function(record, recordType){
      var mainApp = this.up("#app");
      var mainPanel = this.up("#main_panel");
      if(recordType == 1){
          this.selectEpisode({episode_id: record.get('e_id')}, function(res) {
            if (res) {
              mainApp.setContext(res, function() {
              launchComponent("PProfile", "p_profile");
              });
            }
          });
      }else if(recordType == 2){
          this.selectPatient({patient_id: record.get("patient_id")}, function(res){
            if(res){
              mainApp.setContext(res, function() {
                launchComponent("PProfile", "p_profile");
              });
            }
          });
      }else if(recordType == 3){
          this.selectReferral({referral_id: record.get("treatment_request_id")}, function(res){
            if(res){
              mainApp.setContext(res, function() {
                launchComponent("PProfile", "p_profile");
              });
            }
          });
      }
    }
  JS

  endpoint :select_episode do |params|
    episode = TreatmentEpisode.find_by_id(params[:episode_id])
    res = false
    if episode.present? and episode.treatment.present?
      res = {record_type: 1, treatment_id: episode.treatment_id, episode_id: episode.id, patient_id: episode.treatment.patient_id,
             treatment_request_id: episode.treatment.treatment_request_id}
      component_session[:treatment_id] = res[:treatment_id]
    end
    {set_result: res}
  end

  endpoint :select_patient do |params|
    res = false
    component_session[:patient_id] = params[:patient_id]
    res = {record_type: 2, patient_id: params[:patient_id], treatment_id: nil, episode_id: nil, treatment_request_id: nil}
    {set_result: res}
  end

  endpoint :select_referral do |params|
    res = false
    component_session[:referral_id] = params[:referral_id]
    request = TreatmentRequest.find(params[:referral_id])
    if request
      res = {record_type: 3, treatment_id: nil, episode_id: nil, patient_id: request.patient_id,
             treatment_request_id: request.id}
    end
    {set_result: res}
  end

  js_method :on_view_patient_chart, <<-JS
    function(){
      if(this.getSelectionModel().getCount() == 1){
        var record = this.getSelectionModel().selected.items[0];
        var recordType = this.getRecordType(record);
        this.viewChart(record, recordType);
      } else
        Ext.MessageBox.alert('Status', 'Please select episode to view chart.');
    }
  JS

  js_method :on_view_patient_schedule, <<-JS
    function(){
      var selModel = this.getSelectionModel();
      if(selModel.getCount() == 1 && selModel.selected.items[0].get('patient_treatment_record_type') == 1){
        var episodeId = selModel.selected.items[0].get('e_id');
        this.selectEpisode({episode_id: episodeId}, function(res) {
          if (res) {
            var main_app = this.up("#app");
            main_app.setContext(res, function(){
              var w = new Ext.window.Window({
                height: "80%",
                width: "85%",
                modal: true,
                layout:'fit',
                buttons: [
                    {
                        text: "Close",
                        listeners: {
                            click: function(){
                                w.close();
                            }
                        }
                    }
                ],
                title: "Patient Schedule"
            });
            w.show();
            main_app.loadNetzkeComponent({name: "patient_schedules_with_patient_details", container:w, callback: function(w){
                w.show();
            }});
            }, this);
          } else
            Ext.MessageBox.alert('Status', 'Patient is yet to be admitted.');
        });
      } else
        Ext.MessageBox.alert('Status', 'Please select episode to view schedule.');
    }
  JS

  js_method :on_worksheet, <<-JS
    function(){
      var selModel = this.getSelectionModel();
      if (selModel.getCount() != 1) {
        Ext.MessageBox.alert('Status', 'Please select record to view profile.');
        return;
      }
      var record = selModel.selected.first();
      var data = record.data;
      var patientRecordType = data.patient_record_type;
      var treatmentRequestRecordType = data.treatment_request_record_type;
      var patientTreatmentRecordType = data.patient_treatment_record_type;
      if(patientRecordType){
        this.recordType = patientRecordType;
      }else if(treatmentRequestRecordType){
        this.recordType = treatmentRequestRecordType;
      }else if(patientTreatmentRecordType){
        this.recordType = patientTreatmentRecordType;
      }
      if(this.recordType == 1)
        recordId = record.get("e_id");
      else if(this.recordType == 3)
        recordId = record.get("treatment_request_id");
      this.viewWorksheet({record_id: recordId, record_type: this.recordType});
    }
  JS

  endpoint :view_worksheet do |params|
    return {} if params[:record_type] == 2
    patient_id =  if params[:record_type] == 3
                    TreatmentRequest.find(params[:record_id].to_i).patient_id
                  else
                    TreatmentEpisode.find(params[:record_id].to_i).treatment.patient_id
                  end
    report_url = "/reports/worksheet/#{patient_id}.pdf"
    {:launch_report => {url: report_url, title: "Profile", width: 800, height: 600}}
  end

  endpoint :create_new_record_and_return_id do |params|

    sample_patient = Patient.new
    sample_patient.draft_status = true
    sample_patient.set_random_email
    sample_patient.set_random_password
    sample_patient.save(:validate => false)
    component_session[:patient_id] = sample_patient.id
    {:set_result => {:id => sample_patient.id, :patient => sample_patient}}
  end

  js_method :on_add_patient, <<-JS
    function(){
      this.createNewRecordAndReturnId({},function(result) {
        var recordId = result.id;
        this.loadNetzkeComponent({name: "patient_edit_form",
          params: {record_id: recordId},
          callback: function(w){
            w.show();
            w.on('close', function(){
              if (w.closeRes && w.closeRes.status === "referral_no") {
                this.store.load();
              }else if (w.closeRes && w.closeRes.status === "referral_yes") {
                Ext.MessageBox.confirm('Confirm', 'Do you wish to create a staffing for this patient?', function(result){
                  if (result == "yes") {
                    this.selectReferralId({patient_id: w.closeRes.patient_id}, function(treatment_request_id){
                      launchPatientWindow({component_class_name: "Staffing", height: "80%", width: "90%", treatment_request_id: treatment_request_id,
                      params: {treatment_request_id: treatment_request_id, treatment_id: null, episode_id: null, record_type: 3, patient_id: w.closeRes.patient_id}, grid_item_id: "episodes_list"});
                    }, this);
                  } else {
                    this.store.load();
                  }
                }, this);
              }
            }, this);
          }, scope: this});
      });
    }
  JS

  endpoint :select_referral_id do |params|
    patient = Patient.find(params[:patient_id].to_i)
    treatment_request_id = patient.treatment_requests.order("id DESC").first.id
    {set_result: treatment_request_id}
  end

  component :patient_edit_form do
    form_config = {
        :class_name => "PatientEditForm",
        :border => true,
        :bbar => false,
        :is_sample_patient => true,
        :show_medicare_eligibility_action => true,
        :prevent_header => true,
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :width => "50%",
        :height => "85%",
        :title => "Add Patient",
        :item_id => "patient_new",
        :button_align => "right",
        :items => [form_config]
    }
  end

  js_method :on_add_referral,<<-JS
    function(){
      this.loadNetzkeComponent({name: "referral_new_form", callback: function(w){
        w.show();
        w.on('close', function(){
          if (w.closeRes === "ok") {
            this.store.load();
          }
        }, this);
      }, scope: this});
    }
  JS

  js_method :on_census_report,<<-JS
    function(){
      var g = this;
      var w = new Ext.window.Window({
          width: "80%",
          height: "80%",
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "",
              tooltip: "OK",
              iconCls: "ok_icon",
              listeners: {
                click: function(){
                  w.down("#census_report").runCensusReport(w, g);
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
            title: "Census Report",
        });
        w.show();
        this.loadNetzkeComponent({name: "census_report_form", container:w, callback: function(w){
          w.show();
        }});
    }
  JS

  component :census_report_form do
    {
        class_name: "CensusReportForm",
        :title => "Census Report",
        header: false,
    }
  end

  component :referral_new_form do
    form_config = {
        :class_name => "ReferralNewForm",
        :border => true,
        :bbar => false,
        :prevent_header => true,
        record: TreatmentRequest.new
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :width => "50%",
        :height => "70%",
        :title => "Add Referral",
        :button_align => "right",
        :items => [form_config]
    }
  end

  component :referral_edit_form do
    form_config = {
        :class_name => "ReferralEditForm",
        :border => true,
        :bbar => false,
        :prevent_header => true,
        record_id: component_session[:referral_id],
        record: TreatmentRequest.find_by_id(component_session[:referral_id])
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :width => "50%",
        :height => "70%",
        :title => "Add Referral",
        :button_align => "right",
        :items => [form_config]
    }
  end


  #  Superclass override: Only remove the paging as we do it manually now.
  def get_records(params)
    params[:scope] = config[:scope] # note, params[:scope] becomes ActiveSupport::HashWithIndifferentAccess
    data_adapter.get_records(params, columns)
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    #We can't merge the record id directly,For getting record id in edit form we have to find parent and chaild and merge
    #the record id.
    if params[:name] == 'patient_edit_form'
      components[:patient_edit_form][:items].first.merge!(:record_id => params[:record_id].to_i)
    else
     components[params[:name].to_sym].merge!(new_params)
    end
    super
  end

end
