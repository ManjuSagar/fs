class ChangePointOfOriginLengthSizeInTrequest < ActiveRecord::Migration
  def change
    change_column :treatment_requests, :point_of_origin, :string, limit: 2
  end
end
