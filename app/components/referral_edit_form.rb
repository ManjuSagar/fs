class ReferralEditForm < ReferralNewForm
  def initialize(conf = {}, parent = nil)
    super
    config[:record_id] ||= component_session[:treatment_request_id]
    record = (record.nil? and config[:record_id])? TreatmentRequest.find(config[:record_id]) : record
  end

  def configuration
    c = super
    component_session[:treatment_request_id] ||= c[:record_id] if c[:record_id]
    @referral = TreatmentRequest.find_by_id(c[:record_id]) if c[:record_id]
    referral_received_flag = @referral.present?? (@referral.referral_received_flag.nil? || @referral.referral_received_flag) : true
    c.merge(
        model: "TreatmentRequest",
        item_id: :referral_edit_form,
        bbar: get_bbar(c[:bbar]),
        record: (TreatmentRequest.find(c[:record_id]) if c[:record_id])
    )
  end

  def get_bbar(bbar)
    return bbar if @referral.nil?
    bbar ? (bbar + [:delete_referral.action]) : [:delete_referral.action]
  end

  action :apply, text: ""
  action :delete_referral, text: "", tooltip: "Delete Referral", icon: :delete_new

  js_method :on_delete_referral,<<-JS
    function(){
      this.checkCanDeleteReferral({}, function(res){
        if(res){
          Ext.MessageBox.confirm("Confirmation", "Are you sure?", function(btn){
            if(btn == "yes"){
              this.deletePatientReferral({}, function(res){
                var main_app = Ext.ComponentQuery.query("#app")[0];
                main_app.loadPatientsList();
              }, this);
            }
          }, this);
        } else {
          Ext.MessageBox.alert("Status", "Referral cannot be deleted.<br/><br/> <b>Reason:</b><br/><br/>Patient is admitted.");
        }
      }, this);
    }
  JS

  endpoint :check_can_delete_referral do |params|
    res = (not @referral.admitted?)
    {set_result: res}
  end

  endpoint :delete_patient_referral do |params|
    res = @referral.destroy
    {set_result: res}
  end

  endpoint :select_patient_id do |params|
    component_session[:patient_id] = params[:patient_id]
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      this.createAudit({referral_id: this.record.id});


      visit_type_ids = this.query("[name=visit_type_ids]");
      Ext.each(visit_type_ids, function(vi_type_id, index){
        vi_type_id.on('change', function(ele){
          if(ele.checked == false){
            this.setLoading(true);
            this.checkVisitTypeCanBeRemoved({visit_type_id: ele.inputValue}, function(res){
              this.setLoading(false);
              if (!res){
                ele.setValue(true);
                Ext.MessageBox.alert("Status", "At least one visit, document or order exists for this discipline in the" +
                  " patient's record. Either delete the existing visit, document or order, to delete the visit type," +
                  " OR discharge the visit type.");
              }
            }, this);
          }
        }, this);
      }, this);
    }
  JS

  endpoint :check_visit_type_can_be_removed do |params|
    res = @referral.can_remove_visit_type(params[:visit_type_id])
    {set_result: res}
  end

  endpoint :create_audit do |params|
    request = TreatmentRequest.find(params[:referral_id])
    request.user_viewing_changed_attr_value = request.certification_period
    request.certification_period = -54321
    request.audit_comment = "User View"
    request.save(validate: false)
    {}
  end
end
