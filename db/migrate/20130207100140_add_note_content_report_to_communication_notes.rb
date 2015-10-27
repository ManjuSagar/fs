class AddNoteContentReportToCommunicationNotes < ActiveRecord::Migration
  def change
   change_table :communication_notes do |t| 
    t.has_attached_file :printable_content
   end

   CommunicationNote.destroy_all

   add_column :communication_notes, :medical_order_id, :integer, :null => true

   add_column :communication_notes, :field_staff_id, :integer

   rename_column :communication_notes, :note_date, :note_date_time
   change_column :communication_notes, :note_date_time, :datetime 
   
   remove_column :communication_notes, :signed_date, :signed_user_id   

   add_column :communication_notes, :note_type_id, :integer, :null => false
  
  end
end  
  
