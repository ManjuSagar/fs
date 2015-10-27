module ReportDataSource
  class CostReportPpsActivityData
    include CostReportRelatedMethods
    attr_accessor :year

    def initialize(year)
      @year = year
      @pep_episodes = pep_episodes
      @fewoo_episodes = fewoo_episodes
      @lupa_episodes = lupa_episodes
    end

    def pps_visits
      visits = []
      totals = []
      visits << get_pps_visits_list_by_discipline
      count = 41
      pps_visits = {fewoo: total_visits_of_pps_visits(@fewoo_episodes), fewto: [], lupa: total_visits_of_pps_visits(@lupa_episodes),
                      pep: total_visits_of_pps_visits(@pep_episodes), scicp: [], scic: []}

      visits << get_total_visits(pps_visits, count)
      count = count + 1

      visits << {:description => "Other Charges", :full_episode_with_out_outliers => 0,
                 :full_episode_with_outliers => 0, :lupa_episodes => 0, :pep_only_episodes => 0, :scic_within_a_pep => 0,
                 :scic_only_episodes => 0, :totals => 0, :count => (count += 1)}

      visits << get_total_charges(pps_visits, count)

      count = count + 1

      visits << get_episodes_by_episode_type({episode_types: ["FEWOO", "LUPA", "PEP", "SCICP", "SCIC"], count: count, msg: "Total Number of Episodes"})
      count = count + 1

      visits << get_episodes_by_episode_type({episode_types: ["FEWTO"], count: count, msg: "Total Number of Outlier Episodes"})
      count = count + 1

      visits << get_supply_charges(count)
      visits.flatten
    end

    def get_pps_visits_list_by_discipline
      visits = []
      count = 29
      fewoo_visits = group_by_discipline_episode_visits(@fewoo_episodes)

      #fewto_visits = group_by_discipline_episode_visits([])
      lupa_visits = group_by_discipline_episode_visits(@lupa_episodes)
      pep_visits = group_by_discipline_episode_visits(@pep_episodes)
      #scicp_visits = group_by_discipline_episode_visits([])
      #scic_visits = group_by_discipline_episode_visits([])
      disciplines_for_cost_report.each_with_index do |dis, i|
        id = dis.id
        visits_count = {fewoo: (fewoo_visits.present? and fewoo_visits[id].present?) ? fewoo_visits[id] : [] , fewto: [],
                        lupa: (lupa_visits.present? and lupa_visits[id].present?) ? lupa_visits[id] : [],
                        pep: (pep_visits.present? and pep_visits[id].present?)  ? pep_visits[id]: [], scicp: [], scic: []}
        msg = dis.discipline_description
        visits << get_visits_count_by_discipline(visits_count, msg, count)
        count =  count + 1

        visits << get_pps_visits_cost(visits_count, msg, count)
        count = count + 1
      end
      visits
    end

    def get_pps_visits_cost(visits_count, msg, count)

      message = case msg
                  when "Speech Therapy" then "Speech Pathology"
                  when "Social Worker"  then "Medical Social Services"
                  else
                    msg
                end
      pps_visit_cost  = {:full_episode_with_out_outliers => charges_for_pps_visits(visits_count[:fewoo]),
                         :full_episode_with_outliers => charges_for_pps_visits(visits_count[:fewto]),
                         :lupa_episodes => charges_for_pps_visits(visits_count[:lupa]),
                         :pep_only_episodes => charges_for_pps_visits(visits_count[:pep]),
                         :scic_within_a_pep => charges_for_pps_visits(visits_count[:scicp]),
                         :scic_only_episodes => charges_for_pps_visits(visits_count[:scic])}

      pps_visit_cost.merge!({:totals => pps_visit_cost.values.sum, :count => (count += 1), :description => "#{message} Charges" })
    end

    def get_total_visits(visits, count)

      total_visits_count = {:full_episode_with_out_outliers => visits[:fewoo].size,
                            :full_episode_with_outliers => visits[:fewto].size, :lupa_episodes => visits[:lupa].size,
                            :pep_only_episodes => visits[:pep].size, :scic_within_a_pep => visits[:scicp].size,
                            :scic_only_episodes => visits[:scic].size}

      total_visits_count.merge!({:totals => total_visits_count.values.sum, :count => (count += 1),
                                 :description => "Total Visits (Sum of Lines 30, 32, 34, 36, 38, 40)" })
    end

    def get_total_charges(visits, count)
      total_charges  = {:full_episode_with_out_outliers => charges_for_pps_visits(visits[:fewoo]),
                        :full_episode_with_outliers => charges_for_pps_visits(visits[:fewto]),
                        :lupa_episodes => charges_for_pps_visits(visits[:lupa]),
                        :pep_only_episodes => charges_for_pps_visits(visits[:pep]),
                        :scic_within_a_pep => charges_for_pps_visits(visits[:scicp]),
                        :scic_only_episodes => charges_for_pps_visits(visits[:scic]) }

      total_charges.merge!({:totals => total_charges.values.sum, :count => (count += 1),
                            :description => "Total Charges (Sum of lines 31, 33, 35, 37, 39, 41, 43)" })
    end

    def get_episodes_by_episode_type(params)
      episode_types = params[:episode_types]
      episodes = {:full_episode_with_out_outliers => get_episodes("FEWOO", episode_types),
                  :full_episode_with_outliers => get_episodes("FEWTO", episode_types), :lupa_episodes => get_episodes("LUPA", episode_types),
                  :pep_only_episodes => get_episodes("PEP", episode_types), :scic_within_a_pep => get_episodes("SCICP", episode_types),
                  :scic_only_episodes => get_episodes("SCIC", episode_types)}

      episodes.merge!({:totals => episodes.values.sum, :count => (params[:count] += 1),
                       :description => params[:msg]})
    end

    def get_supply_charges(count)
      supply_charges = {:full_episode_with_out_outliers => total_non_routine_supply_charges("FEWOO"),
                        :full_episode_with_outliers => total_non_routine_supply_charges("FEWTO"),
                        :lupa_episodes => total_non_routine_supply_charges("LUPA"),
                        :pep_only_episodes => total_non_routine_supply_charges("PEP"),
                        :scic_within_a_pep => total_non_routine_supply_charges("SCICP"),
                        :scic_only_episodes => total_non_routine_supply_charges("SCIC")}
      supply_charges.merge!({:description => "Total Non-Routine Medical Supply Charges",
                             :totals => supply_charges.values.sum, :count => (count += 1)})
    end

    def total_non_routine_supply_charges(episode_type)
      episodes = total_number_of_episodes(episode_type)
      episodes.collect { |epi| epi.service_units}.sum
    end


    def get_episodes(element, episode_types)
      (episode_types.include? element) ? total_number_of_episodes(element).size : 0
    end

    def total_number_of_episodes(episode_type)
      res = if episode_type == 'PEP'
        pep_episodes
      elsif episode_type == 'LUPA'
        lupa_episodes
      elsif episode_type == 'FEWOO'
        fewoo_episodes
      else
        []
      end
      res
    end

    def pep_episodes
      treatments = PatientTreatment.org_scope.includes(:treatment_request).includes(:treatment_activities).where(["treatment_requests.insurance_company_id = ?
                            and treatment_activities.activity_type = 'D' and treatment_activities.activity_reason_code = '06'", medicare_insurance.id])
      pep_episodes = treatments.collect{|treatment| treatment.last_episode}
      pep_episodes = pep_episodes.select{|episode| (episode.start_date.year == year and [:lupa_billed, :final_claim_billed].include? (episode.medicare_bill_status))}
    end

    def lupa_episodes
      episodes = get_episodes_by_type("L")
      lupa_episodes = episodes - pep_episodes
    end

    def get_episodes_by_type(billing_status)
      episodes = TreatmentEpisode.org_scope.includes(:treatment => :treatment_request).where({:treatment_requests =>
                    {:insurance_company_id => medicare_insurance.id}}).where("
                 EXTRACT(YEAR FROM treatment_episodes.start_date) = #{year} AND treatment_episodes.medicare_bill_status = '#{billing_status}'")
    end

    def fewoo_episodes
      episodes =  get_episodes_by_type("F")
      fewoo_episodes = episodes - pep_episodes
    end

    def total_visits_of_pps_visits(episodes)
      visits = []
      return visits if episodes.empty?
      episodes = episodes.map(&:id)
      visits = TreatmentVisit.org_scope.where(["visit_status = 'C' AND EXTRACT(YEAR FROM visit_start_time) = #{year} AND
         treatment_episode_id IN (?)", episodes])
      visits
    end

    def group_by_discipline_episode_visits(episodes)
      visits = []
      return visits if episodes.empty?
      episodes = episodes.map(&:id)
      visits = TreatmentVisit.org_scope.where(["visit_status = 'C' AND EXTRACT(YEAR FROM visit_start_time) = #{year} AND
         treatment_episode_id IN (?)",episodes]).group_by(&:discipline_id)
      visits
    end

    def get_visits_count_by_discipline(visits_count, msg, count)
      message = case msg
                  when "Speech Therapy" then "Speech Pathology"
                  when "Social Worker"  then "Medical Social Service"
                  else
                    msg
                end
      pps_visit = {:full_episode_with_out_outliers => get_visits_count(visits_count, :fewoo),
                   :full_episode_with_outliers => get_visits_count(visits_count, :fewto),
                   :lupa_episodes => get_visits_count(visits_count, :lupa),
                   :pep_only_episodes => get_visits_count(visits_count, :pep),
                   :scic_within_a_pep => get_visits_count(visits_count, :scicp),
                   :scic_only_episodes => get_visits_count(visits_count, :scic)}

      pps_visit.merge!({:totals => pps_visit.values.sum, :count => (count += 1), :description => "#{message} Visits"})
    end

    def get_visits_count(visits, type)
      visits[type].present? ? visits[type].size : 0
    end

    def lupa_visits_by_discipline(dis)
      res = lupa_visits_group_by_discipline
      visits = res.to_hash.detect{|x| x["discipline_id"] == dis.to_s}
      res = visits.present? ? visits["count"] : 0
    end

    def charges_for_pps_visits(visits)
      cost = if visits
                visits.collect{|v| v.receivable_amount(medicare_insurance).to_i}.sum.to_i
             else
               0
             end
    end


    def medicare_insurance
      return @ins_company if defined?(@ins_company)
      @ins_company = InsuranceCompany.where(company_code: 'MEDICARE', org_id: Org.current.id).first
    end
  end
end

