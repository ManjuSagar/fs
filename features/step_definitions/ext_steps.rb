When /^(?:|I )check ext checkbox "([^"]*)"$/ do |field|
  page.driver.browser.execute_script <<-JS
    var checkbox = Ext.ComponentQuery.query("checkboxfield[fieldLabel='#{field}']")[0];
    checkbox = checkbox || Ext.ComponentQuery.query("checkboxfield[boxLabel='#{field}']")[0];
    checkbox = checkbox || Ext.ComponentQuery.query("checkboxfield##{field}")[0]
    checkbox.setValue(true);
  JS
end

When /^(?:|I )check ext checkbox with id "([^"]*)"$/ do |field|
  page.driver.browser.execute_script <<-JS
    var checkbox = Ext.ComponentQuery.query("checkboxfield##{field}")[0];
    checkbox.setValue(true);
  JS
end

When /^(?:|I )uncheck ext checkbox "([^"]*)"$/ do |field|
  page.driver.browser.execute_script <<-JS
    var checkbox = Ext.ComponentQuery.query("checkboxfield[fieldLabel='#{field}']")[0];
    checkbox = checkbox || Ext.ComponentQuery.query("checkboxfield[boxLabel='#{field}']")[0];
    checkbox = checkbox || Ext.ComponentQuery.query("checkboxfield##{field}")[0]
    checkbox.setValue(false);
  JS
end

When /^(?:|I )select ext radio "([^"]*)"$/ do |field|
  page.driver.browser.execute_script <<-JS
    var radio = Ext.ComponentQuery.query("checkboxfield[boxLabel='#{field}']")[0];
    radio.setValue(true);
  JS
end

Then /^ext "([^"]*)" checkbox should(| not) be checked$/ do |name, arg|
  page.driver.browser.execute_script(<<-JS).should == arg.eql?("")
    var checkbox = Ext.ComponentQuery.query('checkboxfield[boxLabel="#{name}"]')[0];
    checkbox = checkbox || Ext.ComponentQuery.query('checkboxfield[fieldLabel="#{name}"]')[0];

    return checkbox.getValue();
  JS
end
