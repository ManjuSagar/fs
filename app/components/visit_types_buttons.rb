class VisitTypesButtons < Mahaswami::Panel
  def configuration
    s = super
    s.merge!(
        margin: '-1px',
        :bbar => ['->', :add_in_form.action, :edit_in_form.action]
    )
  end

  action :add_in_form, text: "", tooltip: "Add Visit Type", icon: :add_new
  action :edit_in_form, text: "", tooltip: "Edit Visit Type",  icon: :edit, disabled: true

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      this.list = this.up('#visits_list_explorer').down('#visit_types');
      visitTypes = Ext.ComponentQuery.query('#visit_types')[0];
      visitTypes.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.editInForm.setDisabled(selModel.getCount() == 0);
      },this);
    }
  JS

  js_method :on_add_in_form, <<-JS
    function(){
      this.list.onAddInForm();
    }
  JS

  js_method :on_edit_in_form, <<-JS
    function(){
      this.list.onEditInForm();
    }
  JS

end