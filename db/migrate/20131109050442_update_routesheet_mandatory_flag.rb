class UpdateRoutesheetMandatoryFlag < ActiveRecord::Migration
  def up
    HealthAgencyDetail.all.each{|had|
      if had.data["routesheet_mandatory_flag_for_os?"] == true
        had.routesheet_mandatory = had.data["routesheet_mandatory_flag_for_os?"]
        had.save!
      end
    }
  end

  def down
  end
end