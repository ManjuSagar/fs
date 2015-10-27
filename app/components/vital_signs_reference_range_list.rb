class VitalSignsReferenceRangeList < Mahaswami::GridPanel
  # To change this template use File | Settings | File Templates.

  def initialize(conf={}, parent_id = nil)
    super
    if component_session[:vital_id]
      vital = VitalsReferenceRange.find(component_session[:vital_id])
      components[:edit_form].merge!(:title => "Edit #{vital.vital_sign.titleize}")
    end
  end

  def configuration
    c = super
    c.merge(
      model: "VitalsReferenceRange",
      title: "Vital Signs Reference Range",
      bbar: [:edit_in_form.action],
      context_menu: [:edit_in_form.action],
      columns: [{name: :vital_sign, header: "Vital Sign", editable: false, width: "20%",
                 getter: lambda {|r|
                   r.vital_sign.titleize }},
                {name: :minimum_value, header: "Minimum Value", editable: false},
                {name: :maximum_value, header: "Maximum Value", editable: false}
      ],
      scope: :org_scope,
      strong_default_attrs: {:vital_sign => :vital_sign},

    )
  end

  action :edit_in_form, text: "Edit Vital Sign"
  edit_form_config class_name: "VitalSignReferenceRangeForm"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.selectRecord({vital_sign: record.get("id")});
      }, this);
    }
  JS

  endpoint :select_record do |params|
    component_session[:vital_id] = params[:vital_sign]
  end



end