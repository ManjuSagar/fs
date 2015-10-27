# == Schema Information
#
# Table name: visit_frequencies
#
#  id                   :integer          not null, primary key
#  discipline_id        :integer          not null
#  treatment_episode_id :integer          not null
#  medical_order_id     :integer          not null
#  frequency_string     :string(50)       not null
#  frequency_status     :string(255)      not null
#  lock_version         :integer          default(0)
#  unit_count           :integer          not null
#  frequency_unit       :string(2)        not null
#  visits_per_unit      :integer          not null
#  treatment_id         :integer          not null
#  frequency_start_date :date
#  frequency_end_date   :date
#

class VisitFrequency < ActiveRecord::Base
  belongs_to :treatment, :class_name => "PatientTreatment", :foreign_key => "treatment_id"
  belongs_to :discipline
  belongs_to :treatment_episode
  belongs_to :medical_order
  has_many :frequency_field_staffs, :class_name => "VisitFrequencyFieldStaff", :dependent => :destroy, :foreign_key => :frequency_id
  has_many :field_staffs, :through => :frequency_field_staffs

  default_scope lambda {order('id')}

  audited :associated_with => :treatment, :allow_mass_assignment => true

  scope :org_scope, lambda { includes({:treatment => {:patient => :patient_detail}}).where({:patient_details => {:org_id => Org.current.id}}) if Org.current}

  FREQUENCY_UNITS = [['W', 'Week'], ['D', 'Daily']]
  before_validation :set_start_date_and_end_date
  before_create :set_status
  after_initialize :set_defaults, :if => :new_record?

  validates :discipline, :presence => true
  validates_presence_of :frequency_string, :message => " not valid. Enter one valid frequency string."
  validates :treatment_episode, :presence => true
  validates :frequency_start_date, :presence => true, :if => lambda{|f| f.class.frequency_string_valid?(f.frequency_string)}
  validate :check_dates_are_valid, :if => lambda{|f| f.class.frequency_string_valid?(f.frequency_string)}

  def frequency_string=(value)
    return unless VisitFrequency.frequency_string_valid?(value)
    write_attribute(:frequency_string, value)
    update_frequency_fields
  end

  STATE_MAP = {:not_started => 'N', :active => 'A', :completed_pending_action => 'P', :completed => 'C'}
  
  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr == :frequency_status
    write_attribute_without_mapping(attr, v)
  end

  def frequency_status
    STATE_MAP.invert[read_attribute(:frequency_status)]
  end

  attr_accessor :system_driven_event

  def system_driven_event?
    self.system_driven_event == true
  end

  def incomplete_details_present?
    all_details_initial_status_changed? and atleast_one_incomplete_detail_present?
  end

  def total_visits
    unit_count * visits_per_unit
  end

  def update_frequency_fields
    #2wk3
    #visits_per_unit => 2, frequency_unit => w (wk converted into w), unit_count => 3
    match = frequency_string.upcase.match(/^(\d+|QD|BID|TID)(W|WK|WEEK|D|DY|DAY|M|MON|MT|MONTH|X)(\d+)$/)
    if match and match.size == 4
      self.visits_per_unit = (match[1].match(/\d+/))? match[1].to_i : visits_per_unit_code_value(match[1])
      self.frequency_unit = determine_unit_from_input(match[2])
      self.unit_count = match[3].to_i
    end
  end

  def visits_per_unit_code_value(code)
    case code
      when "QD", "qd"
        1
      when "BID", "bid"
        2
      when "TID", "tid"
        3
    end
  end

  def current_frequency?(visit)
    ((frequency_start_date..frequency_end_date).include?(visit.visit_start_time.to_date) and
        (visit.discipline == discipline) )
  end

  def attach_treatment_visit(freq_detail, visit)
    freq_detail.visit = visit
    freq_detail.save!
  end

  def mark_detail_visited(detail)
    detail.system_driven_event = true
    detail.visited! if detail.may_visited?
    detail.system_driven_event = false
  end

  def self.frequency_string_valid?(value)
    return false if value.nil?
    value.upcase.match(/^(\d+|QD|BID|TID)(W|WK|WEEK|D|DY|DAY|M|MON|MT|MONTH|X)(\d+)$/).nil? == false
  end

  def self.parse_frequency(frequency_string)
    # Frequency can be separated by comma or space
    frequency_string.split(',').collect{|f| f.split(' ')}.flatten
  end

  def compute_start_date
    previous_frequency = self.treatment.previous_frequency_for_discipline(self)
    (previous_frequency.nil?) ? treatment.first_visit_start_date(self) : previous_frequency.frequency_end_date + 1
  end

  def compute_end_date(date = nil)
    date = compute_start_date if date.nil?
    end_date = if day_frequency?
      date + unit_count - 1
    elsif week_frequency?
      date + (number_of_days_for_first_week + ((unit_count - 1) * number_of_days_for_unit) - 1)
    elsif month_frequency?
      date.months_since(unit_count - 1).end_of_month
    end
    episode_end_date_diff = end_date.to_date - treatment_episode.end_date
    (episode_end_date_diff > 0 and episode_end_date_diff < 7)? treatment_episode.end_date : end_date
  end

  def week_frequency?
    frequency_unit == 'W'
  end

  def month_frequency?
    frequency_unit == 'M'
  end

  def day_frequency?
    frequency_unit == 'D' || frequency_unit == 'X'
  end

  def number_of_days_for_first_week
    previous_frequency = self.treatment.previous_frequency_for_discipline(self)
    number_of_days = 0
    previous_frequency_end_date = previous_frequency.nil? ? treatment.first_visit_start_date(self) : previous_frequency.frequency_end_date
    previous_frequency_end_date = self.frequency_start_date if self.frequency_start_date
    visit_day = previous_frequency_end_date.strftime("%w") # find day of the week
    org_week_start_day = treatment.org_week_start_day
    number_of_days = difference_from_org_start_day(org_week_start_day, visit_day)
    number_of_days
  end

  def difference_from_org_start_day(org_week_start_day, visit_day)
    number_of_days = org_week_start_day - visit_day.to_i
    number_of_days += 7 if number_of_days <= 0
    number_of_days
  end

  def number_of_days_for_unit
    case frequency_unit
      when "W"
        7
      when "D", "X"
        1
      when "M"
        30
    end
  end

  def unit_description
    case frequency_unit
      when "W"
        "Week"
      when "D", "X"
        "Day"
      when "M"
        "Month"
    end
  end

  def determine_unit_from_input(input)
    unit_map = {
        "W" => ["wk", "w", "week", "W", "WEEK", "WK"],
        "D" => ["d", "dy", "day", "D", "DY", "DAY"],
        "M" => ["m", "mon", "mt", "month", "M", "MON", "MT", "MONTH"],
        "X" => ["x", "X"]
    }
    match = unit_map.detect{|k,v| v.include?(input.downcase)}
    match.first if match
  end

  def frequency_string_valid?(value = frequency_string)
    value.match(/(\d*)(.*)(\d+)/).nil? == false
  end

  def self.create_or_update_visit_frequencies(params)

    params["values"].each do |value|
      value.merge!(treatment_id: params[:treatment_id], episode_id: params[:episode_id])
      create_or_update_visit_frequency(value)
    end
  end

  def self.create_or_update_visit_frequency(params)
    frequency_start_date = params["week_start_date"]
    frequency_end_date = params["week_end_date"]
    frequency_start_date = Date.strptime(frequency_start_date, "%m/%d/%Y")
    frequency_end_date = Date.strptime(frequency_end_date, "%m/%d/%Y")

    episode = TreatmentEpisode.user_scope.find(params[:episode_id])

    frequency_start_date = episode.start_date if frequency_start_date < episode.start_date
    frequency_end_date = episode.end_date if frequency_end_date > episode.end_date

    value = params["value"]
    arr = params["field_name"].split("-")
    discipline_code = arr[2]
    discipline = Discipline.find_by_discipline_code(discipline_code)

    visit_frequencies = VisitFrequency.where(["treatment_id = ? and treatment_episode_id = ? and discipline_id = ? and
                       frequency_start_date = ? and frequency_end_date = ? and cancelled = ?", params[:treatment_id],
                                              params[:episode_id], discipline.id, frequency_start_date, frequency_end_date, false])
    visit_frequency = visit_frequencies.first

    return if (visit_frequency.nil? and value.to_i == 0)

    if visit_frequency.present? and value.to_i == 0
      visit_frequency.delete
      return
    end

    visit_frequency ||= VisitFrequency.new({discipline_id: discipline.id,
                                                                     treatment_id: params[:treatment_id],
                                                                     treatment_episode_id: params[:episode_id],
                                                                     frequency_start_date: frequency_start_date,
                                                                     frequency_end_date: frequency_end_date
                                                                    })
    visit_frequency.frequency_string = value + "WK1"

    episode_visit_count = episode.treatment_visits.where(["treatment_visits.discipline_id = ?", discipline.id]).select {|tv| tv.visit_date.between?(frequency_start_date, frequency_end_date)}.count
    visit_frequency.visits_count = episode_visit_count
    visit_frequency.save!
  end

  def visit_is_deleted
    self.visits_count = visits_count - 1
    self.save!
  end

  def self.get_visit_frequency_using_date(params)
    VisitFrequency.where(["discipline_id = ? AND treatment_id = ? AND treatment_episode_id = ? AND
                        cancelled = ? AND frequency_start_date <= ? and frequency_end_date >= ?", params[:discipline_id],
                          params[:treatment_id], params[:treatment_episode_id], false, params[:date], params[:date]]).first
  end

  private

  def check_dates_are_valid
    if treatment_episode
      if self.frequency_start_date.nil? or (self.frequency_start_date < self.treatment_episode.start_date)
        self.errors.add(:frequency_start_date, "should be within certification period")
      elsif self.frequency_end_date.nil? or (self.frequency_end_date > self.treatment_episode.end_date)
        self.errors.add(:frequency_string, "invalid. Frequency string should be within certification period")
      end
    end
  end

  def set_start_date_and_end_date
    return unless self.class.frequency_string_valid?(frequency_string)
    self.frequency_start_date = compute_start_date unless self.frequency_start_date
    self.frequency_end_date = compute_end_date(self.frequency_start_date) unless self.frequency_end_date
  end

  def set_defaults
    self.medical_order_id = -1
  end

  def set_status
    self.frequency_status = :draft
  end

end
