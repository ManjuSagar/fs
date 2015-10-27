class AddConsistencyAndApplicableConditionExpressionColumnToOasisFieldSpecs < ActiveRecord::Migration
  def change
    add_column :oasis_field_specs, :consistency, :text
    add_column :oasis_field_specs, :applicable_condition_expression, :text
  end
end
