class NineDigitZipCode <  Mahaswami::Panel
  def configuration
   c = super
    org_type = c[:org_type]
   c.merge(
        layout: :hbox,
        orgType: org_type,
        items: [
            {
                xtype: 'textfield',
                fieldLabel: 'Zip Code',
                name: "zip_code",
                margin: '0 2 0 0',
                item_id: :zip_code_agency,
                width: 245
            },
            {
                xtype: 'textfield',
                fieldLabel: 'Zip Code',
                name: "zip_code_part2",
                field_label: ' _',
                labelSeparator: '',
                label_width: 3,
                width: 70,
                item_id: :zip_code_part2

            },

               ]
   )
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      var agency = Ext.ComponentQuery.query("#org_types")[0];
      var agencyZipCode = Ext.ComponentQuery.query("#zip_code_agency")[0];
      var zipCodePart2 = Ext.ComponentQuery.query("#zip_code_part2")[0];
        if (this.orgType == 'StaffingCompany'){
             this.hideZipCodePart2(zipCodePart2,agencyZipCode);
          }else{
             this.showZipCodePart2(zipCodePart2,agencyZipCode);
           }
        agency.on('select', function(){
          if (agency.value=='StaffingCompany'){
           this.hideZipCodePart2(zipCodePart2,agencyZipCode);
          }else{
            this.showZipCodePart2(zipCodePart2,agencyZipCode);
           }
        },this);
    }
  JS

  js_method :hide_zip_code_part2, <<JS
    function(zipCodePart2,agencyZipCode){
      zipCodePart2.hide();
      agencyZipCode.setWidth(317);
    }
JS

  js_method :show_zip_code_part2, <<JS
    function(zipCodePart2,agencyZipCode){
      zipCodePart2.show();
      agencyZipCode.setWidth(245);
      agencyZipCode.show();
  }
JS

end