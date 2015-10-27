class MedicalOrders < Mahaswami::HasManyCollectionList
  association "medical_orders"
  parent_model "PatientTreatment"

  def initialize(conf = {}, parent_id = nil)
    super
    return unless component_session[:treatment_id]
    mo_instance = PatientTreatment.find(component_session[:treatment_id]).medical_orders.build
    components[:add_form].merge!( header: {
                                       titlePosition: 0,
                                       items:  [{xtype:'button',
                                                 text: "View Medications",
                                                 item_id: :md_oder_medication,
                                                }]})
    components[:add_form][:items].first.merge!(:parent_id => component_session[:treatment_id], :record => mo_instance)

    components[:edit_form].merge!( header: {
                                       titlePosition: 0,
                                       items:  [{xtype:'button',
                                                 text: "View Medications",
                                                 item_id: :md_oder_medication,
                                                }]})
    components[:edit_form][:items].first.merge!(:parent_id => component_session[:treatment_id])
  end

  def configuration
    s = super
    component_session[:treatment_id] = component_session[:parent_id]
    s.merge(
        model: 'MedicalOrder',
        title: 'Medical Orders',
        item_id: :medical_order_grid,
        parent_id: s[:parent_id],
        columns: [{name: :order_date, label: "Order Date", editable: false, width: "8%"},
                  {name: :treatment_episode__certification_period, label: "Episode", editable: false, width: "15%"},
                  {name: :physician__full_name, label: "Physician", editable: false, width: "10%"},
                  {name: :order_type__type_description, label: "Category", editable: false, width: "20%"},
                  {name: :attachment, width: "16%", label: "Attachment", getter: lambda{ |r| download_links(r) }},
                  {name: :order_status, label: "Status", editable: false, :getter => lambda{|l|l.order_status.to_s.titleize}, width: "13%"},
                  action_column("medical_order_grid")
                ],
        scope: (s[:episode_orders] ? {treatment_episode_id: s[:episode_id]} : s[:scope])

    )
  end

  def download_links(mo)
    links = []
    links << link_to("Printable Order", mo.printable_order.url, :target => "_blank") if mo.printable_order?
    links << link_to("Signed Order", mo.signed_order.url, :target => "_blank") if mo.signed_order.exists?
    links.join(" | ")
  end

  def action_column(grid_component_name = nil)
    comp_name = grid_component_name || self.class.name.underscore
    {name: :actions, flex: 1, label: "", editable: false,
     :getter => lambda {|x| x.events_for_current_state.collect{|r|
       link_to_function(human_action_name(x, r), perform_event(comp_name, x, r), {id: "record_#{x.id}"})}.join(" | ")
     }
    }
  end

  def human_action_name(mo, event)
    if event.name == :send_to_physician
      mo.physician.default_email? ? "Mark Sent" : "Email Order"
    elsif event.name == :mark_order_received
      "Receive"
    else
      event.title
    end
  end

  def default_bbar
    return [] if (Org.current.is_a? StaffingCompany)
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    return [] if (Org.current.is_a? StaffingCompany)
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "", tooltip: 'Add Order'
  action :edit_in_form, text: "", tooltip: 'Edit Order'

  add_form_window_config width: "50%", height: "80%"
  edit_form_window_config width: "50%", height: "80%"
  add_form_config class_name: "MedicalOrderAddForm"
  edit_form_config class_name: "MedicalOrderEditForm"

  def perform_event(comp_name, record, event)
    if event == :mark_order_received
      <<-JS
      var g = Ext.ComponentQuery.query("##{comp_name}")[0];
      g.selectMoId({mo_id: "#{record.id}"});
      g.loadNetzkeComponent({name: "signed_order_upload", callback: function(w){
        w.show();
        w.on('close', function(){
          if (w.closeRes === "ok") {
            g.performAction(#{record.id}, "#{event.name}");
          }
        }, this);
      }, scope: g});
      JS
    elsif event == :sign
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.selectMoId({mo_id: "#{record.id}"}, function(){
          var w1 = new Ext.window.Window({
            width: "25%",
            height: "25%",
            modal: true,
            layout:'fit',
            title: "Electronic Signature",
          });
          w1.show();
          g.loadNetzkeComponent({name: "verify_user_authentication", container:w1, callback: function(w){
            w.show();
            w.on('close', function(){
              if (w.signRes === true) {
                g.performAction(#{record.id}, "#{event.name}");
                //g.store.load();
                w1.close();
              }
            }, this);
          }});
        }, this);
      JS
    else
      super
    end
  end

  component :verify_user_authentication do
    {
        class_name: "VerifyUserAuthentication",
        record_klass: "MedicalOrder",
        record_id: component_session[:selected_mo_id]
    }
  end

  endpoint :select_mo_id do |params|
    component_session[:selected_mo_id] = params[:mo_id].to_i
  end

  component :signed_order_upload do
    form_config = {
        class_name: "MedicalOrderUploads",
        record_id: component_session[:selected_mo_id],
        bbar: false,
        header: false,
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :auto_width => true,
        :auto_height => true,
        :title => "Upload File",
        :button_align => "right",
        :items => [form_config]
    }
  end


end