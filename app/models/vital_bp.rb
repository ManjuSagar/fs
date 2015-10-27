class VitalBp


  def initialize(treatment, episode)
    @treatment = treatment
    @episode = episode
  end

  MIN_VALID_VALUE = 1
  MAX_VALUE_VALUE = 170

  def max_threshold_value
    recs = @treatment.patient.org.vitals_reference_ranges.select{|r| ["systolic_bp", "diastolic_bp"].include?(r.vital_sign)}
    max_diastolic_value = recs.detect{|r| r.vital_sign == "diastolic_bp"}.maximum_value rescue 0
    max_systolic_value = recs.detect{|r| r.vital_sign == "systolic_bp"}.maximum_value rescue 0
    (((max_diastolic_value*2) + max_systolic_value)/3).to_i
  end

  def min_threshold_value
    recs = @treatment.patient.org.vitals_reference_ranges.select{|r| ["systolic_bp", "diastolic_bp"].include?(r.vital_sign)}
    min_diastolic_value = recs.detect{|r| r.vital_sign == "diastolic_bp"}.minimum_value  rescue 0
    min_systolic_value = recs.detect{|r| r.vital_sign == "systolic_bp"}.minimum_value  rescue 0
    (((min_diastolic_value*2) + min_systolic_value)/3).to_i
  end

  def entries
    max = max_threshold_value
    min = min_threshold_value
    values = @episode.treatment_visits.collect{|tv|
      next if tv.diastolic_bp.nil? or tv.systolic_bp.nil?
      value = (((tv.diastolic_bp*2) + tv.systolic_bp)/3).to_i
      {date: tv.visit_start_time.strftime("%m/%d"), value: value, max: max, min: min}
    }.compact
    values.sort_by{|v| v[:date]}
  end

end