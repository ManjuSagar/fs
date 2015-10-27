class Patients < Mahaswami::GridPanel
  def configuration
    super.merge(
        model: "Patient",
        title: "Patients",
        item_id: :org_patients_list,
        columns: [
            {name: :patient_reference, header: "MR#", editable: false},
            {name: :first_name, header: "First Name", editable: false},
            {name: :last_name, header: "Last Name", editable: false}
            ],
        scope: :my_org_patients

    )
  end

  component :add_referral_form do
    form_config = {
        :class_name => "ReferralNewForm",
        :model => "TreatmentRequest",
        :border => true,
        :bbar => false,
        :prevent_header => true,
        :mode => config[:mode],
        :record => data_class.new,
        :patient_id => component_session[:patient_id]
    }

    {
        :height => "70%",
        :width => "50%",
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :title => "Add #{data_class.model_name.human}",
        :button_align => "right",
        :items => [form_config]
    }
  end

  action :add_referral, text: "Add Referral"

  js_method :on_add_referral, <<-JS
    function() {
      this.loadNetzkeComponent({name: "add_referral_form", callback: function(w){
        w.show();
        w.on('close', function(){
          if (w.closeRes === "ok") {
              this.store.load();
          }
        }, this);
      }, scope: this});
    }
  JS

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.actions.addReferral.setDisabled(true);
      this.on('itemclick', function(view, record){
        this.selectPatient({patient_id: record.get("id")});
        this.actions.addReferral.setDisabled(this.getSelectionModel().getCount() != 1);
      }, this);
    }
  JS

  endpoint :select_patient do |params|
    component_session[:patient_id] = params[:patient_id]
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action, :add_referral.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :add_referral.action, :del.action]
  end

  action :add_in_form, text: "Add Patient", itemId: 'AddPatient'
  action :edit_in_form, text: "Edit Patient"

  add_form_config         class_name: "PatientForm"
  add_form_window_config  title: "Add Patient", width: "50%", height: "85%"
  edit_form_config        class_name: "PatientEditForm"
  edit_form_window_config  title: "Edit Patient", width: "50%", height: "85%"
  multi_edit_form_config  class_name: "PatientForm"

end
