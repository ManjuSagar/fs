class RenameCretorSignRequiredToFsSignRequired < ActiveRecord::Migration
  def change
    rename_column :documents, :creator_sign_required, :fs_sign_required
  end
  
end
