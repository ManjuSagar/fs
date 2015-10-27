class ChangeVisitTypeTransitions < ActiveRecord::Migration
  def change
    VisitType.all.each{|v|
      v.state_transitions.create!(:from_state => VisitTypeStateTransition::ANY_STATE, :to_state => VisitTypeStateTransition::ANY_STATE)
    }
  end
end
