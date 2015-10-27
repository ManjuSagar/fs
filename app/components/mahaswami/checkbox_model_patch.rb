module Mahaswami
  module CheckboxModelPatch

    def self.included(klass)
      klass.class_eval do

        js_method :rememberSelection, <<-JS
          function() {
            if(this.doNotRememberAfterStoreReload){this.selectedRecordIds = []; return;}
            var selectedRecs = this.getSelectionModel().getSelection();
            this.clearUncheckedSelection(selectedRecs);

            Ext.each(selectedRecs, function(rec, index){
              var recId = rec.getId();
              if(Ext.Array.contains(this.selectedRecordIds, recId) == false){
                this.selectedRecordIds.push(recId);
              }
            }, this);
          }
        JS

        js_method :clearUncheckedSelection, <<-JS
          function(selectedRecs){
            Ext.each(this.selectedRecordIds, function(rec_id, index){
              var rec = this.store.findRecord('id', rec_id);
              if(rec && Ext.Array.contains(selectedRecs, rec) == false){
                Ext.Array.remove(this.selectedRecordIds, rec_id);
              }
            }, this);
          }
        JS

        js_method :refreshSelection, <<-JS
          function() {
            if (this.selectedRecordIds.length == 0) {
                return;
            }
            var recs = [];

            Ext.each(this.selectedRecordIds, function(rec_id, index){
              var rec = this.store.findRecord('id', rec_id);
              if(rec) recs.push(rec);
            }, this);
            this.getSelectionModel().select(recs);
          }
        JS
      end
    end
  end
end