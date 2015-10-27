class OasisFlow
  include AASM
  aasm do
    state :admitted, :initial => true
    state :soc_done
    state :rc_done
    state :dc_done
    state :roc_done
    state :transfer_with_dc_done
    state :transfer_without_dc_done
    state :follow_up_done
    state :death_at_home_done

    event :any do
      transitions :from => :admitted, :to => :soc_done

      transitions :from => :rc_done, :to => :dc_done
      transitions :from => :rc_done, :to => :rc_done
      transitions :from => :rc_done, :to => :transfer_with_dc_done
      transitions :from => :rc_done, :to => :transfer_without_dc_done
      transitions :from => :rc_done, :to => :follow_up_done
      transitions :from => :rc_done, :to => :death_at_home_done

      transitions :from => :soc_done, :to => :rc_done
      transitions :from => :soc_done, :to => :dc_done
      transitions :from => :soc_done, :to => :transfer_with_dc_done
      transitions :from => :soc_done, :to => :transfer_without_dc_done
      transitions :from => :soc_done, :to => :follow_up_done
      transitions :from => :soc_done, :to => :death_at_home_done

      transitions :from => :follow_up_done, :to => :rc_done
      transitions :from => :follow_up_done, :to => :dc_done
      transitions :from => :follow_up_done, :to => :transfer_with_dc_done
      transitions :from => :follow_up_done, :to => :transfer_without_dc_done
      transitions :from => :follow_up_done, :to => :death_at_home_done

      transitions :from => :roc_done, :to => :rc_done
      transitions :from => :roc_done, :to => :dc_done
      transitions :from => :roc_done, :to => :transfer_with_dc_done
      transitions :from => :roc_done, :to => :transfer_without_dc_done
      transitions :from => :roc_done, :to => :follow_up_done
      transitions :from => :roc_done, :to => :death_at_home_done

      transitions :from => :transfer_without_dc_done, :to => :roc_done
      transitions :from => :transfer_without_dc_done, :to => :dc_done
    end

  end

  def self.to_states_for_state state
    aasm.events.map {|k,v| v.transitions_from_state(state)}.flatten.map(&:to).flatten
  end

  def self.get_all_possible_oasis_docs(document_type)

    if (document_type == '')
    class_list = ["OasisEvalFormC1"]
    end
    if (document_type == "RC")
    class_list = ["OasisRecertificationFormC1", "OasisResumptionOfCareFormC1"]
    end
    if (document_type == "OasisEvaluation" or document_type == "OasisResumptionOfCare")
    class_list = ["OasisRecertificationFormC1","OasisDischargeFromAgencyFormC1",
       "OasisTransferredPatientWithoutDischargeFormC1","OasisTransferredPatientWithDischargeFormC1",
       "OasisOtherFollowupFormC1","OasisDeathAtHomeFormC1"]
    end
    if (document_type == "OasisRecertification")
    class_list = ["OasisRecertificationFormC1", "OasisDischargeFromAgencyFormC1","OasisTransferredPatientWithoutDischargeFormC1",
       "OasisTransferredPatientWithDischargeFormC1","OasisOtherFollowupFormC1","OasisDeathAtHomeFormC1"]
    end
    if (document_type == "OasisOtherFollowup")

    class_list = ["OasisRecertificationFormC1","OasisDischargeFromAgencyFormC1","OasisTransferredPatientWithoutDischargeFormC1",
                  "OasisTransferredPatientWithDischargeFormC1","OasisDeathAtHomeFormC1"]
    end
    if (document_type == "OasisTransferredPatientWithoutDischarge")
    class_list = ["OasisResumptionOfCareFormC1","OasisDischargeFromAgencyFormC1"]
    end
    if (document_type == "OasisDischargeFromAgency" or document_type == "OasisTransferredPatientWithDischarge" or
        document_type == "OasisDeathAtHome")
    class_list = []
    end

    class_list
  end
end