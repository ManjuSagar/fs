class PatientWindow < Netzke::Basepack::Window
  include Mahaswami::NetzkeBase

  def configuration
    c = super
    @conf_params = c[:params] || {}
    unless c[:type]
      component_session[:treatment_id] ||= c[:treatment_id]
      component_session[:treatment_request_id] ||= c[:treatment_request_id]
      # Security purpose
      if component_session[:treatment_request_id]
        TreatmentRequest.user_scope.find(component_session[:treatment_request_id])
      else
        PatientTreatment.user_scope.find(component_session[:treatment_id])
      end
      component_session[:component_class_name] ||= c[:component_class_name]
      if (c[:component_class_name] and c[:component_class_name].constantize.ancestors.include? Mahaswami::FormPanel)
        c[:type] = :form
      end
    end
    c.merge(
        {
            layout:'border',
            items: [:patient_container.component,
                    {region: :center,
                     header: false,
                     class_name: component_session[:component_class_name] || "TreatmentVisits",
                     parent_id: component_session[:treatment_id],
                     treatment_id: component_session[:treatment_id]
                    }.merge(@conf_params)
            ],
            fbar: (c[:type] == :form ?[:ok.action, :cancel.action] : [:close.action]),
            title: c[:title] || "Patient Details"
        }
    )
  end

  js_properties :button_align => :right

  action :close do
    { :text => "Close"}
  end

  action :ok do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save_new}
  end

  action :cancel do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.cancel'), icon: :cancel_new}
  end

  js_method :init_component, <<-JS
      function(params){
        this.callParent();
        if (this.type == 'form')
          this.items.last().on("submitsuccess", function(){ this.closeRes = "ok"; this.close(); }, this);
        this.setTitle(this.items.get(1).title);
        this.show();
        this.down("tool").handler = function(){};
        this.down("tool").on('click', function(){
          this.onClose();
        }, this);
      }
  JS

  js_method :on_close, <<-JS
      function(params){
        this.refreshGrid();
        this.close();
      }
  JS

  js_method :refresh_grid,<<-JS
    function() {
      if(this.gridItemId){
        Ext.ComponentQuery.query('#'+this.gridItemId)[0].store.load();
      }
    }
  JS

  js_method :on_cancel, <<-JS
      function(params){
        this.refreshGrid();
        this.close();
      }
  JS

  js_method :on_ok, <<-JS
      function(params){
        var windowScope = this;
        this.items.last().onApply();
        this.items.last().on("submitsuccess", function(){
          windowScope.refreshGrid();
        }, this);
      }
  JS

  component :patient_container do
    {
        class_name: "Netzke::Basepack::Panel",
        region: :north,
        layout: :fit,
        header: false,
        items: [
            {class_name: "PatientInfo",
             treatment_id: component_session[:treatment_id],
             treatment_request_id: component_session[:treatment_request_id],
             margin: 10,
             frame: false,
             header: false,
             border: false
            }.merge(@conf_params.merge({item_id: :patient_info}))
        ]
    }
  end

end