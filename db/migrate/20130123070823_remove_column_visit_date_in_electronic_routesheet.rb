class RemoveColumnVisitDateInElectronicRoutesheet < ActiveRecord::Migration

  def change
  ElectronicRoutesheet.where({:signature_file_name => nil}).update_all(:signature_file_name => 'signature20130122-7898-1pxb3hq.png', :signature_content_type => 'image/png',
                                     :signature_file_size => 4055, :signature_updated_at => "2013-01-22 12:02:43.344225" )
    change_column :electronic_routesheets, :signature_file_name, :string, :null => false
    change_column :electronic_routesheets, :signature_content_type, :string, :null => false
    change_column :electronic_routesheets, :signature_file_size, :integer, :null => false
    change_column :electronic_routesheets, :signature_updated_at, :timestamp, :null => false
    remove_column :electronic_routesheets, :visit_date
    rename_column :electronic_routesheets, :status, :generated_status
  end

end
