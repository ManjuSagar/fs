class StatesList < Mahaswami::GridPanel

 def configuration
   super.merge(
       model: 'State',
       title:  'State',
       columns: [
           {name: :state_code, header: "Code", editable: false},
           {name: :state_description, width: 200, header: "Description", editable: false}

       ]
   )
 end
 def default_bbar
   [:add_in_form.action, :edit_in_form.action, :del.action]
 end

 def default_context_menu
   [:add_in_form.action, :edit_in_form.action, :del.action]
 end

 action :add_in_form, text: "Add State"
 action :edit_in_form, text: "Edit State"
end
