module ButtonsOfOasisHeader

  def self.included(klass)
    klass.class_eval do
      def view_and_order_buttons
        {
          titlePosition: 0,
          items: [gem_button("gem"), medications_button('view_medications'),order_button('view_orders')] + correction_request_button('correction_request')
        }
      end

      def medications_button(item_id)
       {
         xtype:'button',
         text: "View Medications",
         item_id: "#{item_id}",
         margin: '0 5 0 0'
       }
      end

      def order_button(item_id)
       {
        xtype:'button',
        text: "View Orders",
        margin: '0 5 0 0',
        item_id: "#{item_id}"
       }
      end

      def gem_button(item_id)
        {
            xtype: 'button',
            text: "GEM",
            margin: '0 5 0 0',
            hidden: show_gem,
            item_id: "#{item_id}"
        }
      end

      def correction_request_button(item_id)
        record_id_present = component_session[:r_id].present? || component_session[:doc_id].present?
       (record_id_present ? [{
                                              xtype:'button',
                                              text: "Correction request",
                                              margin: '0 5 0 0',
                                              item_id: "#{item_id}",
                                             }] : [])
      end

      def show_gem
        res = true
        definition_id = (component_session[:document_definition_id] || component_session[:doc_def_id] || component_session[:ddid])
        if definition_id.present?
         doc_def =  DocumentDefinition.find(definition_id)
         res = doc_def.document_form_template.document_class_name.start_with?('PlanOfCareForm','OasisResumptionOfCareForm','OasisEvalForm',
                                                                              'OasisRecertificationForm','OasisOtherFollowupForm')
        end
        !res
      end


   js_method :on_medications_click,<<JS
      function(){
        var w = new Ext.window.Window({
          height: '80%',
          width: '80%',
          layout: 'fit',
          title: 'Active Medications',
          header: {titlePosition: 0,items: [{type: 'refresh', item_id: 'medications_refresh_button'}]},
          modal: true,
          buttons: [
            {
              text: "",
              tooltip: "Cancel",
              iconCls: "cancel_icon",
              listeners: {
                click: function(){
                  w.close();
                }
              }
            }
          ]
        });
       w.show();
       this.loadNetzkeComponent({name: "medications_component", params: {}, container: w, callback: function(){
         w.show();
       }});
      }
JS

   js_method :on_view_orders,<<-JS
      function(){
        var w = new Ext.window.Window({
        width: '60%',
        height: '60%',
        bbar: false,
        title: "Medical Orders",
        fbar: false,
        border: false,
        layout:'fit',
        modal: true,
        buttons: [
            {
                text: "",
                tooltip: "Cancel",
                iconCls: "cancel_icon",
                listeners: {
                    click: function () {
                        w.close();
                    }
                }
            }
        ]
        });
        w.show();
        this.loadNetzkeComponent({name: "medical_orders", container:w, callback: function(w){
          w.show();
        }});
      }
   JS

      js_method :display_gem_window,<<-JS
        function(gem, grid, id){
            gem.on('click', function(){
                var w = new Ext.window.Window({
                    width: 500,
                    height: 350,
                    bbar: false,
                    fbar: false,
                    modal: true,
                    border: false,
                    layout:'fit',
                    title: "ICD 9 to 10 CM General Equivalence Mapping",
                    itemId: 'gem_window',
                    buttons: false,
                    modal: false,
                    alwaysOnTop: true
                });
                w.show();
                var width = Ext.getBody().getViewSize().width;
                w.setPosition((width-580),80);
                grid.loadNetzkeComponent({name: "icd_gem", params: {component_params: {document_id: id}}, container:w, callback: function(w){
                    w.show();
                }});
            },grid);
        }
      JS

      component :medications_component do
        {
            class_name: 'MedicationsList',
            lazy_loading: true,
            treatment_id: component_session[:ti] || component_session[:treatment_id],
            header: false,
            item_id: 'medications_window',
        }
      end
    end
  end
end
