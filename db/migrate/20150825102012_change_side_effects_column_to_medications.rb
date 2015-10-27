class ChangeSideEffectsColumnToMedications < ActiveRecord::Migration
	def change
  		change_column :treatment_medications, :potential_side_effects, :text
	end
end
