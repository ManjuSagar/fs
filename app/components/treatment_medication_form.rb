class TreatmentMedicationForm < Mahaswami::FormPanel

  def configuration
     c = super
     component_session[:treatment_id] = c[:treatment_id] if c[:treatment_id]
     component_session[:visit_id] = c[:visit_id] if c[:visit_id]
     component_session[:parent_model] = c[:parent_model]if c[:parent_model]
     component_session[:treatment_episode_id] = c[:epi_cert_period] if c[:epi_cert_period]
     c[:strong_default_attrs] = if c[:strong_default_attrs]
                                  c[:strong_default_attrs].merge({treatment_id: component_session[:treatment_id]})
                                else
                                  (component_session[:parent_model] == "TreatmentVisit") ? {treatment_id: component_session[:treatment_id], visit_id: component_session[:visit_id]} : {treatment_id: component_session[:treatment_id]}
                                end
     c.merge(
       model: "TreatmentMedication",
       enableSaveAndContinue: true,
       item_id: :medication_form,
       clear_state_on_destroy: false, #For multiple medication adding purpose, manually destroyed this component.
       treatment_episode_id: component_session[:treatment_episode_id],
       parent_model: component_session[:parent_model],
       treatment_id: component_session[:treatment_id] || c[:treatment_id],
       items: [{name: :assessment_date, field_label: "Assessment Date", item_id: "Med Assessment Date",  value: c[:med_assessment_date]},
               {name: :episode__certification_period, field_label: "Episode", item_id: :episode_id, value: c[:treatment_episode_id]},
               {name: :fda_drug_library__drug_name, field_label: "Name", item_id: :medication_name, autoSelect: false, triggerAction: 'query',
                afterLabelTextTpl: '<a style="cursor:pointer;" onclick="Ext.ComponentQuery.query(\'#medication_form\')[0].displayDrugsInformation();"><img style="postion:relative;top:100px" src="/assets/icons/information.png" class="info_image" data-qtip="Information"></img></a>'},
               {name: :fda_drug_library__dosage_form, field_label: "Dosage Form",   item_id: :dosage_form},
               {name: :frequency, field_label: "Frequency"},
               {name: :medication_code, field_label: "N/C/L", xtype: 'combo', store: TreatmentMedication::MEDICATION_CODES,
               editable: false},
               {name: :purpose, field_label: "Purpose", xtype: 'textareafield', rows: 3},
               {name: :potential_side_effects, field_label: "Potential Side Effects", xtype: 'textareafield', rows: 3},
               {name: :start_date, field_label: "Start Date", item_id: "Med Start Date", value: c[:med_start_date]},
               {name: :end_date, field_label: "End Date"}
       ],
     )
     
  end

  def episode__certification_period_combobox_options(params)
    {:data => PatientTreatment.find(component_session[:treatment_id]).treatment_episodes.collect{|e|[e.id, e.certification_period]}}
  end

  def fda_drug_library__drug_name_combobox_options(params)
    if params["query"].present? or component_session[:drug_name].present?
      query = params["query"].present? ? "%#{params["query"].upcase}%" : component_session[:drug_name].split(" (").first
      {:data => FdaDrugLibrary.where(["upper(drug_name) LIKE ? OR upper(active_ingredients) LIKE ?", query, query]).
          order("drug_name").collect{|m| ["#{m.drug_name} (#{m.strength})", "#{m.drug_name} (#{m.strength})"]}.uniq}
    else
      {:data => []}
    end
  end

  def fda_drug_library__dosage_form_combobox_options(params)
    list = DosageForm.where(["dosage_forms.id IN (SELECT form_id FROM fda_drug_libraries WHERE drug_name = ? AND strength = ?)",
                             component_session[:drug_name], component_session[:dosage]])
    values = if params["query"].present?
               list.where(["upper(form) LIKE ?", "%#{params["query"].upcase}%"])
             else
               list
             end
    values = values.collect!{|m| [m.form, m.form]}.uniq
    {:data => values}
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.down("#medication_name").store.on("beforeload", function(){
         this.down("#medication_name").store.removeAll();
      }, this);
      this.down("#dosage_form").store.on("beforeload", function(){
         this.down("#dosage_form").store.removeAll();
      }, this);

      this.down("#medication_name").on('select', function(ele){
        this.selectDrugName({drug_name: ele.value});
      }, this);
      if(this.record.id == null){
        this.refreshComboStore('medication_name');
      }
      this.down("#episode_id").store.load();
      this.down("#episode_id").setValue(this.treatmentEpisodeId);
    }
  JS


  js_method :displayDrugsInformation, <<-JS
    function(){
      var drug_name = this.down("#medication_name").value;
      if(drug_name){
        var w = new Ext.window.Window({
          width: 650,
          height: 500,
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
          title: "Drugs Information",
        });
        w.show();
        this.loadNetzkeComponent({name: "medication_information", container:w, callback: function(w){
          w.show();
        }, params: {component_params: {drug_name: drug_name}}});
      } else {
        Ext.MessageBox.alert("Status", "Select Medication Name to view information");
      }
    }
  JS

  component :medication_information do
    {
       class_name: "MedicationInformation"
    }
  end

  endpoint :select_drug_name do |params|
    unless params[:drug_name].blank?
      component_session[:drug_name], component_session[:dosage] = params[:drug_name].split(" (")
      component_session[:dosage] = component_session[:dosage].split(")").first
    else
      component_session[:drug_name] = nil
      component_session[:dosage] = nil
    end
    {refresh_combo_store: [:dosage_form]}
  end

  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end

end
