class Documents::OasisContainerFormPanel < Mahaswami::SubPanel
  include ActionView::Helpers::NumberHelper

  def configuration
    sup = super
    rec = sup[:record]
    if (sup[:record_id])
      rec ||= Document.find(sup[:record_id])
      non_key_field_correction = rec.non_key_field_correction?
      soc_date_key_field = rec.soc_date_key_field?
      roc_date_key_field = rec.roc_date_key_field?
      hide_refresh_agency_info = rec.hide_agency_info_button
      info_completed_date_key_field = rec.info_completed_date_key_field?
      dc_trnas_dth_date_key_field = rec.dc_trnas_dth_date_key_field?
      private_insurance = rec.treatment.private_insurance?
    end
    if rec
      private_insurance = rec.treatment.private_insurance?
      column_2_not_required = ["01", "03"].include?(rec.send("m0100_assmt_reason"))
      display_clinical_fields = rec.present? ? rec.display_clinical_fields? : false
      visit_doc_episode_id = super[:params][:treatment_episode_id] if super[:params]
      episode_id = rec.treatment_episode_id || visit_doc_episode_id
      treatment_episode = TreatmentEpisode.org_scope.where(id: episode_id).first
      icd_required_doc = ['OasisEvaluation', 'OasisRecertification', 'OasisResumptionOfCare', 'OasisOtherFollowup'].include? rec.document_type
      asst_date_condition_required = if  treatment_episode and (treatment_episode.start_date > Date.parse('05-10-2015') || treatment_episode.start_date < Date.parse('03-08-2015'))
                                       false
                                     else
                                       icd_required_doc
                                     end
      extendedComboPanels = if treatment_episode and asst_date_condition_required and (treatment_episode.start_date >= Date.parse('01-10-2015') || (rec.m0090_info_completed_dt and Date.strptime(rec.m0090_info_completed_dt, '%m/%d/%Y') >= Date.parse('20151001')))
                              sup[:panel_details_1]
                            elsif treatment_episode and asst_date_condition_required and (treatment_episode.start_date <= Date.parse('03-08-2015') ||  (rec.m0090_info_completed_dt and Date.strptime(rec.m0090_info_completed_dt, '%m/%d/%Y') < Date.parse('20151001')))
                              sup[:panel_details_2]
                            elsif (treatment_episode and icd_required_doc and treatment_episode.start_date < Date.parse('03-08-2015'))
                              sup[:panel_details_2].present? ? sup[:panel_details_2] : sup[:panel_details]
                            elsif (treatment_episode and icd_required_doc and treatment_episode.start_date >= Date.parse('05-10-2015'))
                              sup[:panel_details_1]
                            else
                              sup[:panel_details]
                            end
    end

    correction_number = rec.present? ? rec.get_correction_for_form : false
    poc_fields_read_only = rec.can_not_edit_clinical_fields?
    doc_is_in_init_draft = rec.init_draft?
    panels = sup[:items]
    sup.merge(
        nonKeyFieldCorrection: non_key_field_correction,
        socDateKeyField: soc_date_key_field,
        rocDateKeyField: roc_date_key_field,
        hideRefreshAgencyInfo: hide_refresh_agency_info,
        infoCompletedDateKeyField: info_completed_date_key_field,
        column2NotRequired: column_2_not_required,
        dcTrnasDthDateKeyField: dc_trnas_dth_date_key_field,
        pocFieldsReadOnly: poc_fields_read_only,
        docIsInInitDraft: doc_is_in_init_draft,
        asstDateConditionRequired: asst_date_condition_required,
        border: false,
        correction_number: correction_number,
        layout: 'fit',
        fbar: (Rails.env == "production" ? [] : [:populate_valid_sample.action]),
        title: "",
        item_id: "super_main",
        extendedOasisPageList: panel_combo_list(extendedComboPanels, display_clinical_fields),
        normalOasisPageList: panel_combo_list(extendedComboPanels),
        normalOasisPageListIcd10: panel_combo_list(sup[:panel_details_1], display_clinical_fields),
        normalOasisPageListIcd9: panel_combo_list(sup[:panel_details_2], display_clinical_fields),
        pageListPosition: panel_position_info(sup[:panel_details]),
        pageListPositionIcd10: panel_position_info(sup[:panel_details_1]),
        pageListPositionIcd9: panel_position_info(sup[:panel_details_2]),
        items: [{
                    xtype: :panel,
                    item_id: 'main',
                    layout: 'card',
                    activeItem: 0,
                    bbar:[{xtype: 'text',
                           cls: 'oasis_green',
                           margin: '0 0 0 20px',
                           text: 'These items affect finances'
                          },
                          {xtype: 'text',
                           cls: 'oasis_blue',
                           margin: '0 0 0 20px',
                           text: 'These items affect OBQI/OBQM'
                          },
                          {xtype: 'text',
                           cls: 'oasis_pink',
                           margin: '0 0 0 20px',
                           text: 'These items affect both finances and OBQI/OBQM'
                          }]+
                          ((display_clinical_fields and rec.document_type == 'OasisEvaluation') ? [{
                              xtype: "checkboxfield",
                              name: "extended_oasis",
                              boxLabel: "Extended OASIS (included in POC)",
                              item_id: "extended_oasis_check",
                              margin: '0 0 0 20px',
                              inputValue: true,
                              checked: true
                          }] : []),

                    items: panels + [{name: :valid, item_id: :valid, xtype: :checkbox, hidden: true, inputValue: true}]
                }
        ]
    )
  end

  action :populate_valid_sample, text: "Populate Valid Sample", icon: :report

  js_method :on_populate_valid_sample,<<-JS
    function(){
      onPopulateValidSample(this);
    }
  JS

  endpoint :get_hipps_code_and_amount do |params|
    doc = config[:record] || OasisEvaluation.find_by_id(config[:record_id])
    if params[:cbsa_code]
      cbsa = ProspectivePaymentSystem::MedicareCoreStatArea.find_by_cbsa_code(params[:cbsa_code])
      if cbsa
        zip = ZipCode.find_by_admin_name_2(cbsa.county_name)
        if zip
          patient = doc.treatment.patient
          patient.update_attributes({zip_code: zip.zip_code, state: zip.admin_code_1, city: zip.locality})
          doc.m0060_pat_zip = zip.zip_code
          doc.save!
        end
      end
    end
    score, bill_amount = doc.treatment_episode.score_hipps_code_and_bill_amount({doc: doc, regenerate_hipps_code: true}) if doc.treatment_episode
    hipps_code = score.hipps_code
    hipps_code ||= ""
    bill_amount = bill_amount ? number_to_currency(bill_amount, :format => "%n") : 0
    {set_result: [hipps_code, bill_amount]}
  end

  endpoint :get_oasis_sample_form_values do |params|
    `rake export_oasis_soc_doc hipps_code=#{params[:hipps_code]}`
    hash_values = YAML.load(File.read("#{Rails.root}/oasis_example.yml"))
    removable_attrs = ["patient_name", "mr", "physician_name", "treatment_episode_id", "field_staff_id", "supervised_user_id",
                       "m0040_pat_fname", "m0040_pat_mi", "m0040_pat_lname", "m0040_pat_suffix",
                       "m0064_ssn", "m0050_pat_st", "m0060_pat_zip", "m0066_pat_birth_dt", "m0069_pat_gender",
                       "m0030_start_care_dt", "m0065_medicaid_num", "m0063_medicare_num", "m0020_pat_id", "m0018_physician_id",
                       "m0090_info_completed_dt", "m0100_assmt_reason", "subm_hipps_code"
    ]
    hash_values.reject!{|field, value| removable_attrs.include?(field)}
    {set_result: [hash_values.keys, hash_values.values]}
  end

  js_method :on_validate, <<-JS
    function(){
      onValidate(this, false);
    }
  JS

  endpoint :check_server_validation_for_fields do |params|
    episode_id = params[:episode_id]
    episode_id ||= if config[:record]
                     config[:record][:treatment_episode_id]
                   else
                     Document.find(config[:record_id])[:treatment_episode_id]
                   end
    errors = Document.check_fields_value({fields: params[:fields], values: params[:values], suffixes: params[:suffixes],
                                          panel_numbers: params[:panel_numbers], doc_type: params[:doc_type], episode_id: episode_id})
    {set_result: errors}
  end


  js_method :on_validate_all, <<-JS
    function(){
      var hippsRequiredDocFlag = false;
      this.isHippsCodeRequiredDoc({},function(res){
        hippsRequiredDocFlag = res;
        var errors = this.validateIndividualPanels(false, true, hippsRequiredDocFlag);
      },this);
    }
  JS

  js_method :validate_individual_panels,<<-JS
    function(onlyErrorsList, flag, hippsRequiredDocFlag){
      validateIndividualPanels(onlyErrorsList, this, flag, hippsRequiredDocFlag);
    }
  JS

  endpoint :is_hipps_code_required_doc do |params|
    result = if config[:record_id]
                Document.find(config[:record_id]).hipps_code_required_doc?
              elsif config[:record]
                config[:record].hipps_code_required_doc?
              end
    {set_result: result}
  end

  endpoint :validate_input_fields do |params|
    form_fields = params[:form_fields]
    field_key = ""
    form_fields.keys.each{|field| field_key = field if field.start_with?("combobox")}
    form_fields.delete(field_key)
    oasis = OasisEvaluation.new(form_fields)
    unless oasis.valid?
      errs = oasis.errors.collect{|field, msg| [OasisEvaluation::FIELD_DESCRIPTION[field], msg]}
      {:launch_errors_grid => [errs, errs.size]}
    else
      {:success_message => true}
    end
  end

  js_method :success_message, <<-JS
    function(result){
      Ext.Msg.alert('Information', 'Validation success, No Errors Found');
    }
  JS

  js_method :launch_errors_grid, <<-JS
    function(args){
      launchErrorsGrid(args, this);
    }
  JS

  component :hipps_grouper_chart do
    {
        class_name: 'GrouperExplorer',
        record_id: config[:record_id],
        strong_default_attrs: config[:params],
        model: config[:model],
        header: false,
    }
  end


  def panel_combo_list(panels, extended = false)
    list = []
    count = -1
    panels.each do |p|
      count = count + 1
      next if (extended == false and p[1].present?)
      next if (extended == true and p[1].present? and ['icd9', 'icd10'].include? p[1])
      list << [count, p[0]]
    end
    list
  end

  def panel_position_info(panels)
    list = {}
    count = -1
    panels.each_with_index do |p, i|
      count = count + 1 if p[1].nil?
      str = p[0].split.join.downcase.gsub("/", "")
      list[str] = [count, i]
    end
    list
  end

  js_method :init_component, <<-JS
    function() {
      this.panels = {};
      this.callParent();
      this.setTitle(false);
    }
  JS

  js_method :after_render,<<-JS          # font type Bold is added to all the input types in the oasis forms
    function(){
      this.callParent();
      infoCompletedDt = Ext.ComponentQuery.query('[name=m0090_info_completed_dt]')[0];
      if(this.asstDateConditionRequired){
        infoCompletedDt.on('change', function(el){
          if(el.value != null){
            this.resetComboBasedOnInfoDate(el.value);
          }
        },this);
      }
      registerOasisFormEvents(this);
    }
  JS

  js_method :resetComboBasedOnInfoDate, <<-JS
    function(el){
      var goTo = this.up('window').down('#item_chooser');
        var currentIndex = comboCurrentIndex(goTo);
        var display = goTo.store.getAt(currentIndex);
        if(display){
          display = display.raw[1];
          var str = display.split(" ");
          str = str.join('');
          str = str.toLowerCase();
          this.getIcdType({date: el}, function(res){
            goTo.store.removeAll();
            if (res == '0'){
              this.index = this.pageListPositionIcd10[str];
              goTo.store.add(this.normalOasisPageListIcd10);
            } else if(res == '9') {
              this.index = this.pageListPositionIcd9[str];
              goTo.store.add(this.normalOasisPageListIcd9);
            }
            this.index = this.index[0];
            goTo.setValue(goTo.store.getAt(this.index));
            goTo.fireEvent('select', goTo);
          });
        } else {
           this.getIcdType({date: el}, function(res){
            goTo.store.removeAll();
            if (res == '0'){
              goTo.store.add(this.normalOasisPageListIcd10);
            } else if(res == '9') {
              goTo.store.add(this.normalOasisPageListIcd9);
            }
            goTo.fireEvent('select', goTo);
          });

        }
    }
  JS

  endpoint :get_icd_type do |params|
    date= params[:date].gsub('-','')[0..7]
    date = Date.parse(date)
    res = date < Date.parse('20151001') ? '9' : '0'
    {set_result: res}
  end

  endpoint :check_for_proper_state do |params|
    res = State.find_by_state_code(params[:state_code])
    {set_result: res.nil?}
  end

  endpoint :check_for_proper_zip_code do |params|
    res = ZipCode.find_by_zip_code(params[:zip_code])
    {set_result: res.nil?}
  end

  endpoint :get_agency_info do |params|
    if config[:record_id]
      res = Document.find(config[:record_id]).agency_info
      {set_result: [res[:cms_cert_number], res[:branch_state], res[:branch_id]]}
    end
  end


  def deliver_component_endpoint(params)
    component_params = params[:component_params] || {}
    component_session[:values] = component_params["values"] if component_params["values"]
    component_session[:episode_id] = component_params["episode_id"] if component_params["episode_id"]
    component_params.merge!({"values" => component_session[:values], "episode_id" => component_session[:episode_id]}) if ((["hipps_grouper_chart"].
        include? params["name"]) or params["class_name"] == "GrouperExplorer")
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end

end
