class NoteForm < Mahaswami::Panel
  def configuration
    c = super
    c.merge(
        title: false,
        header: false,
        item_id: :notes_form,
        bbar: false,
        fbar: false,
        border: false,
        layout: :hbox,
        items: [
          {name: :notes, xtype: "textareafield", cols: 31, field_label: '', item_id: :notes_text},
          {
            xtype: 'toolbar',
            vertical: true,
            margin: "0 2 0 2",
            items: [:apply.action, :cancel.action],
          }
        ],
        strong_default_attrs: c[:strong_default_attrs]
    )
  end
  action :apply, text: "", icon: :save_new, tooltip: "Send"
  action :cancel, text: "", icon: :cancel_new, tooltip: "Reset"

  js_method :on_apply, <<-JS
    function(){
      var text = this.down("#notes_text");
      value = text.value;
      if (value == undefined || value.trim().length == 0){
        //Do Nothing
        text.setValue();
      } else {
        this.checkDocumentStatus({}, function(res){
          if(res){
            this.createDocumentNote(false);
          } else {
            Ext.MessageBox.confirm("Confirmation", "Editing this document will delete all field staff signature(s). The field staff(s) will need to re-sign"+
                                      " the document in order for the signature(s) to appear on the printed document. Do you still want to edit this document? "
                                                       , function(btn){
              if(btn == "yes"){
                this.createDocumentNote(true);
              } else {
                text.setValue();
              }
            }, this);
          }
        }, this);
      }
    }
  JS

  js_method :create_document_note,<<-JS
    function(refresh){
      var text = this.down("#notes_text");
      this.createRecord({notes: text.value},function(result){
          if(result){
            Ext.ComponentQuery.query('#notes_list')[0].store.load();
            if(refresh) Ext.ComponentQuery.query("#"+this.gridItemId)[0].store.load();
            text.setValue();
          }
       }, this);
    }
  JS

  js_method :on_cancel, <<-JS
    function(){
      var notes =  Ext.ComponentQuery.query('#notes_text')[0]
      notes.setValue();
    }
  JS

  endpoint :check_document_status do |params|
    doc = Document.find(config[:strong_default_attrs][:document_id])
    result = doc.is_not_correction_request?
    {set_result: result}
  end

  endpoint :create_record do  |params|
    res = DocumentNote.create(params.merge(config[:strong_default_attrs]))
    {set_result: res}
  end


end