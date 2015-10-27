class RemoveSomeStates < ActiveRecord::Migration
  def change
    removeable_attrs = ["AS", "DC", "GU", "MP", "PR", "UM", "UI"]
    removeable_attrs.each do |code|
      s = State.find_by_state_code(code)
      s.destroy if s.present?
    end
  end
end
