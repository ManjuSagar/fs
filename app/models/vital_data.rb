class VitalData


  def initialize(treatment, vital_sign, episode)
    @treatment = treatment
    @vital_sign = vital_sign
    @episode = episode
  end

  MIN_VALID_VALUE = 1
  MAX_VALUE_VALUE = 100

  def max_threshold_value
    @treatment.patient.org.vitals_reference_ranges.detect{|r| r.vital_sign == @vital_sign.to_s}.maximum_value  rescue 0
  end

  def min_threshold_value
    @treatment.patient.org.vitals_reference_ranges.detect{|r| r.vital_sign == @vital_sign.to_s}.minimum_value  rescue 0
  end

  def entries
    max = max_threshold_value
    min = min_threshold_value
    values = @episode.treatment_visits.collect{|tv|
      value = tv.send(@vital_sign.to_sym)
      next if value.nil?
      {date: tv.visit_start_time.strftime("%m/%d"), value: value, max: max, min: min}
    }.compact
    values.sort_by{|v| v[:date]}
  end



end