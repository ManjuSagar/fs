class TreatmentAttachmentForm < Mahaswami::FormPanel

  def configuration
    s = super
    s.merge(
    model: "TreatmentAttachment",
    file_upload: true,
    items:[
        {name: :attachment_date, field_label: "Date", manually_required: true, item_id: :attachment_date},
        {name: :attachment_type__attachment_description, field_label: "Type", manually_required: true, item_id: :attachment_type},
        {name: :attachment, field_label: "Select File", xtype: 'fileuploadfield', getter: lambda {|r| ""}, display_only: true, manually_required: true},
    ]
    )
  end
  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var date = this.down("#attachment_date");
      date.on('select', function(el){
         this.setDate({attachment_date: date.value});
      },this);
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      date = this.down("#attachment_date");
      if(date.value)
        this.setDate({attachment_date: date.value});
    }
  JS

  endpoint :set_date do |params|
    component_session[:attachment_date] = params[:attachment_date].to_date if params[:attachment_date]
    {refresh_combo_store: :attachment_type}
  end

  def attachment_type__attachment_description_combobox_options(params)
    unless component_session[:attachment_date].nil?
      values = AttachmentType.active_scope(component_session[:attachment_date]).collect{|x| [x.id, x.attachment_description]}
    else
      values = AttachmentType.all.collect{|x| [x.id, x.attachment_description]}
    end
    {:data => values}
  end

end