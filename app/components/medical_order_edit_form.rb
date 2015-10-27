class MedicalOrderEditForm < MedicalOrderAddForm

  def initialize(conf = {}, parent_id = nil)
    super
    component_session[:treatment_id] ||= config[:parent_id]
  end

  def configuration
    c = super
    component_session[:mo_id] =  c[:record_id]
    mo = MedicalOrder.find(component_session[:mo_id]) if component_session[:mo_id]
    c.merge(
      signDateAndPasswordRequired: false,
      model: "MedicalOrder",
      item_id: 'md_order',
      read_only: (mo ? (not mo.draft?) : false),
      show_print_icon_on_edit_form: true,
      items: [
        {name: :treatment_episode__certification_period, field_label: "Episode", item_id: :episode_id, scope: :org_scope},
        {name: :order_date, field_label: "Order Date", item_id: :order_date},
        {name: :order_type__type_description, field_label: "Order Type", item_id: :order_type_id},
        {name: :physician__full_name, field_label: "Physician", item_id: :physician_id},
        {name: :field_staff__full_name, field_label: "Field Staff", item_id: :field_staff_id},
        {name: :order_content, field_label: "Order Content", enableKeyEvents: true,rows: 20, item_id: :order_content},
        :medical_order_document_attachments.component
      ],
    )

  end

  component :medical_order_document_attachments do
    {
        class_name: "MedicalOrderDocumentAttachments",
        association: "attached_docs",
        parent_model: "MedicalOrder",
        title: "Document Attachments",
        parent_id: config[:record_id],
        height: 300,
    }
  end

  js_method :on_print,<<-JS
    function(){
      this.getMedicalOrderFileUrl({record_id: this.record.id}, function(url){
          if(url)
            this.launchMedicalOrderReport(url);
          else
            Ext.MessageBox.alert("Alert", "Order not yet signed.");
        }, this);
      }
  JS

  endpoint :get_medical_order_file_url do |params|
    org = PatientTreatment.find(component_session[:treatment_id]).agency
    mo = MedicalOrder.org_scope(org).find(params[:record_id])
    res = mo.printable_order? ? mo.printable_order.url : false
    {set_result: res}
  end

  js_method :launch_medical_order_report, <<-JS
    function(url) {
      var reportUrl = url;
      reportUrl = window.location.protocol + "//" + window.location.host + url;
      var reportTitle = "Medical Order";
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
                id: 'myIframe',
                autoEl : {
                    tag : "iframe",
                    href : ""
                }
            }]
        }).show();
        Ext.getDom('myIframe').src = reportUrl
      }
    }
  JS
end