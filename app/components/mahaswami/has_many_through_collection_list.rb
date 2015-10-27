module Mahaswami
  class HasManyThroughCollectionList < GridPanel

    delegates_to_dsl :parent_model, :parent_id, :association

    def data_adapter
      parent_model_class = config[:parent_model].constantize
      parent_instance = parent_model_class.find(config[:parent_id])
      MyDataAdapter.new(data_class, parent_instance, config[:association])
    end

    def configuration
      super.tap do |c|
        parent_model_class = c[:parent_model].constantize
        assoc = parent_model_class.reflect_on_all_associations.find{|a| a.name == c[:association].to_sym}
        c[:model] = assoc.klass.name
        c[:title] = c[:association].capitalize
      end
    end
  end
end

class MyDataAdapter < Netzke::Basepack::DataAdapters::ActiveRecordAdapter
  def initialize(data_class, parent_instance, association_name)
    super(data_class)
    @parent_instance = parent_instance
    @association_name = association_name
  end

  def get_relation(params = {})
    @arel = @model_class.arel_table

    relation = @parent_instance.send(@association_name.to_sym).scoped #@model_class.scoped

    relation = apply_column_filters(relation, params[:filter]) if params[:filter]

    if params[:extra_conditions]
      extra_conditions = normalize_extra_conditions(ActiveSupport::JSON.decode(params[:extra_conditions]))
      relation = relation.extend_with_netzke_conditions(extra_conditions) if params[:extra_conditions]
    end

    query = params[:query] && ActiveSupport::JSON.decode(params[:query])

    if query.present?
      # array of arrays of conditions that should be joined by OR
      and_predicates = query.map do |conditions|
        predicates_for_and_conditions(conditions)
      end

      # join them by OR
      predicates = and_predicates[1..-1].inject(and_predicates.first){ |r,c| r.or(c) }
    end

    relation = relation.where(predicates)

    relation = relation.extend_with(params[:scope]) if params[:scope]

    relation
  end
end
