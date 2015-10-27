class ChangeStatusExportForTestToReadyForExport < ActiveRecord::Migration
  def change
    OasisExport.where(:export_status => "T").update_all(:export_status => "R")
  end
end
