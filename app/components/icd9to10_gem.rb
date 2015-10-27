class Icd9to10Gem < Mahaswami::Panel
  include ActionView::Helpers::NumberHelper
  def configuration
    s = super   
    s.merge(
        title:false,
        header: false,
        frame: false,
        items: [
            :icd9_code.component,
            :mapping_grid.component
        ]
    )
  end


  component :icd9_code do
    {
        :class_name => 'Icd9Code',
        border: false,
        header: false,
        title: false,
        height: 50,
        record_id: config[:record_id],
    }
  end

  component :mapping_grid do
    {
        class_name: "MappingGrid",
    }
  end

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      var g = this;
      var icdCode = Ext.ComponentQuery.query('#icd_9_code')[0];
      var mappingGrid = Ext.ComponentQuery.query('#mapping_gem_grid')[0];
      icdCode.on('select', function(el){
        g.getCodes({icdcode: el.value}, function(res){
         mappingGrid.setLoading(true);
         mappingGrid.store.removeAll();
         mappingGrid.store.add(res);
         mappingGrid.setLoading(false);
        },g);
      });
    }
  JS

  endpoint :get_codes do |params|
    icd10_codes = ProspectivePaymentSystem::Icd9ToIcd10CmGem.new.get_icd10_codes(params[:icdcode])
    {set_result: icd10_codes}
  end

end