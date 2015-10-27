class AdlChartData

  def initialize(treatment, episode)
    @treatment = treatment
    @episode = episode
  end

  def entries(type)
    #type could be bathing, toileting etc.  Currently we are just sending dummy data
    @episode.treatment_visits.collect{|v| {date: v.visit_start_time.strftime("%m/%d(%H:%M)"), data: rand(5)}}
  end
end