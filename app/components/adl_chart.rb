class AdlChart < Netzke::Base
  include Mahaswami::NetzkeBase
  js_base_class "Ext.chart.Chart"

  def initialize(conf = {}, parent = nil)
    @type= conf[:type]
    @treatment = PatientTreatment.find(parent.parent.component_session[:treatment_id]);
    @episode =  TreatmentEpisode.find(parent.parent.component_session[:episode_id])
    @patient = @treatment.patient
    super
  end

  js_method :init_component, <<-JS
    function() {
      this.store = Ext.create('Ext.data.JsonStore',
        {fields: ['date', 'data']}
      );
      this.getData({}, function(data) {
        this.store.loadData(data);
      }, this);
      console.log(this);
      this.callParent();
    }
  JS

  endpoint :get_data do |params|
    {
        set_result: AdlChartData.new(@treatment, @episode).entries(@type)
    }
  end
def configuration
    s = super
    s.merge({
            width: 500,
            height: 300,
            animate: true,
            shadow: false,
            title: @type,
            axes: [
                {
                    type: 'Numeric',
                    position: 'left',
                    fields: ['data'],
                    title: '',
                    grid: true,
                    minimum:0,
                    maximum:5,
                    decimals: 0
                },
                {
                    type: 'Category',
                    position: 'bottom',
                    fields: ['date'],
                    label: {rotate: {degrees: 0}},
                }
            ],
            series: [
                {
                    type: 'line',
                    axis: 'left',
                    xField: 'date',
                    yField: 'data',
                    smooth: true,
                    fill: false,
                    markerConfig: {
                        type: 'circle',
                        size: 2,
                        radius: 3,
                        fill: :blue,
                        'stroke-width' => 0
                    }
                }
            ]
        })
  end

end