require "patient_medicare_eligibility_info"
require 'extracter_of_271'
require 'html_view_of_271'
class CheckMedicareEligibilityDetails < Mahaswami::Panel

  include Mahaswami::NetzkeBase

  def configuration
    c = super
    component_session[:treatment_request_id] ||= c[:treatment_request_id]
    component_session[:treatment_id] ||= c[:treatment_id]
    component_session[:patient_details] ||= c[:patient_details]
    c.merge(
      header:  false,
      autoScroll: true,
      item_id: :check_medicare_eligibility_details,
      bbar: [
          {name: :service_type, field_label: "Service Type", item_id: :service_type, xtype: :combo, 
          store: service_type_store, width: 350, margin: 5},
          {name: :start_date, field_label: "Start Date", item_id: :start_date, xtype: :datefield, margin: 5, value: Date.today}
      ] + [:run.action, :run_and_show_raw.action, :cancel.action]
    )
  end

  action :run, text: "Run", icon: false
  action :run_and_show_raw, text: "RAW(Dbg)", icon: false
  action :cancel, text: "", tool_tip: 'Cancel', icon: :cancel_new

  js_method :on_run, <<-JS
    function(){
      var serviceType = this.down('#service_type').value;
      var startDate = this.down('#start_date').value;
      if(startDate == null && serviceType != null)
        Ext.MessageBox.alert("Status", "Invalid Date. Please try again.");
      else if(startDate != null && serviceType == null)
        Ext.MessageBox.alert("Status", "Invalid Service Type. Please try again.");
      else if (startDate == null && serviceType == null)
        Ext.MessageBox.alert("Status", "Invalid Service type and Date. Please try again.");

      this.setLoading(true);
      this.update({service_type: serviceType, start_date: startDate}, function() {
        this.setLoading(false);
      });
    }
  JS

  js_method :on_run_and_show_raw, <<-JS
    function(){
      var serviceType = this.down('#service_type').value;
      var startDate = this.down('#start_date').value;
      if(startDate == null && serviceType != null)
        Ext.MessageBox.alert("Status", "Invalid Date. Please try again.");
      else if(startDate != null && serviceType == null)
        Ext.MessageBox.alert("Status", "Invalid Service Type. Please try again.");
      else if (startDate == null && serviceType == null)
        Ext.MessageBox.alert("Status", "Invalid Service type and Date. Please try again.");

      this.setLoading(true);
      this.updateRaw({service_type: serviceType, start_date: startDate}, function() {
        this.setLoading(false);
      });
    }
  JS


  js_method :on_cancel, <<-JS
    function(){
      this.up('window').close();
    }
  JS

  endpoint :update do |params|
    # updateBodyHtml is a JS-side method we inherit from Netkze::Basepack::Panel
    {:update_body_html => body_content(params)}
  end

  endpoint :update_raw do |params|
    # updateBodyHtml is a JS-side method we inherit from Netkze::Basepack::Panel
    show_raw_flag = true
    {:update_body_html => body_content(params, show_raw_flag )}
  end

  # HTML template used to display the stats
  def body_content(params, show_raw = false)
    p = PatientMedicareEligibilityInfo.new("9999999990", "Metro", "Praveen", "K", Date.new(2014, 5, 19), "123456789A")
    #edi_content = p.medicare_eligibility_271_edi_content
    #hcpc_codes_file_path = File.join(Rails.root, 'static_data', 'hcpc_codes', 'hcpc_2013.csv')
    data_hash = p.generate_eligibility_xml
    debug_log data_hash
    if data_hash == {}
      %Q(
        <html><body style='font-color: red'><h1>Error fetching Eligibility Information. Possible Reasons: 
        <br>
        <br>
        <h2>1. No matching Patient Information found in Medicare database.
        <h2>2. Temporary Error Contacting Medicare Servers.
        <br>
        <br> 
        <h2> Please double check the information you entered and Try after sometime.
        <h2> If Error persists, please contact Fasternotes Support.</body></html>
      )
    else
      html_content = html_data_from_hash(data_hash)
      %Q(
        #{html_content}
      )
    end
  end

  def hash_from_edi_content(edi_content, hcpc_codes_file_path)
    #Pass hcpc_codes_file_path as second param during Rails call
    extracter = ExtracterOf271.new edi_content, hcpc_codes_file_path
    hsh = extracter.extract
    debug_log hsh
    debug_log hsh.to_xml
    hsh
  end

  def html_data_from_hash(data_hash)
    view = HtmlViewOf271.new data_hash
    view.generate
  end

  def service_type_store
    [["30", "Health Benefit Plan Coverage"],
     ["42", "Home Health Care"],
     ["AG", "Skilled Nursing Care"],
     ["47", "Hospitalization"],
     ["15", "Other"],
     ["98", "Physician Visit - Office"],
     ["14", "Renal Supplies"],
     ["45", "Hospice"],
     ["1", "Medical Care"],
     ["86", "Emergency Services"]
    ]
  end
  
  js_method :init_component, <<-JS
    function() {
      this.callParent();
      var cmb = this.down('#service_type');
      // 1 = Home Health Care
      cmb.setValue(cmb.getStore().getAt(1));
      Ext.Function.defer(function() { this.onRun(); }, 200, this);
    }
  JS
    
end
