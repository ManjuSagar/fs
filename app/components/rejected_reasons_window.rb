class RejectedReasonsWindow < Netzke::Basepack::Window

  def configuration
    s = super
    s.merge(
        width: "30%",
        height: "50%",
        modal: true,
        layout:'fit',
        items: [:rejected_reasons_list.component],
        bbar: ['->', :ok.action],
        title: "Rejected Reasons"
    )
  end

  action :ok, icon: :cancel_new, text: ""

  js_method :on_ok,<<-JS
    function(){
      this.close();
    }
  JS

  component :rejected_reasons_list do
    {
        class_name: "RejectedReasonsList",
        rejected_reasons: config[:rejected_reasons]
    }
  end
end
