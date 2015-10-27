module Mahaswami
  class HasManyCollectionList < GridPanel

    delegates_to_dsl :parent_model, :parent_id, :association

    def initialize(conf = {}, parent = nil)
      super
    end

    def configuration
      super.tap do |c|
          component_session[:parent_id] = c[:parent_id] if c[:parent_id]
          parent_model_class = c[:parent_model].constantize
          assoc = parent_model_class.reflect_on_all_associations.find{|a| a.name == c[:association].to_sym}
          c[:model] = assoc.klass.name
          c[:title] = c[:title] || c[:association].titleize
          custom_scope = c[:scope] || {}
          if custom_scope.is_a? Hash
            c[:scope] = {assoc.foreign_key.to_sym => component_session[:parent_id]}.merge(custom_scope)
          elsif custom_scope.is_a? Array
            c[:scope] = ["#{assoc.foreign_key} = ? and #{custom_scope.first}"] + [component_session[:parent_id]] + custom_scope[1..(custom_scope.size-1)]
          elsif custom_scope.is_a? String and custom_scope.blank? == false
            c[:scope] = ["#{assoc.foreign_key} = #{component_session[:parent_id]}", custom_scope].join(" AND ")
          end
          c[:strong_default_attrs] = {assoc.foreign_key.to_sym => component_session[:parent_id]}.merge(c[:strong_default_attrs] || {})
      end
    end
  end
end
