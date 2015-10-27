class ConsltngCmpnyHAs < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge(
        model: "ConsultingCompanyHealthAgency",
    )
  end
end