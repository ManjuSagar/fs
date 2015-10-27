module Wound
  WOUND_PRIMARY_ATTRS = ["pressure_ulcer_stage",
                         "patient_turned",
                         "pelvis_surface",
                         "moisture",
                         "pressure_gt_30_days",
                         "arterial_ulcer",
                         "other_wound_type",
                         "diabetic_ulcer",
                         "bandages_applied",
                         "ambulation_encouraged",
                         "surgically_created",
                         "surgical_procedure",
                         "surgical_procedure_date",
                         "wound_accident",
                         "date_of_accident",
                         "accident_type"]

  WOUND_DESCRIPTION_ATTRS   = ["wound_type_",
                               "wound_age_",
                               "wound_location_",
                               "wound_tissue_present_",
                               "wound_debridement_attempted_",
                               "wound_debridement_date_",
                               "wound_debridement_type_",
                               "wound_debridement_required_",
                               "wound_measurement_date_",
                               "wound_length_",
                               "wound_width_",
                               "wound_depth_",
                               "wound_appearance_of_wound_",
                               "wound_exudate_",
                               "wound_thickness_",
                               "wound_muscle_",
                               "wound_underminig_",
                               "wound_undermining_location1_",
                               "wound_undermining_from1_",
                               "wound_undermining_to1_",
                               "wound_undermining_location2_",
                               "wound_undermining_from2_",
                               "wound_undermining_to2_",
                               "wound_tunneling_",
                               "wound_tunneling_location1_",
                               "wound_tunneling_from1_",
                               "wound_tunneling_to1_",
                               "wound_tunneling_location2_",
                               "wound_tunneling_from2_",
                               "wound_tunneling_to2_",
                               "total_wound_panels"]

  def wounds
    wounds_tags = []
    total_wound_panels.to_i.times do |num|
      wound_tags = {}
      WOUND_DESCRIPTION_ATTRS.each do |attr|
        xml_attr = attr.gsub(/_$/,'')
        xml_val = self.send("#{attr}#{num+1}")
        wound_tags[xml_attr] = xml_val
      end
      wounds_tags << wound_tags
    end
    wounds_tags
  end
end
