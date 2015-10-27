class ChartSample < Mahaswami::Panel

  js_base_class "Ext.chart.Chart"
  #js_mixin

  js_method :init_component, <<-JS
    function() {
      this.store = Ext.create('Ext.data.JsonStore', {
          fields: ['name', 'data1', 'data2', 'data3', 'data4', 'data5'],
          data: [
              { 'name': 'Bathing',   'data1': rand(1..5)},
              { 'name': 'Toileting',   'data1': rand(1..5)},
              { 'name': 'Shopping',   'data1': rand(1..5)},
              { 'name': 'Transfers',   'data1': rand(1..5)},
              { 'name': 'Bed Mobility',   'data1': rand(1..5)},
              { 'name': 'Medication',   'data1': rand(1..5)},
              { 'name': 'Feeding',   'data1': rand(1..5)},
              { 'name': 'Ambulation',   'data1': rand(1..5)},

          ]
      });
      this.callParent();
    }
  JS
  def configuration
    {
        width: 500,
        height: 300,
        animate: true,
        shadow: false,
        axes: [
            {
                type: 'Numeric',
                position: 'left',
                fields: ['data1', 'data2'],
                grid: true,
                minimum: 0
            },
            {
                type: 'Category',
                grid: true,
                position: 'bottom',
                fields: ['name'],
                title: 'ADL\'s'
            }
        ],
        series: [
            {
                type: 'scatter',
                highlight: {
                    size: 7,
                    radius: 7
                },
                axis: 'left',
                xField: 'name',
                yField: 'data1',
                markerConfig: {
                    type: 'circle',
                    size: 4,
                    radius: 4,
                    'stroke-width' => 0
                }
            },
            {
                type: 'line',
                highlight: {
                    size: 3,
                    fill: 'red'
                },
                axis: 'left',
                fill: false,
                xField: 'name',
                yField: 'data3',
                showMarkers: false,
                markerConfigx: {
                    type: 'circle',
                    size: 4,
                    radius: 4,
                    'stroke-width' => 0
                }
            }
        ]
    }
  end

  js_method :labelrenderer, <<-JS
    function(v) {
      return "X";
    }
  JS
end