module VitalsDisplay
  def vitals_display
    vitals = []
    vitals << "BP: "+ "#{systolic_bp}/#{diastolic_bp}, #{bp_read_location}, #{bp_read_position}" unless systolic_bp.blank?
    vitals << "HR: "+ heart_rate.to_s unless heart_rate.blank?
    vitals << "RR: "+ respiration_rate.to_s unless respiration_rate.blank?
    vitals << "Temp: "+ temperature_in_fht.to_s unless temperature_in_fht.blank?
    vitals << "Blood Sugar: " + blood_sugar.to_s unless blood_sugar.blank?
    vitals << sugar_read_period.to_s unless sugar_read_period.blank?
    vitals << "Oxygen Saturation: "+ oxygen_saturation.to_s unless oxygen_saturation.blank?
    vitals << "Weight: "+ weight_gain_loss_in_lbs.to_s unless weight_gain_loss_in_lbs.blank?
    vitals << "Pain: "+ pain.to_s unless pain.blank?
    vitals.join(" ")
  end

end