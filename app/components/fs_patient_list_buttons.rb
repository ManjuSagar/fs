class FsPatientListButtons < Mahaswami::Panel
  def configuration
    s = super
    s.merge!(
        margin: '-1px',
        :bbar => ['->', :view_patient_chart.action]
    )
  end
  action :view_patient_chart, text: 'View Chart'

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      this.list = this.up('#patient_list_explorer').down('#patients_list');
    }

  JS

  js_method :on_view_patient_chart, <<-JS
    function(){
      this.list.onViewPatientChart();
    }
  JS

end