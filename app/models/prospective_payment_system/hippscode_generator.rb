class ProspectivePaymentSystem::HippscodeGenerator
  attr_reader :export_oasis_record

  def initialize(export_oasis_record)
    @export_oasis_record = export_oasis_record
  end

  def calculate_hipps_code
    Rjb::load(ENV['CLASS_PATH'], [ENV['JVM_ARGS']]) unless Rjb::loaded?
    ms_hipps_grouper_klass = Rjb::import('com.mmm.cms.homehealth.MahaswamiHippsGrouper')
    prop_file = "#{Rails.root}/config/HomeHealthGrouper2015.properties"
    instance = ms_hipps_grouper_klass.new prop_file
    result = instance.score_new export_oasis_record
    debug_log result
    score = Struct.new(:hipps_code_version, :hipps_code, :treatment_authorization_code, :grouping_points)
    params = result.split(",")
    debug_log params
    debug_log score.inspect
    score.new(params[0], params[1], params[2], params[3..7])
  end

  def self.classpath
    rails_root_path = "#{Rails.root}"
    master_base_path = "#{ENV['HOME']}/workspace"
    files = Dir.glob("#{master_base_path}/home_health_case_mix_grouper/dist/*")
    hhj_path = files.present? ? "#{master_base_path}/home_health_case_mix_grouper/dist" : "/workspace/home_health_case_mix_grouper/dist"
    "#{hhj_path}/HH_PPS_V_API.jar:#{hhj_path}/HomeHealthJava.jar:#{hhj_path}/VUT_API.jar:#{Rails.root}/lib/HHJPatchMS.jar"
  end

end