class ContactTypeList < ActiveRecord::Migration
  def up
    change_column :contact_types, :type_name, :string, :limit => 50, :null => false
    ContactType.create(:type_name => "Authorized Representative")
    ContactType.create(:type_name => "Director of Patient Care Services Contact")
    ContactType.create(:type_name => "Staffing Contact")
    ContactType.create(:type_name => "HR Contact")
    ContactType.create(:type_name => "Financial Contact")
  end

  def down
  end
end
