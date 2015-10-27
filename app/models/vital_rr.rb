class VitalRr < VitalData


  MIN_VALID_VALUE = 1
  MAX_VALUE_VALUE = 100

  def initialize(treatment, episode)
    super(treatment, :respiration_rate, episode)
  end

end