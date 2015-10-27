module Mahaswami
  class ConfigurableRecordFormWindow < Netzke::Basepack::Window
  
    def configure
      super.tap do |c|
        c[:width] = 400
        c[:auto_height] = true
        c[:collapsible] = true
      end
    end

    js_properties :button_align => :right,
                  :modal => true,
                  :fbar => [:ok.action, :cancel.action],
                  :collapsible => true

    action :ok do
      { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save}
    end

    action :cancel do
      { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.cancel'), tooltip: "Cancel", icon: :cancel_new}
    end

    js_method :init_component, <<-JS
      function(params){
        this.callParent();
        this.items.first().on("submitsuccess", function(){ this.closeRes = "ok"; this.close(); }, this);
      }
    JS

    js_method :on_ok, <<-JS
      function(params){
        this.items.first().onApply();
      }
    JS

    js_method :on_cancel, <<-JS
      function(params){
        this.close();
      }
    JS
  end
end
