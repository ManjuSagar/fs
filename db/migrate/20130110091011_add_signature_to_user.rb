class AddSignatureToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.has_attached_file :signature
    end
  end
end
