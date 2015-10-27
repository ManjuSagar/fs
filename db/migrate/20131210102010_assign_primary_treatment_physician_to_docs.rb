class AssignPrimaryTreatmentPhysicianToDocs < ActiveRecord::Migration
  def up
    Thread.current[:events] = {}
    docs = Document.where("physician_id is null")
    docs.each{|d|
      treatment_physicians = d.treatment.treatment_physicians
      treatment_physician = treatment_physicians.detect{|tp| tp.primary? } || treatment_physicians.first
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
