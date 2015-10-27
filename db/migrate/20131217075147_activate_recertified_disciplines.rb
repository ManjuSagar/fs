class ActivateRecertifiedDisciplines < ActiveRecord::Migration
  def up
    Thread.current[:events] = {}
    treatment_disciplines = TreatmentDiscipline.where(:treatment_status => 'P')
    treatment_disciplines.each{|td|
      next if td.treatment_episode.nil?
      previous_episode = td.treatment.previous_episode(td.treatment_episode)
      if previous_episode
        td.system_driven_event = true
        td.activate! if td.may_activate?
      end
    }
  end

  def down
  end
end
