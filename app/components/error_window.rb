class ErrorWindow < Netzke::Basepack::Window

  def configuration
    s = super
    s.merge(
        width: "30%",
        height: "50%",
        modal: true,
        layout:'fit',
        items: [:errors_list.component],
        bbar: ['->', :ok.action],
        title: "Errors - No. of errors: " + s[:errors].length.to_s
    )
  end

  action :ok, icon: :save_new, text: ""

  js_method :on_ok,<<-JS
    function(){
      this.close();
    }
  JS

  component :errors_list do
    {
        class_name: "ErrorList",
        errors: config[:errors]
    }
  end
end