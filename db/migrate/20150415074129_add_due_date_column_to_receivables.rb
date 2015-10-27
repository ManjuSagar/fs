class AddDueDateColumnToReceivables < ActiveRecord::Migration
  def change
    add_column :receivables, :due_date, :date
  end
end
