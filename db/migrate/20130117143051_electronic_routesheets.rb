class ElectronicRoutesheets < ActiveRecord::Migration
  def change
    create_table :electronic_routesheets do |t|
      t.integer :visit_id, :null => false
      t.string :location_latitude
      t.string :location_longitude
      t.attachment :signature
      t.date :visit_date
      t.string :status, :limit => 2, :null => false
      t.timestamps
    end
  end
end
