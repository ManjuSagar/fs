class AddActiveStatusToConsultingCompany < ActiveRecord::Migration
  def change
    add_column :orgs, :active, :boolean, :default => true
  end
end
