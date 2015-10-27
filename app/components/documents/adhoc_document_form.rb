class Documents::AdhocDocumentForm < Documents::AbstractDocumentForm

   def configuration
      super.merge(
          model: "AdhocDocument",
          items:[
              {
                  xtype: 'container',
                  height: 768,
                  width: 1024,
                  layout: {
                      type: 'fit'
                  },
                  items: [
                      {
                          xtype: 'form',
                          border: 0,
                          layout: {
                              type: 'border'
                          },
                          bodyPadding: 10,
                          items: [
                              {
                                  xtype: 'panel',
                                  region: 'north',
                                  border: 0,
                                  margin: '5px',
                                  layout: {
                                      align: 'middle',
                                      type: 'hbox'
                                  },
                                  items: [
                                      {
                                          xtype: 'textfield',
                                          flex: 1,
                                          fieldLabel: 'Title',
                                          name: 'title'
                                      }
                                  ]
                              },
                              {
                                  xtype: 'htmleditor',
                                  region: 'center',
                                  margin: '5px',
                                  style: 'background-color: white;',
                                  name: 'description',
                                  fieldLabel: 'Description',
                                  enableFont: false
                              }
                          ]
                      }
                  ]
              }
          ]
      )
  end



end