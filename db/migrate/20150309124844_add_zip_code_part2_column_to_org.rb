class AddZipCodePart2ColumnToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :zip_code_part2, :string, limit: 4
  end
end
