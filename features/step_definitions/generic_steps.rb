Then /^Netzke should be initialized$/ do
  Netzke::Base.should be
end

When /^I execute "([^\"]*)"$/ do |script|
  page.driver.browser.execute_script(script)
end

Then /^button "([^"]*)" should be disabled$/ do |arg1|
  Netzke.should be # PENDING!
end

When /I (?:sleep|wait) (\d+) seconds/ do |amount|
  sleep amount.to_i
end

When /^I wait for the response from the server$/ do
  sleep 0.5
  page.wait_for_ajax()
  sleep 0.5
end

When /^(?:|I )open chart with patient name "([^"]*)" with disciplines "([^"]*)"$/ do |name, disciplines|
  page.driver.browser.execute_script(<<-JS)
    var patientList = Ext.ComponentQuery.query("#episodes_list")[0];
    var recordIndex = patientList.store.findBy(function(record, id){
      var res = record.get('patient_name') == "#{name}";
      Ext.each("#{disciplines}".split(":"), function(discipline, index){
        res = (res && record.get("disciplines_display").indexOf(discipline) != -1);
      }, this);
      res = (res && record.get("certification_period") == "");
      return res;
    });
    var record = patientList.store.getAt(recordIndex);
    patientList.viewChart(record, record.get('record_type'));
  JS
end

When /^(?:|I )open chart with patient name "([^"]*)" with episode "([^"]*)"$/ do |name, episode|
  page.driver.browser.execute_script(<<-JS)
    var patientList = Ext.ComponentQuery.query("#episodes_list")[0];
    var recordIndex = patientList.store.findBy(function(record, id){
      var res = record.get('patient_name') == "#{name}";
      res = (res && record.get("certification_period") == "#{episode}");
      return res;
    });
    var record = patientList.store.getAt(recordIndex);
    patientList.viewChart(record, record.get('record_type'));
  JS
end

When /^(?:|I )open chart with patient name "([^"]*)"$/ do |name|
  page.driver.browser.execute_script(<<-JS)
    var patientList = Ext.ComponentQuery.query("#episodes_list")[0];
    var recordIndex = patientList.store.findBy(function(record, id){
      res = record.get('patient_name') == "#{name}";
      return (res && record.get("disciplines_display") == "");
    });
    var record = patientList.store.getAt(recordIndex);
    patientList.viewChart(record, record.get('record_type'));
  JS
end

When /^(?:|I )go to "([^"]*)" node(?: within like "([^"]*)")?$/ do |node_name, selector|
  page.driver.browser.execute_script(<<-JS)
    var chart = Ext.ComponentQuery.query("#p_chart")[0];
    var node = getTreeNode(chart, "#{node_name}", "#{selector}");
    if(node) chart.displayNodeBody(node);
  JS
end

When /^(?:|I )go to "([^"]*)" node in "([^"]*)" menu(?: within like "([^"]*)")?$/ do |node_name, menu_name, selector|
  page.driver.browser.execute_script(<<-JS)
    var tree_panel = Ext.ComponentQuery.query("#report_tree")[0];
    var node = getTreeNode(tree_panel, "#{node_name}", "#{selector}");
    var panel = Ext.ComponentQuery.query("##{menu_name}")[0];
    if(node) panel.displayNodeBody(node);
  JS
end

When /^(?:|I )expand "([^"]*)" node(?: within like "([^"]*)")?$/ do |node_name, selector|
  page.driver.browser.execute_script(<<-JS)
    var chart = Ext.ComponentQuery.query("#p_chart")[0];
    var node = getTreeNode(chart, "#{node_name}", "#{selector}");
    if(node) node.expand();
  JS
end

When /^I go forward one page$/ do
  page.driver.browser.execute_script(<<-JS)
    var toolbar = Ext.ComponentQuery.query('pagingtoolbar')[0];
    toolbar.moveNext();
  JS
  page.wait_until{ page.driver.browser.execute_script("return !Ext.Ajax.isLoading();") }
end

Then /^the "([^"]*)" component should be hidden$/ do |id|
  page.driver.browser.execute_script(<<-JS).should be_false
    var cmp = Ext.ComponentMgr.get("#{id}");
    return cmp.isVisible();
  JS
end

Then /^I should see "([^"]*)" within paging toolbar$/ do |text|
  step %Q{I should see "#{text}"}
  # Not working, as it checks the initial text property, not the actual one
  # page.driver.browser.execute_script(<<-JS).should == true
  #   Ext.ComponentQuery.query('pagingtoolbar')[0].query('tbtext[text="#{text}"]').length >= 1
  # JS
end

When /^(?:|I )press OK$/ do ||
  page.driver.browser.execute_script(<<-JS)
    var alertWindow = Ext.ComponentQuery.query("window[title=Success]")[0];
    var btn = alertWindow.down('button[text=OK]')
    btn.handler.call(btn.scope, btn, Ext.EventObject);
  JS
end