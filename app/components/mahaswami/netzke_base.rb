module Mahaswami
  module NetzkeBase
    def self.included(klass)
      klass.class_eval {include ActionView::Helpers::JavaScriptHelper}
      klass.class_eval {include ActionView::Helpers::TagHelper}
      klass.class_eval {include ActionView::Helpers::UrlHelper}
      klass.class_eval {plugin :unload_component_plugin}
    end
    def action_column(grid_component_name = nil, width = nil)
      comp_name = grid_component_name || self.class.name.underscore
      {name: :actions, label: "", editable: false,
       :getter => lambda {|x| x.events_for_current_state.collect{|r|
         link_to_function(human_action_name(r), perform_event(comp_name, x, r), {id: "record_#{x.id}"})}.join(" | ")
       }
      }.merge(width.nil? ? {flex: 1} : {width: width})
    end

    def human_action_name(event)
      event.title
    end

    def perform_event(comp_name, record, event)
      "Ext.ComponentQuery.query('##{comp_name}')[0].performAction(#{record.id}, '#{event.name}');"
    end

    def deliver_component_endpoint(params)
      component_params = params[:component_params] || {}
      new_params = js_hash_to_ruby_hash(component_params)
      components[params[:name].to_sym].merge!(new_params)
      super
    end
  end
end