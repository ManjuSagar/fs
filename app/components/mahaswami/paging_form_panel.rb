module Mahaswami
  class PagingFormPanel < Netzke::Basepack::PagingFormPanel
    include FormPanelBase
    def record
      p = {:limit => 1}
      p[:scope] = config[:scope]
      @record ||= data_adapter.get_records(p).first
    end

    endpoint :get_data do |params|
      params[:scope] = config[:scope]
      @record = data_adapter.get_records(params).first
      record_hash = @record && js_record_data
      {:records => record_hash && [record_hash] || [], :total => total_records(params)}
    end

    action :apply, icon: false

    def netzke_submit(params)
      data = ActiveSupport::JSON.decode(params[:data])
      data.each_pair do |k,v|
        data[k]=nil if v.blank? || v == "null" # Ext JS returns "null" on empty date fields, or "" for not filled optional integer fields, which gives errors when passed to model (at least in DataMapper)
      end

      # File uploads are in raw params instead of "data" hash, so, mix them in into "data"
      if config[:file_upload]
        Netzke::Core.controller.params.each_pair do |k,v|
          data[k] = v if v.is_a?(ActionDispatch::Http::UploadedFile)
        end
      end

      success = create_or_update_record(data)

      if success
        res = {:set_form_values => js_record_data}
        res.merge((data.keys.include?('password') and data['password'].present?) ? {:reload_page => true} : {:set_result => true})
      else
        # flash eventual errors
        data_adapter.errors_array(@record).each do |error|
          flash :error => error
        end
        {:netzke_feedback => @flash, :apply_form_errors => build_form_errors(record)}
      end
    end

    js_method :reload_page, <<-JS
      function(){
        Ext.MessageBox.alert("Status", "You have changed the login password. You will now be redirected to Sign-in page.", function(){
          window.location.reload();
        }, this);
      }
    JS

    js_method :init_component,<<-JS
      function(){
        this.callParent();
        this.netzkeLoad(this.record); //In ExtJS 4.2 is not loading record. So we manually triggering netzke load endpoint.
      }
    JS

    protected

    def total_records(params = {})
      params[:scope] = config[:scope]
      @total_records ||= data_adapter.count_records(params, [])
    end


  end
end