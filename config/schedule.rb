# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, "/usr/local/bin/"

=begin
 every 1.hour do
   [:development, :production].each do |envmnt|
     rake "draft_patient_destroy_after_an_hour", :environment => envmnt
     rake "draft_orgs_destroy_after_an_hour", :environment => envmnt
     rake "draft_ins_companies_destroy_after_an_hour", :environment => envmnt
     rake "draft_visits_destroy_after_an_hour", :environment => envmnt
   end
 end

  every 1.day do
    [:development, :production].each do |envmnt|
      rake "delete_old_staffing_requests", :environment => envmnt
    end
  end
=end

 every 30.minutes do
   [:production].each do |envmnt|
     rake "electronic_claims_transmission", :environment => envmnt, :output => {error: 'log/claims_errors.log', :standard => 'log/claims.log'}
   end
 end

every 3.days, :at => '6:00am' do # Use any day of the week or :weekend, :weekday
  [:production].each do |envmnt|
    rake "update_pecos_flag", :environment => envmnt
  end
end

every :wednesday, :at => '12:00am' do # Use any day of the week or :weekend, :weekday
  [:production].each do |envmnt|
    rake "import_npi_registry", :environment => envmnt
  end
end

every 1.day do
  [:production].each do |envmnt|
    rake "era_file_download", :environment => envmnt, :output => {error: 'log/era.log'}
  end
end

# Duplicate records are creating: so updating this functionality is removed.
=begin
 every :thursday, :at => '8am' do # Use any day of the week or :weekend, :weekday
   [:development, :production].each do |envmnt|
     rake "import_fda_library", :environment => envmnt
   end
 end
=end
