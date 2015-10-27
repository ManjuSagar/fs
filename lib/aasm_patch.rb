module AASM
  class Base

    def state(name, options={})
      # @clazz.aasm_state(name, options)
      # In order to store previous status information in DB. In before exit callback of state set_previous_status method is added => start.
      before_exit_methods = options[:before_exit] ? [options[:before_exit], :set_previous_status].flatten : :set_previous_status
      options = options.merge({before_exit: before_exit_methods})
      # In order to store previous status information in DB. In before exit callback of state set_previous_status method is added => end.
      sm = AASM::StateMachine[@clazz]
      sm.create_state(name, options)
      sm.initial_state = name if options[:initial] || !sm.initial_state

      @clazz.send(:define_method, "#{name.to_s}?") do
        aasm_current_state == name
      end
    end

  end

  module SupportingClasses
    class Event

      def title
        @options[:title] || name.to_s.titleize
      end

      def transitions_from_any_state?
        @transitions.select{ |t| t.from.nil?}
      end

    end
  end

  def aasm_fire_event(name, options, *args)
    ActiveRecord::Base.transaction do
      if self.class.kind_of? ActiveRecord::Base
        even_name_with_class = "#{name.to_s}(#{self.class.name}_#{self.id})"
        if Thread.current[:events].empty?
          Thread.current[:events]["primary_event"] = even_name_with_class
        elsif Thread.current[:events]["#{self.class.name}_#{self.id}"].nil?
          Thread.current[:events]["#{self.class.name}_#{self.id}"] = even_name_with_class
        end
      end
      persist = options[:persist]

      event = self.class.aasm_events[name]
      begin
        old_state = aasm_state_object_for_state(aasm_current_state)


        old_state.fire_callbacks(:exit, self)

        # new event before callback
        event.fire_callbacks(:before, self)

        if new_state_name = event.fire(self, *args)
          new_state = aasm_state_object_for_state(new_state_name)

          # new before_ callbacks
          old_state.fire_callbacks(:before_exit, self)
          new_state.fire_callbacks(:before_enter, self)

          new_state.fire_callbacks(:enter, self)

          persist_successful = true
          if persist
            persist_successful = aasm_set_current_state_with_persistence(new_state_name)
            event.execute_success_callback(self) if persist_successful
          else
            self.aasm_current_state = new_state_name
          end

          if persist_successful
            old_state.fire_callbacks(:after_exit, self)
            new_state.fire_callbacks(:after_enter, self)
            event.fire_callbacks(:after, self)

            self.aasm_event_fired(name, old_state.name, self.aasm_current_state) if self.respond_to?(:aasm_event_fired)
          else
            self.aasm_event_failed(name, old_state.name) if self.respond_to?(:aasm_event_failed)
          end

          persist_successful

        else
          if self.respond_to?(:aasm_event_failed)
            self.aasm_event_failed(name, old_state.name)
          end

          if AASM::StateMachine[self.class].config.whiny_transitions
            raise AASM::InvalidTransition, "Event '#{event.name}' cannot transition from '#{self.aasm_current_state}'"
          else
            false
          end
        end
      rescue StandardError => e
        event.execute_error_callback(self, e)
      end
    end
  end

  def aasm_events_for_state(state)
    events = self.class.aasm_events.values.select {|event| event.transitions_from_state?(state) or event.transitions_from_any_state? }
    events.map {|event| event.name}
  end

  def events_for_current_state
    events = aasm_permissible_events_for_current_state.collect{|e| self.class.aasm_events.values.detect{|ev| ev.name == e }}
    events.select!{|ev| (ev.options[:hidden].nil? or ev.options[:hidden] == false) }
    events
  end

  # In order to store previous status information in DB. In before exit callback of state set_previous_status method is added => start.
  def set_previous_status
    return nil unless self.class.respond_to? :aasm_column
    column = "previous_#{self.class.aasm_column}="
    return if self.respond_to?(column) == false
    self.send(column, aasm_current_state)
  end
  # In order to store previous status information in DB. In before exit callback of state set_previous_status method is added => end.
end
