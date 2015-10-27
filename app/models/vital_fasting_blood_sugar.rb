class VitalFastingBloodSugar < VitalData
  MIN_VALID_VALUE = 1
  MAX_VALUE_VALUE = 100

  def initialize(treatment, episode)
    super(treatment, :fasting_blood_sugar, episode)
  end
end