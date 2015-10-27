class PatientsListButtons < Mahaswami::Panel
  def configuration
    s = super
    s.merge!(
        margin: '-1px',
        :bbar => ['->', :view_patient_schedule.action, {menu: [:add_patient.action,:add_referral.action], text: "", iconCls: 'add_icon'}, {menu: [:worksheet.action, :census_report.action], text: "", iconCls: 'print_icon'}]
    )
  end

  action :view_patient_chart, text: "", tooltip: "Chart", icon: :chart
  action :view_patient_schedule, text: "", tooltip: "Schedule", icon: :schedule
  action :worksheet, text: "Profile", tooltip: "Print"
  action :add_patient, text: "Patient", tooltip: "Add Patient", icon: :patient, itemId: :add_patient_button
  action :add_referral, text: "Referral", tooltip: "Add Referral", icon: :add_new, itemId: :add_referral_button
  action :census_report, text: "Census", tooltip: "Census Report"

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      this.list = this.up('#episodes_list_explorer').down('#episodes_list');
    }

  JS

  js_method :on_view_patient_chart, <<-JS
    function(){
      this.list.onViewPatientChart();
    }
  JS

  js_method :on_view_patient_schedule, <<-JS
    function(){
      this.list.onViewPatientSchedule();
    }
  JS

  js_method :on_worksheet, <<-JS
    function(){
      this.list.onWorksheet();
    }
  JS

  js_method :on_add_patient, <<-JS
    function(){
      this.list.onAddPatient();
    }
  JS

  js_method :on_add_referral, <<-JS
    function(){
      this.list.onAddReferral();
    }
  JS

  js_method :on_census_report, <<-JS
    function(){
      this.list.onCensusReport();
    }
  JS

end