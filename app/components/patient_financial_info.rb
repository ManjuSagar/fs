class PatientFinancialInfo < Mahaswami::Panel

  def initialize(conf = {}, parent = nil)
    super
    config[:treatment_id] = component_session[:treatment_id]
  end


  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    @treatment = PatientTreatment.find(component_session[:treatment_id])
    @patient = @treatment.patient
    s.merge(
        {
            border: false,
            title: "Financial Information",
            layout: {
                type: 'table',
                columns: 4,
                table_attrs: {
                    style: {width: "100%", "cell-padding" =>  5}
                },
                td_attrs: {
                    style: {
                        padding: "2px"
                    }
                }
            },
            items: []
        })
  end
end
