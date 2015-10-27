class PatientInsuranceCompanyForm < Mahaswami::FormPanel

  def configuration
    s = super
    s.merge(
        model: "PatientInsuranceCompany",
        item_id: :pat_ins_comp_add_form,
        items: [
            {name: :insurance_company__company_name, field_label: "Name", scope: :ins_scope, item_id: :insurance_company, allowBlank: false},
            {name: :patient_insurance_number, field_label: "Insurance Number", allowBlank: false, item_id: :patient_number},
            {xtype: 'combo', name: :relation_to_insured, label: "Relation to Insured", store: PatientInsuranceCompany::RELATIONSHIPS, editable: false},
            {name: :effective_date, field_label: "Effective Date", allowBlank: false},
            {name: :termination_date, field_label: "Termination Date"},
            {name: :primary_insurance_flag, field_label: "Primary Insurance"},
            {name: :coverage_details, field_label: "Coverage Details", rows: 10, cols: 30}
        ]
    )
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();

      this.down("#insurance_company").on("select", function(ele){
        if(ele.value){
          this.isMedicareInsurance({ins_com_id: ele.value}, function(res){
            if(res){
              medicareNumber = Ext.ComponentQuery.query("#medicare_number")[0].value;
              this.down("#patient_number").setValue(medicareNumber);
            }else{
              this.down("#patient_number").setValue();
            }
          }, this);
        }
      }, this);
    }
  JS

  endpoint :is_medicare_insurance do |params|
     res = if Org.current.insurance_companies.find(params[:ins_com_id]).medicare?
              Patient.find(config[:strong_default_attrs][:patient_id]) if config[:strong_default_attrs][:patient_id]
           else
             false
           end
    {set_result: res}
  end
end