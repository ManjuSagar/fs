class Ethnicities < ActiveRecord::Migration
  def up
    create_table :ethnicities, {id: false, force: true} do |t|
      t.string :id, :limit => 2, :null => false
      t.string :description, :limit => 100
    end

    create_table :payment_sources, {id: false, :force => true} do |t|
      t.string :id, :limit => 2, :null => false
      t.string :description, :limit => 100
    end
    execute ("alter table ethnicities add constraint ethnicities_pkey primary key(id)")
    execute ("alter table payment_sources add constraint payment_sources_pkey primary key(id)")
  end

  def down
  end
end
