class Icd9ToIcd10Transition < Mahaswami::FormPanel
  include ButtonsOfOasisHeader

  def configuration
    s = super
    @editable = false
    if s[:doc_id]
      component_session[:doc_id] = s[:doc_id]
      doc = Document.org_scope.where(id: s[:doc_id]).first
      inv = Invoice.org_scope.where(id: s[:invoice_id]).first
      model = doc.document_type
      info_date = Date.strptime(doc.m0090_info_completed_dt, '%m/%d/%Y')
      @editable = (doc and doc.treatment_episode.start_date <= Date.parse('01-10-2015') and info_date > Date.parse('01-10-2015') and
          inv.rap?)
    end
    s.merge(
        model: "Document",
        title: false,
        header: false,
        auto_scroll: true,
        model: model,
        item_id: 'icd9_to_icd_10_transition',
        record_id: s[:doc_id],
        freeFormTemplate: true,
        bbar: ['->',:ok.action, :cancel.action ],
        items: [
         {
           xtype: "panel",
           border: false,
           margin: 5,
           layout: "hbox",
           items: [
             {
               xtype: "panel",
               border: false,
               flex: 1,
               items: [
                 {
                   xtype: 'label',
                   html: '<b>For Start of Care from 3rd August to 1st October, as per CMS instructions ICD-10 codes are mandatory in Claim. Please enter the relevent codes.</b>',
                 },
                 {
                   xtype: 'panel',
                   layout: 'column',
                   margin: '20 0 0 40',
                   border: false,
                   items: [
                    {
                       xtype: "panel",
                       columnWidth: '.50',
                       border: false,
                       items:[{
                         xtype: 'label',
                         margin: "50,0,0,0",
                         text: "ICD 9 Code",
                       }]+icd9_items
                    },
                    {
                       xtype: "panel",
                       columnWidth: '.50',
                       border: false,
                       items:[{
                       text: "ICD 10 Code",
                       xtype: 'label',
                       margin: "50,0,0,0",
                    }]+ icd10_items
                    }

                   ]
                 }
               ]
             }
          ]
         }
        ]
    )
  end

  def icd9_items
    doc = Document.find(component_session[:doc_id])
    icd_codes = []
    icd_codes << doc.m1020_primary_diag_icd
    icd_codes << doc.m1022_oth_diag1_icd
    icd_codes << doc.m1022_oth_diag2_icd
    icd_codes << doc.m1022_oth_diag3_icd
    icd_codes << doc.m1022_oth_diag4_icd
    icd_codes << doc.m1022_oth_diag5_icd
    icd_9_labels = ["m1020_primary_diag_icd", "m1022_oth_diag1_icd","m1022_oth_diag2_icd","m1022_oth_diag3_icd","m1022_oth_diag4_icd",
                    "m1022_oth_diag5_icd"]
    icd9_labels = ["M1020 Primary Diagnosis","M1022 Other Diagnosis1", "M1022 Other Diagnosis2", "M1022 Other Diagnosis3",
                   "M1022 Other Diagnosis4", "M1022 Other Diagnosis5"]

    final_list = []
    icd_codes.each_with_index do |value, index|
      list =
        {
          xtype: 'netzkeremotecombo',
          parent_id: self.global_id,
          name: icd_9_labels[index],
          labelAlign: 'top',
          field_label: icd9_labels[index],
          margin: "20,0,0,0",
          flex: 1,
          read_only: (not @editable),
          width: '161px'
        }
      final_list << list
    end
    final_list
  end

  def icd10_items
    icd_10_labels = ["m1021_primary_diag_icd","m1023_oth_diag1_icd","m1023_oth_diag2_icd","m1023_oth_diag3_icd","m1023_oth_diag4_icd",
                     "m1023_oth_diag5_icd"]
    icd10_labels = ["M1021 Primary Diagnosis","M1023 Other Diagnosis1", "M1023 Other Diagnosis2", "M1023 Other Diagnosis3",
                   "M1023 Other Diagnosis4", "M1023 Other Diagnosis5"]
    final_list = []
    icd_10_labels.each_with_index do |value, index|
      list =
        {
          xtype: 'netzkeremotecombo',
          parent_id: self.global_id,
          name: icd_10_labels[index],
          labelAlign: 'top',
          field_label: icd10_labels[index],
          margin: "20,0,0,0",
          flex: 1,
          read_only: (@editable),
          width: '161px',
        }
      final_list << list
    end
    final_list
  end

  action :ok, text: "", tooltip: "Ok", icon: :save_new, item_id: :icd9_to_icd10_ok
  action :cancel, text: "", tooltip: "Cancel", icon: :cancel_new

  js_method :on_cancel, <<-JS
      function(){
        this.up('window').close();
      }
  JS

  js_method :on_ok, <<-JS
    function(){
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      var f = this;
      //this.freeFormTemplateWindowEvents(f);
      var comboBoxes = this.query("netzkeremotecombo");
      this.setLoading(true);
      Ext.each(comboBoxes, function(comboField, index){
        comboField.triggerAction = 'query';
        if(comboField.value){
          comboField.store.load({params: {query: comboField.value}});
          comboField.setValue(comboField.value);
        }
    }, this);
    this.setLoading(false);
    var gem = Ext.ComponentQuery.query('#gem')[0];
    if(gem){
       this.getDocumentId({}, function(res){
         this.displayGemWindow(gem, this, res);
       })
     }
    var window = gem.up('window');
    window.on('close', function(){
      var w = Ext.ComponentQuery.query('#gem_window')[0];
      if(w){
        w.close();
      }
    });
    }
  JS

  endpoint :get_document_id do |params|
    {set_result: component_session[:doc_id]}
  end


  def get_combobox_options_endpoint(params)
    OasisEvaluation.netzke_combo_options_for(params[:column], {query: params["query"]})
  end

  component :icd_gem do
    {
        class_name: "Icd9to10Gem",
        grid_item_id: config[:grid_item_id]
    }
  end

end


