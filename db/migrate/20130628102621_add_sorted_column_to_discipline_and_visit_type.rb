class AddSortedColumnToDisciplineAndVisitType < ActiveRecord::Migration
  def change
    add_column :disciplines, :sort_order, :integer
    add_column :visit_types, :sort_order, :integer

    Discipline.reset_column_information
    VisitType.reset_column_information
    discipline_order = ["SN", "PT", "OT", "ST", "MSW", "CHHA"]
    discipline_order.each_with_index do |d, i|
      Discipline.all.each do |disp|
        disp.update_column(:sort_order, i+1) if (disp.discipline_code == d)
      end
    end
    orgs =  Org.all

    orgs.each do |org|
      org.visit_types.each do |vt|
        if /Eval/.match(vt.visit_type_description)
          vt.update_column(:sort_order, 1)
        elsif /Followup/.match(vt.visit_type_description) || /FU/.match(vt.visit_type_description)
          vt.update_column(:sort_order, 2)
        elsif /Discharge/.match(vt.visit_type_description) || /DC/.match(vt.visit_type_description)
          vt.update_column(:sort_order, 3)
        else
          vt.update_column(:sort_order, 4)
        end
      end
    end

    change_column :disciplines, :sort_order, :integer, :null => false
    change_column :visit_types, :sort_order, :integer, :null => false

  end
end
