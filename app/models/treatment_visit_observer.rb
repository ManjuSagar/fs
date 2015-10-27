class TreatmentVisitObserver < ActiveRecord::Observer

  def after_initialize(visit)
    set_defaults(visit)
  end

  def before_validation(visit)
    visit.set_dates
    set_discipline_id_if_required(visit)
  end

  def before_create(visit)
    visit.created_user = User.current
    set_initial_flags_value(visit)
  end

  def before_save(visit)
    unless visit.new_record?
      set_sign_flags(visit)
      set_initial_flags_value(visit)
    end
    set_initial_flags_value(visit)
    visit.save_treatment_vitals
    visit.reset_dependents_dates
  end

  def after_save(visit)
    perform_treatment_state_transitions(visit)
  end

  def before_update(visit)
    if visit.draft_status_changed?
      SyncInfoVisitAndDocument.visit_created(visit, true)
      #While converting draft visit to real visit:
      #Usually visit status is changed if document is signed.
      #So if document is signed before visit is converting from draft to real.
      #Convert visit status.
      visit.document_is_signed
      visit.inform_visit_frequency_visit_is_added
    end
  end

  def after_update(visit)
    visit.complete! if visit.draft_status_changed? and visit.may_complete?
    visit.send(:create_payable) if visit.completed?
  end

  def after_destroy(visit)
    reset_discipline_active_status_if_needed(visit)
  end

  def set_defaults(visit)
    unless visit.new_record?
      visit.visit_date = visit.visit_start_time.to_date
      visit.start_time_hour = visit.visit_start_time.hour
      visit.start_time_min = visit.visit_start_time.min
      visit.end_time_hour = visit.visit_end_time.hour
      visit.end_time_min = visit.visit_end_time.min
    end
  end

  def set_discipline_id_if_required(visit)
    visit.discipline = visit.visit_type.discipline if visit.visit_type
  end

  def set_initial_flags_value(visit)
    if visit.changed.include?("draft_status") or visit.from_electronic_routesheet or visit.visited_staff.present?
      visit.fs_sign_required = (visit.visited_staff.is_a? FieldStaff or visit.visited_user_is_belongs_to_organization?)? true : false
      visit.supervisor_sign_required = (visit.supervisor_present?? true : false)
      visit.os_sign_required = true
    end
  end

  def set_sign_flags(visit)
    if visit.current_user_is_office_staff? and visit.is_dirty?
      visit.fs_sign_required ||= visit.visited_user.review_agency_changes_flag?
      visit.supervisor_sign_required ||= visit.review_agency_changes_flag?
      visit.os_sign_required = true
    end
  end

  def perform_treatment_state_transitions(visit)
    return nil unless visit.visit_type
    treatment = visit.treatment
    treatment_context = if visit.discipline
                          treatment.treatment_disciplines.episode_scope(visit.treatment_episode).find_by_discipline_id(visit.discipline_id)
                        else
                          treatment
                        end
    treatment_context.system_driven_event = true
    visit.visit_type.applicable_transitions_for(treatment_context).each {|st|
      treatment_context.send("transition_to_#{st.to_state}!".to_sym)
    }
    treatment_context.system_driven_event = false
    nil
  end

  def reset_discipline_active_status_if_needed(visit)
    treatment = visit.treatment
    discipline = visit.discipline
    if discipline.present? && treatment.treatment_visits.select{|tv| tv.discipline.present? && tv.discipline == discipline }.count == 0
      treatment_discipline = treatment.treatment_disciplines.episode_scope(visit.treatment_episode).detect{|x| x.discipline == discipline}
      if treatment_discipline
      treatment_discipline.system_driven_event = true
      treatment.system_driven_event = true
      if treatment_discipline.may_deactivate?
        treatment_discipline.deactivate!
      else
        treatment.deactivate! if treatment.may_deactivate?
      end
    end
  end
  end

end