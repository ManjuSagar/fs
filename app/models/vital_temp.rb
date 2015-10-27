class VitalTemp < VitalData
  MIN_VALID_VALUE = 1
  MAX_VALUE_VALUE = 100

  def initialize(treatment, episode)
    super(treatment, :temperature_in_fht, episode)
  end
end