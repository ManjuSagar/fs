class UnloadComponentPlugin < Netzke::Plugin

  js_method :init, <<-JS
    function(cmp){
      var me = this;
      if(cmp.clearStateOnDestroy == undefined) cmp.clearStateOnDestroy = true;
      this.cmp = cmp;
      if (this.cmp.clearStateOnDestroy) {

        this.cmp.on('destroy', function(view, record){
          if (this.clearStateOnDestroy) {
            me.unloadNetzkeComponentInServer({global_id: this.id});
          }
        }, this.cmp);

        this.cmp.on('beforedestroy', function(view, record){
          if (this.clearStateOnDestroy) {
            me.turnOfUnloadComponent(this.items.items);
          }
        }, this.cmp);
      }
    }
  JS

  js_method :turn_of_unload_component, <<-JS
    function(items) {
      Ext.each(items, function(item, index){
        if(item.items) {
          this.turnOfUnloadComponent(item.items.items);
        }
        if(item.clearStateOnDestroy)  {
          item.clearStateOnDestroy = false;
        }
      }, this);
    }
  JS

  endpoint :unload_netzke_component_in_server do |params|
    session.keys.select{|k| k.starts_with?("#{params[:global_id]}__")}.each {|k| session.delete(k)}
    session.delete(params[:global_id])
    {}
  end

end