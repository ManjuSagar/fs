class ProspectivePaymentSystem::NrsConversionFactor2015
  RELATIVE_WEIGHTS = {:S => 0.2698, :T => 0.9742, :U => 2.6712, :V => 3.9686, :W => 6.1198, :X => 10.5254}
  NRS_CONVERSION_FACTOR = {:urban => 53.23, :rural => 54.83}

  def self.nrs_amount(nrs, area)
    RELATIVE_WEIGHTS[nrs.to_sym] * NRS_CONVERSION_FACTOR[area.to_sym]
  end

end