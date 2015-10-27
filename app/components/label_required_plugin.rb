class LabelRequiredPlugin < Netzke::Plugin

  js_method :init, <<-JS
    function(cmp){
      this.cmp = cmp;
      //        if (!field.allowBlank) labelSep += '<span style="color: rgb(255, 0, 0); padding-left: 2px;">*</span>';

      this.asterisk = ' <span class="required"> *</span>';
      this.cmp.on('beforerender', function(formPanel){
      
        var i, len, items;

        items = formPanel.query('[allowBlank=false]');
        console.log('here ' + this.asterisk);
        var asterisk = ' <span class="required"> *</span>';
        var asterisk = '<span style="color: rgb(255, 0, 0); padding-left: 2px;">*</span>';

        for (i = 0, len = items.length; i < len; i++) {
            item = items[i];
            item.afterLabelTextTpl = (item.afterLabelTextTpl || "") + asterisk;
        }

        return true;
      }, this.cmp);
          
    }
  JS

end