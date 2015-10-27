class SchdVisits < Mahaswami::GridPanel
  include BatchAndVisitsHelper

  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:episode_id] = s[:episode_id] if s[:episode_id]
    s.merge(
        title: "Scheduled Visits",
        model: "ScheduledVisit",
        checkboxModel: true,
        infinite_scroll: false,
        enable_pagination: false,
        rowsPerPage: 5000,
        editOnDblClick: false,
        viewConfig: {
            markDirty: false
        },
        start_number: ScheduledVisit.where({visit_id: nil}).count + 1,
        number_of_records: 10,
        visit_type_store: visit_type_id_list(true),
        bbar: [:convert_to_visit.action, :add_10_records.action, :apply.action, :del.action],
        context_menu: false,
        item_id: "scheduled_visits_#{component_session[:episode_id]}",
        strong_default_attrs: {treatment_id: component_session[:treatment_id], treatment_episode_id: component_session[:episode_id]},
        columns: [
            {name: :record_number, header: "#", width: 25, tooltip: "Record Number", renderer: :row_number_display},
            {name: :scheduled_date, header: "Start Date", xtype: :datecolumn, format: 'm/d/Y', editable: true, width: 100,
                tooltip: "Start Date", sortable: false},
            {name: :start_time, header: 'T. in', width: 60, editable: true, renderer: :time_display, tooltip: "Time In", sortable: false},
            {name: :scheduled_end_date, header: "End Date", xtype: :datecolumn, format: 'm/d/Y', editable: true, width: 100,
                  tooltip: "End Date", sortable: false, hidden: true},
            {name: :end_time, header: 'T. out', width: 60, editable: true, renderer: :time_display, tooltip: "Time Out", sortable: false},
            {name: :visit_type__to_s, item_id: :visit_type_id, header: "Visit Type",
             editor: {:xtype => :combo, store: visit_type_id_list}, tooltip: "Visit Type", width: 115},
            {name: :field_staff__full_name, item_id: :visited_user_id, header: "Field Staff",
             editor: {:xtype => :combo, store: visited_user_id_list},
             tooltip: "Field Staff", width: 115, editable: true}
        ],
        scope: {visit_id: nil, treatment_id: component_session[:treatment_id], treatment_episode_id: component_session[:episode_id]},
    )
  end

  action :add_10_records, text: "10 Rows", tooltip: "Add 10 more records", icon: :add_new
  action :convert_to_visit, text: "Convert to Visit"

  js_method :on_add_10_records,<<-JS
    function(){
      this.addRecordsToStore();
    }
  JS

  js_method :on_convert_to_visit,<<-JS
    function(){
      var records = this.getSelectionModel().getSelection();
      if(records.length == 0) {
        this.msgDisplay("No Records Selected.");
      } else {
        var record_ids = [];
        Ext.each(records, function(record, index){
          var id = record.getId();
          record_ids.push(id);
        }, this);

        if (record_ids.indexOf(0) != -1) {
          this.msgDisplay("Please save the records before converting.");
        } else {
          var batchVisitsGrid = this.up("#schedule_visit_explorer_" + this.episodeId).down("#batch_visits_" + this.episodeId);
          batchVisitsGrid.appointmentsCopyTriggered = true;
          batchVisitsGrid.store.load();
          this.up('#batch_and_schedule_visits_' + this.episodeId).setActiveTab(0);
        }
      }
    }
  JS

  js_method :add_records_to_store,<<-JS
    function(){
      var recordCounts = this.store.getCount();
      var start = recordCounts + 1;
      recordCounts = recordCounts + (10 - (recordCounts % 10)) + 1;
      for (var i = start; i < recordCounts; ++i) {
        var r = Ext.ModelManager.create([null, i, null, null, null, null, null], this.id);
        r.isNew = true;
        this.getStore().add(r);
      }
    }
  JS

  js_method :row_number_display, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store){
      return rowIndex + 1;
    }
  JS

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.visitTypeValues = [];

      this.store.on('load', function(){
        this.addRecordsToStore();
        this.visitTypeValues = [];
        this.markVisitTypesToSchedule();
      }, this);

      this.on('beforeedit', function(editor, e, eOpts ){
        //Copy previous row data.
        if(e.colIdx == 3 && e.originalValue == null)
          this.copyPreviousRowContentToCurrentRow(e.record);
      }, this);

      this.on('edit', function(editor, e){
        this.markVisitTypesToSchedule();
      }, this);

      this.store.load();
    }
  JS

  js_method :after_render,<<-JS
    function() {
      this.callParent();
      var batchVisitsGrid = this.up("#schedule_visit_explorer_" + this.episodeId).down("#batch_visits_" + this.episodeId);
      batchVisitsGrid.store.on('load', function(){
        if ( batchVisitsGrid.appointmentsCopyTriggered ) {
          this.addRecordsToBatchVisitsStore(batchVisitsGrid);
          batchVisitsGrid.visitTypeValues = [];
          batchVisitsGrid.markVisitTypesToSchedule();
        }
      }, this);

      this.store.on('load', function(){
        if (this.moveActiveTabToZero) {
          this.moveActiveTabToZero = false;
          var scheduledVisitsExp = this.up("#schedule_visit_explorer_" + this.episodeId);
          scheduledVisitsExp.down('#batch_and_schedule_visits_' + this.episodeId).setActiveTab(0);
        }
      }, this);
    }
  JS

  js_method :add_records_to_batch_visits_store,<<-JS
    function( batchVisitsGrid ) {
      var existingRecords = batchVisitsGrid.store.data.items;
      var records = this.getSelectionModel().getSelection();
      records = records.concat(existingRecords);
      records.sort(function(a,b){
        var date1 = new Date(a.data.scheduled_date);
        var date2 = new Date(b.data.scheduled_date);
        return date1 - date2;
      });
      batchVisitsGrid.recordsCount = records.length;
      var indexCount = 1;
      Ext.each(records, function(rec, index) {
        var date = rec.data.scheduled_date;
        var startTime = rec.data.start_time;
        var endDate = rec.data.scheduled_date;
        var endTime = rec.data.end_time;
        var visitType = rec.data.visit_type__to_s;
        var appointmentId = null;
        var fieldStaff = rec.data.visited_user__full_name;
        if (fieldStaff == undefined) {
          appointmentId = rec.data.id;
          fieldStaff = rec.data.field_staff__full_name;
        }
        if( date.length > 0 || startTime.length > 0 || endDate.length > 0 || endTime.length > 0 || endTime.length > 0 || fieldStaff.length ) {
          var r = Ext.ModelManager.create([null, indexCount, date, startTime, endDate, endTime, visitType, fieldStaff, rec.data.id], batchVisitsGrid.id);
          r.isNew = true;
          r.setDirty(true);
          batchVisitsGrid.getStore().add(r);
          indexCount += 1;
        }
      }, this);
      batchVisitsGrid.appointmentsCopyTriggered = false;
    }
  JS

  js_method :copy_previous_row_content_to_current_row,<<-JS
    function(currentRecord){
      var currentIndex = this.store.indexOf(currentRecord);
      var previousIndex = currentIndex - 1;
      var model = this.getSelectionModel();
      model.selectRange(previousIndex, currentIndex);
      var recs = model.getSelection();
      var previousRecord = recs[recs.length - 1];
      currentRecord.set("start_time", previousRecord.data.start_time);
      currentRecord.set("end_time", previousRecord.data.end_time);
      currentRecord.set("field_staff__full_name", previousRecord.data.field_staff__full_name);
      currentRecord.set("visit_type__to_s", previousRecord.data.visit_type__to_s);
      model.deselect(previousIndex);
    }
  JS

  js_method :mark_visit_types_to_schedule, <<-JS
    function(){
      var scheduleGrid = this.up('#schedule_visit_explorer_' + this.episodeId).down("#patient_schedules_new_" + this.episodeId);
      var visits = $("div#"+scheduleGrid.id+" span.visits_list span.sch_visit");
      visits.remove();
      var records = this.store.getNewRecords();
      Ext.each(records, function(record, index){
        var visitTypeValue = record.data.visit_type__to_s;
        var visitDate = record.data.scheduled_date;
        var visitTimeIn = record.data.start_time;
        var visitEndDate = record.data.scheduled_date;
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

  endpoint :post_data do |params|
    mod_records = {}
    new_data = []
    [:create, :update].each do |operation|
      data = ActiveSupport::JSON.decode(params["#{operation}d_records"]) if params["#{operation}d_records"]
      if !data.nil? && !data.empty? # data may be nil for one of the operations
        data.each do |row|
          new_data << row if at_least_one_field_is_modified?(row, operation)
        end
      end
    end
    create_schedule_records(new_data)
  end

  def create_schedule_records(data)
    errors = []
    records = []
    data.each{|row|
      record = row["id"] == 0 ? data_adapter.new_record : ScheduledVisit.find(row["id"])
      record_number = row["record_number"]
      row.delete("record_number")
      row.delete("id") if row["id"] == 0
      row["scheduled_end_date"] = row["scheduled_date"]
      row.each_pair do |k,v|
        record.set_value_for_attribute(columns_hash[k.to_sym].nil? ? {:name => k} : columns_hash[k.to_sym], v)
      end
      record.schedule_visit_entry_defaults({treatment_id: component_session[:treatment_id], treatment_episode_id: component_session[:episode_id]})
      record.valid?
      success = record.errors.empty?
      records << record
      record.errors.to_a.each{|msg|
        errors << [record_number, msg]
      }
    }
    if errors.empty?
      records.each do |r|
        r.save!
      end
      {:refresh_grids => 1}
    else
      {:display_error_msgs => errors}
    end
  end

end