class Documents::Oasis::Infusion < Mahaswami::SubPanel
  def configuration
    super.merge(
        autoScroll: true,
        border: 0,
        items: [
            {
                xtype: "medicationsPocInfusion"
            }
        ]
    )

  end
  js_method :after_render,<<-JS
    function(){
      this.callParent();
      var noProblem = this.query("[boxLabel=<b>N/A</b>]")[0];
      noProblem.on("change", function(ele){
        var fields = this.query("textfield, textareafield, datefield, numberfield,  radiogroup, checkboxfield, radiofield");
        Ext.each(fields, function(e){
            if(noProblem != e && noProblem.checked == true){
              if(e.xtype == "radiofield" || e.xtype == "checkboxfield"){
                e.disable().setValue(false);
              } else {
                e.disable().setValue();
              }
            } else {
              e.enable();
            }
          }, this);
      },this)

    }
  JS
end