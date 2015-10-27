class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.string :zipcode

      t.timestamps
    end
  end
end
