class AddLockVersionToAllTables < ActiveRecord::Migration
  def change
    exclude_tables =  ["schema_migrations", "netzke_component_states"]
    ActiveRecord::Base.connection.tables.each do |table_name|
      unless exclude_tables.include?(table_name)
        add_column table_name.to_sym, :lock_version, :integer, :default => 0
      end
    end
  end
end
