class AddStateMachineIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :state_machine_id, :string
  end
end
