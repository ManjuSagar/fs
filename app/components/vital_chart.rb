class VitalChart < Netzke::Base
  include Mahaswami::NetzkeBase
  js_base_class "Ext.chart.Chart"

  js_method :init_component, <<-JS
    function() {
      this.store = Ext.create('Ext.data.JsonStore',
        {fields: ['date', 'value', 'max', 'min']}
      );
      this.getData({}, function(data) {
        this.store.loadData(data);
      }, this);
      this.callParent();
    }
  JS

  endpoint :get_data do |params|
    if @vital_parameter == "BP"
      return {set_result: VitalBp.new(@treatment, @episode).entries}
    elsif @vital_parameter == "RR"
      return {set_result: VitalRr.new(@treatment, @episode).entries}
    elsif @vital_parameter == "HR"
      return {set_result: VitalHr.new(@treatment, @episode).entries}
    elsif @vital_parameter == "FBS"
      return {set_result: VitalFastingBloodSugar.new(@treatment, @episode).entries}
    elsif @vital_parameter == "RBS"
      return {set_result: VitalRandomBloodSugar.new(@treatment, @episode).entries}
    elsif @vital_parameter == "O2"
      return {set_result: VitalOxygen.new(@treatment, @episode).entries}
    elsif @vital_parameter == "TEMP"
      return {set_result: VitalTemp.new(@treatment, @episode).entries}
    elsif @vital_parameter == "WEIGHT"
      return {set_result: VitalWeight.new(@treatment, @episode).entries}
    elsif @vital_parameter == "PAIN"
      return {set_result: VitalPain.new(@treatment, @episode).entries}
    end
  end

  def initialize(conf = {}, parent = nil)
    @vital_parameter = conf[:vital_parameter]
    @treatment = PatientTreatment.find(conf[:treatment_id])
    @episode = TreatmentEpisode.find(conf[:episode_id])
    @minimum_y_value  = conf[:minimum_y_value]
    @maximum_y_value = conf[:maximum_y_value]
    super
  end
  def configuration
    super.merge(
    {
        lazy_loading: true,
        title: @vital_parameter,
        animate: true,
        shadow: false,
        axes: [
            {
                type: 'Numeric',
                position: 'left',
                fields: ['value', 'max', 'min'],
                title: '',
                grid: true,
                minimumx: @minimum_y_value,
                maximumx: @maximum_y_value,
                adjust_maximum_by_major_unit: true,
                adjust_minimum_by_major_unit: true
            },
            {
                type: 'Category',
                position: 'bottom',
                fields: ['date'],
            }
        ],
        series: [
            {
                type: 'line',
                axis: 'left',
                xField: 'date',
                yField: 'value',
                smooth: true,
                fill: false,
                markerConfig: {
                    type: 'circle',
                    size: 2,
                    radius: 3,
                    fill: :blue,
                    'stroke-width' => 0
                }
            },
            {
                type: 'line',
                axis: 'left',
                fill: false,
                xField: 'date',
                yField: 'max',
                smooth: true,
                showMarkers: false,
                style: {stroke: 'red',
                        'stroke-width' => '1px',
                        }
            },
            {
                type: 'line',
                axis: 'left',
                fill: false,
                smooth: true,
                xField: 'date',
                yField: 'min',
                showMarkers: false,
                style: {stroke: :red, 'stroke-width' => '1px'}
            }
        ]
    })
  end

  js_method :visit_date_renderer, <<-JS
    function(value) {
      console.log(value);
    }
  JS


end