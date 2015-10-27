# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  first_name              :string(100)      not null
#  last_name               :string(100)      not null
#  suite_number            :string(15)
#  street_address          :string(50)
#  city                    :string(50)
#  state                   :string(2)
#  zip_code                :string(10)
#  phone_number            :string(15)
#  user_type               :string(50)
#  lock_version            :integer          default(0)
#  approved                :boolean          default(FALSE), not null
#  gender                  :string(1)
#  signature_file_name     :string(255)
#  signature_content_type  :string(255)
#  signature_file_size     :integer
#  signature_updated_at    :datetime
#  middle_initials         :string(2)
#  suffix                  :string(10)
#  ethnicity               :string(20)
#  encrypted_sign_password :string(255)
#

class PatientSchedule < ActiveRecord::Base

  self.table_name = "users"

  attr_accessor :visit_type
  attr_accessor :day1, :day2, :day3, :day4, :day5, :day6, :day7

  netzke_attribute :visit_type
  netzke_attribute :day1
  netzke_attribute :day2
  netzke_attribute :day3
  netzke_attribute :day4
  netzke_attribute :day5
  netzke_attribute :day6
  netzke_attribute :day7


  def self.frequency_details_for_week(treatment, week_start_date, episode)
    excess_discipline_visits = []

    out = episode.disciplines.inject([]) {|r, d|
      week_end_date = week_start_date + 6
      frequencies = episode.visit_frequencies.where(["discipline_id = ? and cancelled = ?", d.id, false])
      frequency = frequencies.detect{|f| week_start_date <= f.frequency_start_date and f.frequency_end_date <= week_end_date }

      freq_count = frequency ? ( frequency.visits_per_unit || 0 ) : 0
      visits_count = frequency ? ( frequency.visits_count || 0 ) : 0

      treatment_visits = episode.treatment_visits.select {|tv| tv.visit_date.between?(week_start_date, week_end_date)}
      discipline_visits = treatment_visits.select{|tv| tv.treatment_episode_id == episode.id and tv.discipline_id == d.id}.sort_by &:visit_date
      excess_visits =  if freq_count < visits_count
                         discipline_visits[freq_count..visits_count]
                       elsif (freq_count == 0 and visits_count == 0  and discipline_visits.size > 0)
                         discipline_visits
                       else
                         []
                       end
      excess_discipline_visits += excess_visits unless excess_visits.blank?

                                #If frequency count and done visit count are zero and discipline visits are done
      visits_count_not_matched = (((freq_count == 0 and visits_count == 0 and discipline_visits.size > 0) or
          #If frequency visit is not matched with visits done
          freq_count != visits_count) and
          #Current Date comparison for less visits or excess visits
          (week_end_date <= Date.current or (freq_count < visits_count and week_start_date <= Date.current and week_end_date >= Date.current)))

      r << "#{d.discipline_code} #{freq_count} #{visits_count_not_matched}"
      r
    }


    [{input_required: User.current.office_staff?, frequency_details: out}.to_nifty_json, excess_discipline_visits]
  end

  def self.schedule_for_treatment(treatment, episode)
    start_date = episode.start_date
    end_date = episode.end_date
    records = []

    calendar_start_date = working_week_start_date(treatment, start_date)
    calendar_end_date = working_week_end_date(treatment, end_date)
    date = calendar_start_date

    visit_frequency_details, excess_discipline_visits = frequency_details_for_week(treatment, calendar_start_date, episode)
    record = [1, visit_frequency_details]

    visits_for_period = episode.treatment_visits
    medical_orders_for_period = episode.medical_orders
    comm_notes_for_period = episode.communication_notes
    medications_for_period = episode.medications
    treatment_attachments_for_period = episode.attachments

    held_discipline_details = held_disciplines_details(episode)
    authorization_details = check_authorization_tracking(episode)

    frequencies_for_period = [] #treatment.visit_frequencies.where(["start_date >= ? and start_date <= ?", start_date, end_date])
    while (date <= calendar_end_date) do
      values = {date: date.strftime("%m/%d/%Y")}
      values["within_range"] = (date >= start_date and date <= end_date)
      visits = visits_for_period.select{|v| v.visit_start_time.to_date == date}
      comp_visits = visits.select{|x| (x.completed? == true)}
      visits = visits - comp_visits
      visit_info = visits.collect{|v| [v.id, "#{v.visit_type.visit_type_short_display} #{v.visit_start_time.strftime("%H:%M")}", excess_discipline_visits.include?(v)]}
      values["visits"] = visit_info
      values["completed_visits"] = comp_visits.collect{|v| [v.id, "#{v.visit_type.visit_type_short_display} #{v.visit_start_time.strftime("%H:%M")}", excess_discipline_visits.include?(v)]}

      values["scheduled_visits"] = scheduled_visits_list(episode, date)

      medical_order_presence_flag = medical_orders_for_period.any?{|m| m.order_date.to_date == date}
      values["medical_order"] = medical_order_presence_flag

      medications_change_flag = medications_for_period.any?{|m| m.start_date == date}
      values["medication"] = medications_change_flag

      values["held_disciplines"] = held_discipline_details.select{|dd| (dd[:hold_date]..dd[:unhold_date]).include?(date) }.collect{|x| x[:discipline]}

      values["authorization_tracking"] = (date >= start_date)? authorization_details.select{ |w| (w[:start_date]..w[:end_date]).include?(date)}.collect{|x| x[:discipline]} : []

      frequency_change_flag = frequencies_for_period.any?{|m| m.start_date == date}
      values["frequency"] = frequency_change_flag

      comm_notes_presence_flag = comm_notes_for_period.any?{|m| m.note_date_time.to_date == date}
      values["comm_notes"] = comm_notes_presence_flag

      treatment_attachment_presence_flag = treatment_attachments_for_period.any?{|a| a.attachment_date == date}
      values["attachment"] = treatment_attachment_presence_flag

      if treatment.treatment_request and treatment.treatment_request.referral_received_date and treatment.treatment_request.referral_received_date == date
        values["referral_received"] = true
      end
      record << values.to_nifty_json
      if record.size == 9
        records << record
        visit_frequency_details, excess_discipline_visits = frequency_details_for_week(treatment, date+1, episode)
        record = [records.size+1, visit_frequency_details]
      end
      date += 1
    end
    records
  end

  def self.scheduled_visits_list(episode, date)
    org = episode.treatment.patient.org
    scheduled_visits = episode.scheduled_visits.episode_scope(episode.id).not_visited(org).where({scheduled_date: date})
    scheduled_visits.collect {|v| [v.id, "#{v.visit_type.visit_type_short_display} #{v.start_time.size > 0 ? v.start_time.insert(2, ':') : ''}", false] }
  end

  def self.working_week_start_date(treatment, date)
    start_day_of_week = treatment.patient.org.week_start_day_index
    day_of_week = date.strftime("%w").to_i
    week_beginning_date = date - (day_of_week - start_day_of_week)
    if day_of_week < start_day_of_week
      week_beginning_date = week_beginning_date - 7
    end
    week_beginning_date
  end

  def self.working_week_end_date(treatment, date)
    working_week_start_date(treatment, date) + 6
  end


  def self.held_disciplines_details(episode)
    discipline_detailes = []

    disciplines = TreatmentDiscipline.episode_scope(episode).collect{|x| {discipline: x.discipline.discipline_code,
                                                                          date: TreatmentActivity.where(discipline_id: x.id).collect {|y|  y.activity_date},
                                                                          status: TreatmentActivity.where(discipline_id: x.id).collect {|y|  y.activity_type} }}
    disciplines.each do |discipline|
      next if discipline[:date][0] == nil
      for i in 0..discipline[:date].length-1
        next if (discipline[:status][i] == 'U' || discipline[:status][i] == 'D')
        discipline_detailes << {discipline: discipline[:discipline],hold_date: discipline[:date][i],
                                unhold_date: (((discipline[:date][i+1]).present? and discipline[:status][i+1] == 'U')? discipline[:date][i+1] : episode.end_date)}
      end
    end

    activities = TreatmentActivity.where(treatment_id: episode.treatment, discipline_id: nil, activity_type: ['H', 'U']).order('id ASC').collect{|x|
              {date: x.activity_date, status: x.activity_type}}

    activities.each_with_index do |activity, i|
      next if activity[:status] == 'U'
      end_date = (activities[i+1]).present? ? activities[i+1][:date] : episode.end_date
      discipline_detailes << {discipline: 'All Disciplines', hold_date: activity[:date], unhold_date: end_date}
    end
     discipline_detailes

  end

  def self.check_authorization_tracking(episode)
    authorization_tracking_details = []
    org = episode.treatment.patient.org
    authorization_trackings = AuthorizationTracking.approved_and_visit_done(org).where(treatment_episode_id: episode.id)
    authorization_trackings.each do |auth_tracking|
      discipline = Discipline.find(auth_tracking.discipline_id)
      authorization_tracking_details << {start_date: auth_tracking.start_date, end_date: auth_tracking.end_date, discipline: discipline.discipline_code, sort_order: discipline.sort_order }
    end
    authorizations_sorted_by_discipline = authorization_tracking_details.sort_by{ |hash| hash[:sort_order] }
    authorizations_sorted_by_discipline
  end

end

