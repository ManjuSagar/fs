class AddColumnsCreatedAtAndUpdatedAtToAllTables < ActiveRecord::Migration
  def change
    all_tables = ActiveRecord::Base.connection.tables - ["schema_migrations"];
    all_tables.each {|table|
      add_column table.to_sym, :created_at, :datetime unless ActiveRecord::Base.connection.column_exists?(table.to_sym, :created_at)
      add_column table.to_sym, :updated_at, :datetime unless ActiveRecord::Base.connection.column_exists?(table.to_sym, :updated_at)
    }
  end
end
