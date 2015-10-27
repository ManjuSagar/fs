class BatchVisits < Mahaswami::GridPanel
  include BatchAndVisitsHelper

  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:episode_id] = s[:episode_id] if s[:episode_id]
    s.merge(
       title: "Visits",
       model: "TreatmentVisit",
       infinite_scroll: false,
       enable_pagination: false,
       rowsPerPage: 5000,
       item_id: "batch_visits_#{component_session[:episode_id]}",
       editOnDblClick: false,
       viewConfig: {
           markDirty: false
       },
       visit_type_store: visit_type_id_list(true),
       number_of_records: 10,
       bbar: [:add_10_records.action, :apply.action, :clear.action, :clear_all.action],
       context_menu: [],
       columns: [
         {name: :record_number, header: "#", width: 25, tooltip: "Record Number"},
         {name: :visit_date, header: "Start Date", xtype: :datecolumn, format: 'm/d/Y', width: 100, tooltip: "Start Date",
                                        editor: {:xtype => :datefield}},
         {name: :start_time, header: 'T. in', width: 60, renderer: :time_display, tooltip: "Time In", editable: true},
         {name: :visit_end_date, header: "End Date", xtype: :datecolumn, format: 'm/d/Y', width: 100, tooltip: "End Date",
                                        editor: {:xtype => :datefield}, hidden: true},
         {name: :end_time, header: 'T. out', width: 60, renderer: :time_display, tooltip: "Time Out", editable: true},
         {name: :visit_type__to_s, item_id: :visit_type_id, header: "Visit Type", editor: {:xtype => :combo, store: visit_type_id_list}, tooltip: "Visit Type", width: 115},
         {name: :visited_user__full_name, item_id: :visited_user_id, header: "Visited User", editor: {:xtype => :combo, store: visited_user_id_list}, tooltip: "Visited User", width: 115},
         {name: :appointment_id, item_id: :appointment_id, header: "Visited User", hidden: true}
    ],
       scope: ["id is null and draft_status = ?", true],
    )
  end

  action :add_10_records, text: "10 Rows", tooltip: "Add 10 more records", icon: :add_new
  action :clear, text: "Clear", tooltip: "Clear"
  action :clear_all, text: "Clear All", tooltip: "Clear All"
  action :apply, text: ""

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.recordsCount = this.numberOfRecords;
      this.visitTypeValues = [];

      this.store.on('load', function(){
        if ( this.appointmentsCopyTriggered == false || this.appointmentsCopyTriggered == undefined) {
          this.recordsCount = this.numberOfRecords;
          this.addRecordsToStore(0);
          this.visitTypeValues = [];
          this.markVisitTypesToSchedule();
        }
      }, this);

      this.on('edit', function(editor, e){
        this.markVisitTypesToSchedule();
      }, this);

      this.store.load();
    }
  JS

  js_method :mark_visit_types_to_schedule, <<-JS
    function(){
      var scheduleGrid = this.up('#schedule_visit_explorer_' + this.episodeId).down('#patient_schedules_new_' + this.episodeId);
      var visits = $("div#"+scheduleGrid.id+" span.visits_list span.sch_visit");
      visits.remove();
      var records = this.store.getNewRecords();
      Ext.each(records, function(record, index){
        var visitTypeValue = record.data.visit_type__to_s;
        var visitDate = record.data.visit_date;
        var visitEndDate = record.data.visit_date;
        var visitTimeIn = record.data.start_time;
        var visitTimeOut = record.data.end_time;
        if(visitTypeValue != null && visitTypeValue != "" && visitDate != null && visitDate != "" && visitEndDate != null && visitEndDate != ""){
          var formattedDate = Ext.util.Format.date(visitDate, "mdY");
          var formattedEndDate = Ext.util.Format.date(visitEndDate, "mdY");
          var formattedVisitValue = null;
          Ext.each(this.visitTypeStore, function(f, i){
            if(f[0] == visitTypeValue) formattedVisitValue = f[1];
          }, this);
          if(visitTimeIn != null){
            var timeIn = visitTimeIn.toString();
            formattedVisitValue += " " + timeIn.substr(0, timeIn.length - 2) + ":" + timeIn.substr(timeIn.length - 2, timeIn.length - 1);
          }
          var br = $("div#" + scheduleGrid.id + " div#schedule_date_" + formattedDate + " span.visits_list br");
          br.remove();
          var visitListEl = $("div#" + scheduleGrid.id + " div#schedule_date_" + formattedDate + " span.visits_list");
          var txt = "";
          txt += visitListEl.html() + "<span class=sch_visit style='color:purple;font-size:9px;font-weight:bold'>" + formattedVisitValue + "</span>";
          txt = txt.replace(/<span/g,"<br/><span");
          visitListEl.html(txt);
        }
      }, this);
    }
  JS

  js_method :on_add_10_records,<<-JS
    function(){
      this.addRecordsToStore(this.recordsCount);
      this.recordsCount += this.numberOfRecords;
    }
  JS

  js_method :add_records_to_store,<<-JS
    function(n){
      for (var i = n; i < (n + this.numberOfRecords); ++i) {
        var r = Ext.ModelManager.create([null, i + 1, null, null, null, null, null, null], this.id);
        r.isNew = true;
        this.getStore().add(r);
      }
    }
  JS

  js_method :on_clear, <<-JS
    function(){
      var recs = this.getSelectionModel().getSelection();
      Ext.each(recs, function(rec, index){
        var r = Ext.ModelManager.create([null, rec.data.record_number, null, null, null, null, null, null], this.id);
        this.store.insert( rec.data.record_number - 1, [r] );
        this.store.remove([rec]);
      }, this);
      this.markVisitTypesToSchedule();
    }
  JS

  js_method :on_clear_all, <<-JS
    function(){
      var records = this.store.getNewRecords();
      var isDirty = false;
      Ext.each(records, function(rec, index){
        if(rec.dirty) isDirty = true;
      }, this);
      if(isDirty){
        Ext.MessageBox.confirm("Confirmation", "Are you sure want to clear all visits?", function(btn){
          if(btn == "yes"){
            this.store.load();
          }
        }, this);
      }
    }
  JS

  endpoint :post_data do |params|
    data = ActiveSupport::JSON.decode(params["created_records"]) if params["created_records"]
    if !data.nil? && !data.empty? # data may be nil for one of the operations
      data = data.select{|row| at_least_one_field_is_modified?(row, :create) }
      overlapped = []
      data.each do |row|
        res = TreatmentVisit.check_visit_is_overlapped(component_session[:treatment_id], row, nil, data - [row], true)
        overlapped << "Record # #{row['record_number']} " + res if res
      end
      return {:confirmation_msg => [overlapped.join("<br/><br/>") + "<br/><br/>" + "Would you like to proceed?", data] } unless overlapped.blank?
      create_visit_records(data)
    else records.empty?
      {:msg_display => "Enter at least one visit."}
    end
  end

  endpoint :create_records do |params|
    data = []
    params[:data].each do |row|
      h = {}
      row.each do |k, v|
        key = if ["id", "recordNumber", "visitDate", "startTime", "visitEndDate", "endTime", "appointmentId"].include?(k)
                k.underscore
              elsif k == "visitTypeToS"
                "visit_type__to_s"
              elsif k == "visitedUserFullName"
                "visited_user__full_name"
              end
        h[key] = v unless key.blank?
      end
      data << h
    end
    create_visit_records(data)
  end

  def create_visit_records(data)
    errors = []
    records = []
    atleast_one_from_schedule = data.any?{|row| row["appointment_id"].present? }
    data.each{|row|
      record = data_adapter.new_record
      row.delete('id')
      row["visit_end_date"] = row["visit_date"]
      row.each_pair do |k,v|
        record.set_value_for_attribute(columns_hash[k.to_sym].nil? ? {:name => k} : columns_hash[k.to_sym], v)
      end
      record.schedule_visit_entry_defaults({treatment_id: component_session[:treatment_id], treatment_episode_id: component_session[:episode_id]})
      record.valid?
      record.schedule_visit_time_in_and_time_out_format_check
      success = record.errors.empty?
      records << record
      record.errors.to_a.each{|msg|
        errors << [row["record_number"], msg]
      }
    }
    if errors.empty?
      records.each_with_index do |r, i|
        r.save!
        r.inform_visit_frequency_visit_is_added
        r.complete! if r.may_complete?
        unless data[i]["appointment_id"].blank?
          org = r.treatment.patient.org
          schd_visit = ScheduledVisit.not_visited(org).find(data[i]["appointment_id"])
          schd_visit.treatment_visit = r
          schd_visit.save!
        end
      end
    end

    if errors.empty?
      {:refresh_scheduled_visits => atleast_one_from_schedule, :refresh_grids => 1}
    else
      {:display_error_msgs => errors}
    end
  end

  js_method :refresh_scheduled_visits, <<-JS
    function(res) {
      if (res) {
        var scheduledVisitsExp = this.up("#schedule_visit_explorer_" + this.episodeId);
        var scheduledVisitsGrid = scheduledVisitsExp.down("#scheduled_visits_" + this.episodeId);
        scheduledVisitsExp.down('#batch_and_schedule_visits_' + this.episodeId).setActiveTab(1);
        scheduledVisitsGrid.moveActiveTabToZero = true;
        scheduledVisitsGrid.store.load();
      }
    }
  JS

end