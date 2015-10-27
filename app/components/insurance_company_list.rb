class InsuranceCompanyList < Mahaswami::GridPanel

  def configuration
    super.merge(
      model: 'InsuranceCompany',
      title:  'Insurance Companies',
      item_id: :ins_cmpns_list,
      columns: [
        {name: :company_name, label: "Name", width: "15%", editable: false},
        {name: :company_code, label: "Code", width: "10%", editable: false},
        {name: :certification_period, label: "Certification Period", width: "10%", editable: false},
        {name: :co_pay_applicable, label: "Copay Applicable", width: "13%", editable: false},
        {name: :claim_phone_number, label: "Claim Phone Number", width: "17%", editable: false},
        {name: :authorization_phone_number, label: "Authorization Phone Number", width: "18%", editable: false},
        {name: :payer_id, label: "Payer Id", width: "20%", editable: false}
      ],
      scope: :ins_scope
    )
  end

  def default_bbar
    [:new_edit_form.action, :edit_in_form.action]
  end

  def default_context_menu
    [:new_edit_form.action, :edit_in_form.action]
  end

  action :edit_in_form, text: "", tooltip: "Edit Insurance Company", item_id: :edit_ins_compny_button
  action :new_edit_form, text: "", tooltip: "Add Insurance Company", icon: :add_new, item_id: :add_ins_compny_button

  edit_form_config class_name: "AddInsuranceCompany", mode: "edit"

  edit_form_window_config width: "65%", height: "77%", title: "Edit Insurance Company"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
      this.on('itemclick', function(view, record){
        this.selectRecord({insurance_company_id: record.get('id')});
      }, this);
    }
  JS
  
  endpoint :select_record do |params|
    component_session[:selected_ins_comp_id] = params[:insurance_company_id]
  end
  
  js_method :on_edit_in_form, <<-JS
    function(){
      this.callParent();
      this.visitTypeRate({mode: "edit"}, function(result){
        Ext.ComponentQuery.query('#ins_comp_visit_type_rate_grid')[0].store.load();
      });
    }      
  JS

  endpoint :create_new_record_and_return_id do |params|
    sample_ins_company = Org.current.insurance_companies.build
    sample_ins_company.draft_status = true
    sample_ins_company.save(:validate => false)
    InsuranceCompany.apply_visit_type_rates(sample_ins_company.id)
    {:set_result => {:id => sample_ins_company.id}}
  end

  js_method :on_new_edit_form, <<-JS
    function(){
      var recordId = this.createNewRecordAndReturnId({},function(result) {
        var recordId = result.id;
        this.loadNetzkeComponent({name: "edit_form",
          params: {record_id: recordId},
          callback: function(w){
            w.show();
            w.setTitle("Add Insurance Company");
            w.on('close', function(){
              if (w.closeRes === "ok") {
                this.store.load();
              }
            }, this);
          }, scope: this});
      });
    }
  JS

  js_method :on_add_in_form, <<-JS
    function(){
      this.callParent();
      this.visitTypeRate({mode: "add"}, function(result){
        Ext.ComponentQuery.query('#ins_comp_visit_type_rate_grid')[0].store.load();
      });
    }
  JS

  endpoint :visit_type_rate do |params|
    InsuranceCompany.apply_visit_type_rates(component_session[:selected_ins_comp_id])
    {:set_result => true}
  end

end
