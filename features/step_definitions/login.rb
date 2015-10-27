When /^(?:|I )log in as "([^"]*)" and password "([^"]*)"(?: within "([^"]*)")?$/ do |user_name, password, selector|
  with_scope(selector) do
    fill_in("Login:", :with => user_name)
    fill_in("Password:", :with => password)
    page.driver.browser.execute_script(<<-JS)
      var btn = Ext.ComponentQuery.query('button[text=Login]')[0];
      btn.handler.call(btn.scope, btn, Ext.EventObject);
    JS
  end
end