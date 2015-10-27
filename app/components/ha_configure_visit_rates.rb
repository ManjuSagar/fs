class HaConfigureVisitRates < Mahaswami::FormPanel

  def initialize(conf = {}, parent = nil)
    super
    self.config[:items].each do |item|      
      if(item[:items])
        item[:items].each do |i|
          i[:read_only] = true
        end
      end
    end    
  end
    
  def configuration
    c = super
    component_session[:selected_insurance_company_id] =  c[:record_id]
    c.merge(
      model: 'InsuranceCompany',
      layout: :border,
      items: [
		{xtype: :fieldset, title: "Company Details", region: :north, height: 150, items: [
			{name: :company_name, field_label: "Name", width: 400},
			{name: :company_code, field_label: "Code"},
			{name: :certification_period, field_label: "Certification Period"},
			{name: :co_pay_applicable, field_label: "Copay Applicable"}
		]},
        :ins_comp_visit_rate_list.component
      ]
    )
    
  end
  
  component :ins_comp_visit_rate_list do
    {
	  region: :center,
      class_name: "InsCompVisitRateList",
      association: "insurance_company_visit_type_rates",
      parent_model: "InsuranceCompany",
      item_id: :ins_comp_visit_type_rate_grid,
      parent_id: component_session[:selected_insurance_company_id] 
    }
  end

  js_method :on_apply, <<-JS
    function(){
      var insVtRates = this.down('#ins_comp_visit_type_rate_grid');
      insVtRates.onApply();
      this.callParent();
    }
  JS
  
end
