class Documents::Oasis::EliminationPoc < Mahaswami::SubPanel

  def configuration
    s = super
    s.merge(
        layout: "fit",
        items: [
            {
                xtype: "tabpanel",
                activeTab: 0,
                plain: true,
                deferredRender: false,
                items: [
                    :genitourinary.component,
                    :dme_supplies.component,
                    :nutritional_status.component,
                    :enteral_feedings.component,
                    :abdomen.component,
                    :elimination.component,
                    :genitalia.component,

                ]
            }
        ]
    )
  end

  component :genitourinary do
    {
        class_name: "Documents::Oasis::Genitourinary",
        title: "Genitourinary",
        item_id: :genitourinary_panel
    }
  end

  component :dme_supplies do
    {
        class_name: "Mahaswami::SubPanel",
        title: "DME Supplies",
        item_id: :dme_supplies_panel,
        autoScroll: true,
        layout: :vbox,
        margin: 5,
        items: [
            {
                border: false,
                header: false,
                layout: :hbox,
                items: [
                    {
                        class_name: "Documents::Oasis::UrinaryDMESupplies",
                        flex: 1
                    },{
                        class_name: "Documents::Oasis::Miscellaneous",
                        flex: 1
                    },{
                        class_name: "Documents::Oasis::FoleySupplies",
                        flex: 1
                    }
                ]

            }
        ]
    }
  end

  component :nutritional_status do
    {
        class_name: "Documents::Oasis::NutritionalStatus",
        title: "Nutritional Status",
        item_id: :nutritional_status_panel
    }
  end

  component :enteral_feedings do
    {
        class_name: "Documents::Oasis::EnteralFeedings",
        title: "Enteral Feedings",
        item_id: :enteral_feedings_panel,
        margin: 5
    }
  end

  component :elimination do
    {
        class_name: "Documents::Oasis::Elimination",
        title: "Elimination",
        item_id: :elimination_panel
    }
  end

  component :abdomen do
    {
        class_name: "Documents::Oasis::Abdomen",
        title: "Abdomen",
        item_id: :abdomen_panel
    }
  end

  component :genitalia do
    {
        class_name: "Documents::Oasis::Genitalia",
        title: "Genitalia",
        item_id: :genitalia_panel
    }
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      var noProblems = this.query("[boxLabel=<b>No Problem</b>]");
      Ext.each(noProblems, function(noProblem){
        noProblem.on("change", function(ele){
          var res = noProblem.name.split("_");
          res.pop();
          res.pop();
          var panel = ele.up("#" + res.join("_") + "_panel");
          var fields = panel.query("textfield, textarea, datefield, numberfield, checkboxgroup, radiogroup, checkboxfield, radiofield");
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
        }, this);
      }, this);
    }
  JS

end