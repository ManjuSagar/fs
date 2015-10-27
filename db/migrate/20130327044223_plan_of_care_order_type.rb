class PlanOfCareOrderType < ActiveRecord::Migration
  def up
    OrderType.create(type_code: "PLAN_OF_CARE", type_description: "Plan of Care-485")
  end

  def down
  end
end
