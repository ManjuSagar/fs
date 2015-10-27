class AddCheckBoxFieldsToAuthorizationTrackings < ActiveRecord::Migration
  def change
    add_column :authorization_trackings, :reported, :boolean, default: false
    add_column :authorization_trackings, :evaluation_sent, :boolean, default: false
    add_column :authorization_trackings, :approval_received, :boolean, default: false
    add_column :authorization_trackings, :visit_done, :boolean, default: false
  end
end
