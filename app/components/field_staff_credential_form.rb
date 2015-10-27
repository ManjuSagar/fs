class FieldStaffCredentialForm < Mahaswami::FormPanel
  # To change this template use File | Settings | File Templates.
  def configuration
    c = super
    component_session[:field_staff_id] ||= c[:field_staff_id]
    c.merge(
        model: "FieldStaffCredential",
        file_upload: true,
        items: [
            {name: :field_staff_credential_type__ct_description, field_label: "Credential Type", editable: false, itemId: "c_type", read_only: (c[:mode] == :edit)},
            {name: :expiry_date, field_label: "Expiration Date", itemId: "expiry_date"},
            {name: :attachment, field_label: " Credential File",
             xtype: 'filefield', item_id: 'file_upload',
             getter: lambda {|r| ""}, display_only: true,
            },
            {name: :comments, field_label: "Comments", xtype: "textarea"}
        ],
        scope: :field_staff_scope,

    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('afterrender', function(){
      var type = Ext.ComponentQuery.query("#c_type")[0];
      type.on('change', function(){
       this.checkExpiryDateFlag({c_type_value: type.value});
      }, this);
      if (this.record.id){
        var date_field = Ext.ComponentQuery.query("#expiry_date")[0];
        if (this.record.expiry_date){
          date_field.show();
        }else{
          date_field.hide();
        }
      }
    });
    }

  JS

  js_method :on_apply, <<-JS
    function(){
      var file = Ext.ComponentQuery.query('#file_upload')[0];
      if (!this.validateFileExtension(file.value)) {
        Ext.MessageBox.alert('Change File', 'Only image and pdf formats are accepted.');
        return;
      }
    this.callParent();
    }
  JS

  js_method :validate_file_extension, <<-JS
    function(fileName){
      var exp = /^.*.(jpg|JPG|png|PNG|tif|TIF|jpeg|JPEG|gif|GIF|pdf)$/;
                       return exp.test(fileName);
    }
  JS

  endpoint :check_expiry_date_flag do |params|
    expiry_flag = FieldStaffCredentialType.find(params[:c_type_value]).expiry_flag
    {:enable_date_field => [expiry_flag]}
  end

  js_method :enable_date_field, <<-JS
    function(args){
      var date_field = Ext.ComponentQuery.query("#expiry_date")[0];
      if(args[0] == true){
        date_field.show();
      }else{
        date_field.hide();
      }
    }
  JS

  def field_staff_credential_type__ct_description_combobox_options(params)
    values = []
    if component_session[:field_staff_id]
      discipline = User.find(component_session[:field_staff_id]).license_type.discipline
      values = FieldStaffCredentialType.where("discipline_id = #{discipline.id} or discipline_id is null")
      values.collect!{|x| [x.id, x.ct_description]}
    end
    {:data => values}
  end

end