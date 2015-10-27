class AddTreatmentEpisodeToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :treatment_episode_id, :integer
    Invoice.update_all(:treatment_episode_id => "-1")
    change_column :invoices, :treatment_episode_id, :integer, :null => false
  end
end
