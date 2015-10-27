class ConvertMdNameAsPhysicianIdInDocuments < ActiveRecord::Migration
  def up
    Thread.current[:events] = {}
    Document.all.each{|d|
      physician_full_name = d.data["physician_name"]
      treatment_physician = d.treatment.treatment_physicians.detect{|p| p.physician and p.physician.full_name == physician_full_name} if physician_full_name
      d.physician_id = treatment_physician.physician_id if treatment_physician
      begin
      d.save(:validate => false)
      rescue
        Rails.logger.error "Error updating document with Physician"
      end
    }
  end

  def down
  end
end
