module Mahaswami
  class HasAndBelongsToManyInput < Netzke::Base
    js_base_class "Ext.form.CheckboxGroup"
    include NetzkeBase

    delegates_to_dsl :association, :scope, :record

    js_method :init_component, <<-JS
      function() {
        this.callParent();
      }
    JS

    def configuration
      super.tap do |c|
        assoc_name = c[:association].to_sym
        read_only = c[:read_only] || false
        record = c[:record]
        if record
          assoc = record.class.reflect_on_all_associations.find{|a| a.name == assoc_name}
          singular_assoc_name = assoc_name.to_s.singularize
          assoc_ids = record.send("#{singular_assoc_name}_ids".to_sym)
          assoc_ids = (assoc_ids + c[:assoc_ids]).uniq if c[:assoc_ids]
          items = c[:assoc_records] ? c[:assoc_records] : assoc.klass.send(c[:scope] || :all)
          c[:field_label] ||= assoc_name.to_s.titleize
          c[:columns] ||= 4
          c[:items] = items.collect{|i|
            {box_label: i.to_s, name: "#{singular_assoc_name}_ids", read_only: read_only, field_label: '', xtype: :checkbox, input_value: i.id,
             checked: (assoc_ids.include?(i.id))}
          }
        end
        c
      end
    end

  end
end