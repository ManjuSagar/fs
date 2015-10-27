module Capybara
  class Session
    def wait_for_ajax
      Timeout.timeout(Capybara.default_wait_time) do
        debug_log "$$$$$$$444444444444444444444%%%%%%%%%%%%%6^^^^^^^^^^^^^^^^^&&&&&&&&&&"
        loop until finished_all_ajax_requests?
      end
    end

    def finished_all_ajax_requests?
      self.driver.browser.execute_script("return !(Netzke.ajaxIsLoading() || Ext.Ajax.isLoading())")
    end
  end
end