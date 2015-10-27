desc "Import Medicare Bill Rates, EX: rake import_medicare_bill_rates year='2014'"
RURAL_AREAS_CBSA_CODES2015 = [50001, 50002, 50005, 50007, 50025, 50028, 50031, 50035, 50036, 50037, 50041, 50045, 50047,
                              50048, 50050, 50056, 50057, 50066, 50068, 50071, 50073, 50080, 50084, 50087, 50089, 50090,
                              50091, 50103, 50104, 50111, 50115, 50117, 50118, 50120, 50121, 50139, 50146, 50147, 50149,
                              50151, 50164, 50165, 50168, 50169, 50173, 50174, 50177, 50180, 50182, 50183]
task :import_medicare_bill_rates => [:environment] do
  raise "Please provide year in 'year' argument" unless ENV['year']
  if ENV['year'] == '2013' or ENV['year'] == '2014'
    Rake::Task["import_cbsa_codes"].execute(year=ENV["year"])
    Rake::Task["import_wage_indices"].execute(year=ENV["year"])
  else
      Rake::Task["import_hipps_codes"].execute(year=ENV["year"])
	  Rake::Task["import_hipps_code_hhrg_weights"].execute(year=ENV["year"])
	  Rake::Task["import_medicare_labor_percentage"].execute(year=ENV["year"])
	  Rake::Task["import_medicare_nrs_rates"].execute(year=ENV["year"])
	  Rake::Task["import_medicare_lupa_rates"].execute(year=ENV["year"])
	  Rake::Task["import_medicare_standard_rates"].execute(year=ENV["year"])
	  Rake::Task["import_cbsa_codes"].execute(year=ENV["year"])
	  Rake::Task["import_wage_indices"].execute(year=ENV["year"])
  end
end

desc "Import Hipps code, EX: rake import_hipps_codes year='2014'"
task :import_hipps_codes => [:environment] do
  raise "Please provide year in 'year' argument" unless ENV['year']
  require 'csv'
  hipps_codes = CSV.open("static_data/hcpc_codes/hcpc_2013.csv", :headers=>true)
  hipps_codes.each do |hipps_code|
    next if ProspectivePaymentSystem::HippsCode.find_by_code(hipps_code[0])
    ProspectivePaymentSystem::HippsCode.create!({code: hipps_code[0], description: hipps_code[1]})
  end
end

desc "Import Hipps Code_Hhrg Weights, EX: rake import_hipps_code_hhrg_weights year='2014'"
task :import_hipps_code_hhrg_weights => [:environment] do
  raise "Please provide year in 'year' argument" unless ENV['year']
  require 'csv'
  require 'pp'
  arr = []
  hhrg_weights = CSV.open("static_data/hipps_codes/#{ENV['year']}/hhrg_weights.csv", :headers=>true)
  hhrg_weights.each do |hhrg_weight|
    hipps_code = ProspectivePaymentSystem::HippsCode.find_by_code(hhrg_weight[0])
    ProspectivePaymentSystem::HhrgWeight.create!({calender_year: ENV["year"], weight: hhrg_weight[1], hipps_code: hipps_code}) if hipps_code
  end
end

desc "Import Medicare Labor Percentage, EX: rake import_medicare_labor_percentage year='2014'"
task :import_medicare_labor_percentage => [:environment] do
  raise "Please provide year in 'year' argument" unless ENV['year']
  require 'csv'
  require 'pp'
  labor_percentages = CSV.open("static_data/hipps_codes/#{ENV['year']}/medicare_labor_percentages.csv", :headers=>true)
  labor_percentages.each{|labor_percentage|
    ProspectivePaymentSystem::MedicareLaborPercentage.create!({calender_year: ENV["year"], labor_percentage: labor_percentage[0] })
  }
end

desc "Import Medicare Nrs Rates, EX: rake import_medicare_nrs_rates year='2014'"
task :import_medicare_nrs_rates => [:environment] do
  raise "Please provide year in 'year' argument" unless ENV['year']
  require 'csv'
  nrs_rates = CSV.open("static_data/hipps_codes/#{ENV['year']}/nrs_score_rates.csv", :headers=>true)
  nrs_rates.each do |nrs_rate|
    ProspectivePaymentSystem::MedicareNrsRate.create!({calender_year: ENV["year"], nrs_score: nrs_rate[0], nrs_amt: nrs_rate[1]})
  end
end

desc "Import Medicare Standard Rates, EX: rake import_medicare_standard_rates year='2014'"
task :import_medicare_standard_rates => [:environment] do
  raise "Please provide year in 'year' argument" unless ENV['year']
  require 'csv'
  standard_rates = CSV.open("static_data/hipps_codes/#{ENV['year']}/medicare_standard_rates.csv", :headers=>true)
  standard_rates.each do |standard_rate|
    ProspectivePaymentSystem::MedicareStandardRate.create!({calender_year: ENV["year"], base_amt: standard_rate[0], rural_percentage: standard_rate[1]})
  end
end

desc "Import Medicare Lupa Rates, EX: rake import_medicare_lupa_rates year='2014'"
task :import_medicare_lupa_rates => [:environment] do
  raise "Please provide year in 'year' argument" unless ENV['year']
  require 'csv'
  lupa_rates = CSV.open("static_data/hipps_codes/#{ENV['year']}/medicare_lupa_rates.csv", :headers=>true)
  lupa_rates.each do |lupa_rate|
    ProspectivePaymentSystem::MedicareLupaRate.create!({calender_year: ENV["year"], discipline_code: lupa_rate[0], base_amt: lupa_rate[1]})
  end
end

desc "Import Cbsa Codes, EX: rake import_cbsa_codes year='2014'"
task :import_cbsa_codes => [:environment] do
  raise "Please provide year in 'year' argument" unless ENV['year']
  require 'csv'
  cbsa_codes = CSV.open("static_data/cbsa_codes/#{ENV['year']}/cbsa_#{ENV['year']}.csv", :headers=>true)
  cbsa_codes.each do |cbsa_code|
   county_name = cbsa_code[1].strip if cbsa_code[1].present?
   state_name = cbsa_code[2].strip if cbsa_code[2].present?
   area_type = if ['2013', '2014'].include?(ENV['year']) and cbsa_code[3].present?
                 cbsa_code[3].starts_with?("99") ? 'rural' : 'urban'
               else
                 (cbsa_code[3].starts_with?('99') or RURAL_AREAS_CBSA_CODES2015.include? cbsa_code[3].to_i) ? 'rural' : 'urban'

               end    
   next if ProspectivePaymentSystem::MedicareCoreStatArea.find_by_county_code_and_calender_year(cbsa_code[0], ENV["year"])
   ProspectivePaymentSystem::MedicareCoreStatArea.create!({calender_year: ENV["year"], county_code: cbsa_code[0], county_name: county_name , state_name: state_name,
                                                           cbsa_code: cbsa_code[3], area_type: area_type })
  end
end

desc "Import Wage Indices, EX: rake import_wage_indices year='2014'"
task :import_wage_indices => [:environment] do
  raise "Please provide year in 'year' argument" unless ENV['year']
  require 'csv'
  wage_indexes = CSV.open("static_data/cbsa_codes/#{ENV['year']}/cbsa_#{ENV['year']}.csv", :headers=>true)
  wage_indexes.each do |wage_index|
    cbsa_code = ProspectivePaymentSystem::MedicareCoreStatArea.where(cbsa_code: wage_index[3],county_code: wage_index[0], calender_year: ENV["year"]).first
    ProspectivePaymentSystem::MedicareAreasWageIndex.create! ({calender_year: ENV["year"], cbsa_code: cbsa_code, wage_index: wage_index[4] })
  end
end