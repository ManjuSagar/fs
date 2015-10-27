class ConvertDateTimeFieldsToDate < ActiveRecord::Migration
  def change
    change_column :treatment_requests, :request_date, :date
    change_column :communication_notes, :note_date_time, :date
  end
end
