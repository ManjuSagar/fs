class Schedules < Mahaswami::GridPanel
  include ActionView::Helpers::NumberHelper
  include DocumentsCompRelated
  include DocCommOrderRelated

  def initialize(conf = {}, parent_id = nil)
    super
    return unless @treatment
    config[:treatment_id] = component_session[:treatment_id]
    config[:episode_id] = component_session[:episode_id]
    mo_instance = @treatment.medical_orders.build(treatment_episode_id: component_session[:episode_id])
    cn_instance = @treatment.communication_notes.build(treatment_episode_id: component_session[:episode_id])
    components[:medical_order_add_form][:items].first.merge!(strong_default_attrs: {treatment_id: @treatment.id}, :parent_id => @treatment.id, :record => mo_instance)
    components[:communication_notes_form][:items].first.merge!(strong_default_attrs: {treatment_id: @treatment.id}, :parent_id => @treatment.id, :record => cn_instance)
    if component_session[:document_definition_id]
      document_definition = DocumentDefinition.find(component_session[:document_definition_id])
      patient_name = @treatment.patient.full_name
      mr_num = @treatment.patient.patient_reference
      doc_instance, title = if component_session[:doc_id]
                              [Document.find(component_session[:doc_id]), "Edit #{document_definition.document_name} Patient: #{patient_name} (MR# #{mr_num})"]
                            else
                              [("Documents::" + document_definition.document_form_template.document_class_name).constantize.new.configuration[:model].constantize.new(:treatment_id => @treatment.id, treatment_episode_id: component_session[:episode_id]), "New #{document_definition.document_name} Patient: #{patient_name} (MR# #{mr_num})"]
                            end
      components[:add_document].merge!(:title => title)
      if doc_instance.id
        components[:add_document][:items].first.merge!(:record_id => doc_instance.id)
      else
        components[:add_document][:items].first.merge!(:record => doc_instance)
      end
      klass_name = "Documents::" + document_definition.document_form_template.document_class_name
      components[:add_document][:items].first.merge!(:class_name => klass_name, :klass_name => klass_name,
                                                     :strong_default_attrs => {:document_definition_id => component_session[:document_definition_id],
                                                                               :treatment_id => component_session[:treatment_id], treatment_episode_id: component_session[:episode_id]}, :treatment_id => component_session[:treatment_id])
      components[:add_document][:items].first.delete(:model)
    end
  end

  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:episode_id] = s[:episode_id] if s[:episode_id]
    @episode = component_session[:episode_id] ? TreatmentEpisode.find(component_session[:episode_id]) : nil
    @treatment = PatientTreatment.find_by_id(component_session[:treatment_id]) if component_session[:treatment_id]
    @episode = @treatment.treatment_episodes.find(component_session[:episode_id])
    if @episode and @treatment
      @doc_actions = document_actions(@treatment, @episode)
    end
    s.merge(
        {
            edit_on_dbl_click: false,
            enable_pagination: false,
            model: "PatientSchedule",
            cls: "td-border-top-left",
            title: "Schedule: #{treatment.patient} #{(@episode.present? ? ": #{@episode.certification_period}" : nil)}",
            item_id: "patient_schedules_new_#{component_session[:episode_id]}",
            episode_start_date: (@episode.present? ? @episode.start_date : nil),
            episode_end_date: (@episode.present? ? @episode.end_date : nil),
            columns: [{name: :visit_type, header: ' ', width:80, renderer: :visit_type_renderer},
                      {name: :day1, width:90, renderer: :visit_type_renderer},
                      {name: :day2, width:90, renderer: :visit_type_renderer},
                      {name: :day3, width:90, renderer: :visit_type_renderer},
                      {name: :day4, width:90, renderer: :visit_type_renderer},
                      {name: :day5, width:90, renderer: :visit_type_renderer},
                      {name: :day6, width:90, renderer: :visit_type_renderer},
                      {name: :day7, width:90, renderer: :visit_type_renderer, tdCls: "border-right"}]
        })

  end

  action :md_order, text: "Add MD Order", tooltip: "Add MD Order", item_id: 'add_md_order'
  action :comm_note, text: "Add Communication Note", tooltip: "Add Communication Note"
  action :save_freq_changes, text: "", tooltip: "Save Frequency Changes", icon: :save_new

  def treatment
    PatientTreatment.find(component_session[:treatment_id]) if component_session[:treatment_id]
  end

  js_method :visit_type_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store) {
      metadata.style +="text-align:center;";
      if(colIndex == 1)
        metadata.style +='background-color: #FAFAFA;';

      if (colIndex == 1) {
        var frequencyDetails = this.formatFrequencyContent(value, rowIndex);
        return "<div style='height:100px;'>WK " + (rowIndex + 1)  + frequencyDetails + "</div>";
      } else if (colIndex > 1) {
        return this.formatContent(value, metadata);
      }
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      menu = Ext.ComponentQuery.query('#menu')[0];
      this.documentsMenuUpdate(menu);
    }
  JS

  js_method :format_frequency_content, <<-JS
    function(data, rowIndex) {
      data = JSON.parse(data);
      var out = "";
      var name = "";
      var discipline = "";
      var value = "";
      var itemId = this.itemId;
      var episodeId = this.episodeId;
      var disciplines = {"SN": "19px", "PT": "21px", "OT": "19px", "ST": "22px", "MSW": "5px"};
      Ext.Array.each(data["frequencyDetails"], function(item){
        discipline = item.split(" ")[0];
        name = itemId + "-visit_count-" + discipline + "-" + rowIndex;
        value = item.split(" ")[1];
        var visitsCountNotMatched = item.split(" ")[2];
        var kolor = "black";
        if (visitsCountNotMatched == 'true'){
           kolor = "red";
        }
        if (data["inputRequired"]) {
          out += "<br/><span style='margin-left:" + disciplines[discipline] + ";color:"+ kolor +";' class='disciplines'>" +
                discipline + '</span> <input class="frequency_count episode_' + episodeId + '" type="number" name=' + name +' min="0"' +
                ' value=' + value + ' onkeypress=\"return isNumberKey(event);\" />';
        } else {
          out += "<br/><span style='margin-left:" + disciplines[discipline] + ";color:"+ kolor +";' class='disciplines'>" +
                discipline + " " + value + '</span> ';
        }
      });
      return out;
    }
  JS

  endpoint :update_frequency_value do |params|
    params.merge!({ treatment_id: component_session[:treatment_id], episode_id: component_session[:episode_id] })
    debug_log params
    VisitFrequency.create_or_update_visit_frequencies(params)
    {:refresh_data => 1}
  end

  js_method :format_content, <<-JS
    function(data, metadata) {
      values = JSON.parse(data);
      if (values["withinRange"] == false)
        metadata.style +='background-color: #FAFAFA';
      var content = "<span font-size:9px; <b><u>" + values["date"] + "</u></b><br/><br/><span>";
      var content1 = "";
      var content2 = "";
      if(values["referralReceived"] == true)
        content1 += " <img class=referral src=/assets/r.png />"
      if(values["medication"] == true)
        content1 += " <img class=medication src=/assets/m.png />"
      if(values["medicalOrder"] == true)
        content1 += " <img class=medicalorder src=/assets/o.png />"
      if(values["frequency"] == true)
        content1 += " <img src=/assets/f.png />"
      if(values["commNotes"] == true)
        content1 += " <img class=commnote src=/assets/c.png />"
      if(values["attachment"] == true)
        content1 += " <img class=attachment src=/assets/a.png />";
      content += content1 +  "</span>";
      if (  content1.length > 0 ) content += "<br/>";
      content += "<span class='visits_list'>";
      if(values["scheduledVisits"] != null){
        content += this.displayVisitsInfo(values["scheduledVisits"], "blue", "scheduled_visit");
      }
      if(values["visits"] != null)
        content += this.displayVisitsInfo(values["visits"], "blue", "visit");

       if(values["completedVisits"] != null){
         content += this.displayVisitsInfo(values["completedVisits"], "black", "visit");
       }

       if(values["authorizationTracking"].length != 0){
        content2 += this.displayAuthorizationTracking(values["authorizationTracking"], "authorization_tracking");
       }

      var heldDisciplines = values["heldDisciplines"].length > 0;
      if(heldDisciplines){
         metadata.style +='background-color: #A7E9A7';
       }

      content += "</span>";
      var formattedDate = "";
      if(values["date"] != null) formattedDate = values["date"].split('/').join('');
      var divId = 'schedule_date_' + formattedDate;
      var query = "Ext.ComponentQuery.query(\'#" + this.itemId + "\')[0].displayToolTip(\'"+values["heldDisciplines"].join(', ')+"\', \'"+ divId +"\');";
      var cellMouseOverContent = heldDisciplines ? ('class="held" onmouseover="' + query + '"') : '';
      content = "<div id='" + divId + "' style='height:100px;vertical-align:bottom;' " +  cellMouseOverContent + " >" + content + "</div>";
      if (content2) {content += content2}
      return content;
    }
  JS

  js_method :displayToolTip,<<-JS
    function(disciplines, divId){
      var disciplines = Ext.Array.unique(disciplines.split(', ')).join(', ');
      var ele = $('div#' + divId)[0]
      var msg;
      if (disciplines.length == 0 || disciplines[0] == ','){
       disciplines = 'All Disciplines are in hold';
       msg = '';
      }else{
      msg = (disciplines.length > 2) ? ' are on Hold' : ' is on hold'
      }
          toolTip = Ext.create('Ext.tip.ToolTip', {
                        target: ele,
                        trackMouse: true,
                        html: disciplines + msg
                    }, this);
        toolTip.show();
    }
  JS

  js_method :display_visits_info,<<-JS
    function(list, color, klass){
      var content = "";
      Ext.Array.each(list, function(visit){
          if(visit[2] == true){
            color = 'red';
          }
          content += "<span class=" + klass + " visit_id=" + visit[0] + " style='color:" + color + ";font-size:10px;font-weight:bold'>" + visit[1] + "</span><br/>";
      });
      return content;
    }
  JS

  js_method :display_authorization_tracking,<<-JS
    function(list, klass){
     var uniqDisciplines = Ext.Array.unique(list);
      if(uniqDisciplines.length < 4 ){
        uniqDisciplines = uniqDisciplines.join(', ')
      }
     var content = "";
      disciplines = "<span style='font-size:10px; color: white;'>" + uniqDisciplines + "</span>";
      content += "<div id= "+klass+" style=' width: 90px; height: 15px; margin-left: -11px; margin-top:-11px; position: absolute'>" + disciplines + "</div>"
     return content;
    }
JS

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.getView().on("refresh", function(){this.registerHandlers()}, this);
      this.getColumnTitles({}, function(titles) {
        for(i=0; i< titles.length; i++)
          this.columns[i+1].setText(titles[i]);
      });
    }
  JS

  js_method :on_save_freq_changes, <<-JS
    function() {
      var inputFields = $('input.episode_' + this.episodeId);
      var values = [];
      Ext.each(inputFields, function(inputField, index) {
        var name = inputField.name;
        var arr = name.split("-");
        var value = inputField.value;

        var rowDate1 = this.store.data.items[arr[3]].data.day1;
        var rowDate7 = this.store.data.items[arr[3]].data.day7;
        values.push({field_name: name, value: value, week_start_date: rowDate1.substring(9, 19), week_end_date: rowDate7.substring(9, 19)});
      }, this);
      this.updateFrequencyValue({values: values});
    }
  JS

  js_method :register_handlers, <<-JS
    function() {
      this.getEl().select("[class=visit]").setStyle('cursor', 'pointer');
      this.getEl().select("[class=visit]").on("click", function(ele) {
        var visit_id = ele.target.getAttribute("visit_id");
        launchPatientWindow({component_class_name: "VisitEditForm", treatment_id: this.treatmentId,treatment_request_id: null,
            height: "80%", width: "50%", params: {bbar: false, treatment_id: this.treatmentId, visit_id: visit_id,
           episode_id: this.episodeId, record_id: visit_id, title: "Visit"}, grid_item_id: this.itemId});
      }, this);
      this.getEl().select("[class=commnote]").setStyle('cursor', 'pointer');
      this.getEl().select("[class=commnote]").on("click", function() {
        launchPatientWindow({component_class_name: "CommunicationNotes",treatment_request_id: null, treatment_id: this.treatmentId, grid_item_id: this.itemId,
        params: {episode_commnotes: true, treatment_id: this.treatmentId, episode_id: this.episodeId, bbar: []}});
      }, this);
      this.getEl().select("[class=medicalorder]").setStyle('cursor', 'pointer');
      this.getEl().select("[class=medicalorder]").on("click", function() {
        launchPatientWindow({component_class_name: "MedicalOrders", treatment_request_id: null, treatment_id: this.treatmentId, grid_item_id: this.itemId,
        params: {episode_orders: true, treatment_id: this.treatmentId, episode_id: this.episodeId, bbar: []}});
      }, this);

      this.getEl().select("[class=medication]").setStyle('cursor', 'pointer');
      this.getEl().select("[class=medication]").on("click", function() {
        launchPatientWindow({component_class_name: "TreatmentMedications",treatment_request_id: null, treatment_id: this.treatmentId, grid_item_id: this.itemId,
        params: {episode_medications: true, treatment_id: this.treatmentId, episode_id: this.episodeId, bbar: [], item_id: "active_medications_" + this.episodeId}});
      }, this);

      this.getEl().select("[class=attachment]").setStyle('cursor', 'pointer');
      this.getEl().select("[class=attachment]").on("click", function() {
        console.log(this.episodeId);
        launchPatientWindow({component_class_name: "TreatmentAttachments", treatment_request_id: null, parent_id: this.treatmentId, treatment_id: this.treatmentId, grid_item_id: this.itemId,
        params: {episode_id: this.episodeId, treatment_id: this.treatmentId, bbar: []}});
      }, this);
    }
  JS

  def default_bbar
    menu = if (User.current.office_staff?)
             [:save_freq_changes.action, {text: "", item_id: 'menu', menu: ([:md_order.action,
                :comm_note.action] + @doc_actions), iconCls: 'add_icon'}]
           else
             []
           end
    menu + [ {xtype: 'label', margin: '0 440px 0 0px', text: 'A: Attachment, C: Communication Note,
         M: Medication, O: MD Order, R: Referral'}]
  end

  def default_context_menu
    []
  end

  def get_data(*args)
    res = {}
    start, limit = if args.empty?
                     [0, 30]
                   else
                     [args[0][:start].to_i, (args[0][:page].to_i * args[0][:limit].to_i) - 1]
                   end
    treatment = PatientTreatment.find(component_session[:treatment_id])
    episode = TreatmentEpisode.find(component_session[:episode_id])
    patient_schedules = PatientSchedule.schedule_for_treatment(treatment, episode )
    res[:data] = patient_schedules[start..limit]
    res[:total] = patient_schedules.size
    res
  end

  endpoint :get_column_titles do |params|
    week_days = PatientTreatment.find(component_session[:treatment_id]).patient.org.week_days
    {set_result: [''] + week_days}
  end


end