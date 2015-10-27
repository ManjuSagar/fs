class UpdateOptionalFlagInVisitTypes < ActiveRecord::Migration
  def up
    execute "Update visit_types set optional_flag = false"
  end

  def down
  end
end
