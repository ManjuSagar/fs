module AutoSessionTimeoutHelper
  def auto_session_timeout_js(options={})
    frequency = options[:frequency] || 60
    code = <<JS

  var autoSession = function(){
    Ext.Ajax.request({
      url: '/active',
      method: 'GET',
      success: function(response) {
        var returnValue = response.responseText;
        if(returnValue == 'false'){
          window.location.href = '/timeout';
        }
      },
      failure: function(response) {
        if (response.status == 401)
          window.location.href = '/timeout';
      }
    });
  }

 var runner = new Ext.util.TaskRunner();
 var task = runner.start({
     run: autoSession,
     interval: (#{frequency} * 1000)
 });

JS
    javascript_tag(code)
  end
end


ActionView::Base.send :include, AutoSessionTimeoutHelper