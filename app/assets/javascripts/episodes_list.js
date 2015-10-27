Ext.define('Netzke.classes.Plugin', Netzke.chainApply({
        extend: 'Ext.Component',
        alias: 'plugin.netzkeplugin',
        constructor: function(config) {
            Netzke.aliasMethodChain(this, "initComponent", "netzke");
            Netzke.classes.Plugin.superclass.constructor.call(this, config);
        }
    }, Netzke.componentMixin,
    {"init":      function(cmp){
        this.cmp = cmp;
    }
    }));

Netzke.cache.push('netzkeplugin');

Ext.define('Netzke.classes.UnloadComponentPlugin', Netzke.chainApply({"init":    function(cmp){
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
    ,"turnOfUnloadComponent":    function(items) {
        Ext.each(items, function(item, index){
            if(item.items) {
                this.turnOfUnloadComponent(item.items.items);
            }
            if(item.clearStateOnDestroy)  {
                item.clearStateOnDestroy = false;
            }
        }, this);
    }
}, {
    extend: 'Netzke.classes.Plugin',
    alias: 'plugin.unloadcomponentplugin'
}));

Netzke.cache.push('unloadcomponentplugin');

Ext.ns("Netzke.classes.Basepack");
Ext.define('Netzke.classes.Basepack.Panel', Netzke.chainApply({
        extend: 'Ext.panel.Panel',
        alias: 'widget.netzkebasepackpanel',
        constructor: function(config) {
            Netzke.aliasMethodChain(this, "initComponent", "netzke");
            Netzke.classes.Basepack.Panel.superclass.constructor.call(this, config);
        }
    }, Netzke.componentMixin,
    {"updateBodyHtml":        function(html){
        this.body.update(html);
    }
    }));

Netzke.cache.push('netzkebasepackpanel');

Ext.ns("Netzke.classes.Mahaswami");
Ext.define('Netzke.classes.Mahaswami.Panel', Netzke.chainApply({}, {
    extend: 'Netzke.classes.Basepack.Panel',
    alias: 'widget.mahaswamipanel'
}));

Netzke.cache.push('mahaswamipanel');

Ext.define('Netzke.classes.PatientsListFilter', Netzke.chainApply({}, {
    extend: 'Netzke.classes.Mahaswami.Panel',
    alias: 'widget.patientslistfilter'
}));

Netzke.cache.push('patientslistfilter');

Ext.define('Netzke.classes.PatientsListButtons', Netzke.chainApply({"afterRender":    function(){
    this.callParent();
    this.list = this.up('#episodes_list_explorer').down('#episodes_list');
}

    ,"onViewPatientChart":    function(){
        this.list.onViewPatientChart();
    }
    ,"onViewPatientSchedule":    function(){
        this.list.onViewPatientSchedule();
    }
    ,"onWorksheet":    function(){
        this.list.onWorksheet();
    }
    ,"onAddPatient":    function(){
        this.list.onAddPatient();
    }
    ,"onAddReferral":    function(){
        this.list.onAddReferral();
    }
    ,"onCensusReport":    function(){
        this.list.onCensusReport();
    }
}, {
    extend: 'Netzke.classes.Mahaswami.Panel',
    alias: 'widget.patientslistbuttons'
}));

Netzke.cache.push('patientslistbuttons');
Ext.override(Ext.ux.CheckColumn, {
    processEvent: function() {
        if (this.editable === false) return false;
        else return this.callOverridden(arguments);
    }
});

Ext.ns("Netzke.classes.Basepack");
Ext.define('Netzke.classes.Basepack.GridPanel', Netzke.chainApply({
        extend: 'Ext.grid.Panel',
        alias: 'widget.netzkebasepackgridpanel',
        constructor: function(config) {
            Netzke.aliasMethodChain(this, "initComponent", "netzke");
            Netzke.classes.Basepack.GridPanel.superclass.constructor.call(this, config);
        }
    }, Netzke.componentMixin,
    {
        trackMouseOver: true,
        loadMask: true,
        autoScroll: true,

        componentLoadMask: {msg: "Loading..."},
        deleteMaskMsg: "Deleting...",
        multiSelect: true,

        initComponent: function(){
            var metaColumn;
            var fields = []; // field configs for the underlying data model

            this.plugins = this.plugins || [];
            this.features = this.features || [];

            // Enable filters feature
            this.features.push({
                encode: true,
                ftype: 'filters'
            });

            // Run through columns and set up different configuration for each
            Ext.each(this.columns, function(c, i){

                this.normalizeRenderer(c);

                // Build the field configuration for this column
                var fieldConfig = {name: c.name, defaultValue: c.defaultValue};

                if (c.name !== '_meta') fieldConfig.type = this.fieldTypeForAttrType(c.attrType); // field type (grid editors need this to function well)

                if (c.attrType == 'datetime') {
                    fieldConfig.dateFormat = 'Y-m-d H:i:s'; // set the format in which we receive datetime from the server (so that the model can parse it)

                    // While for 'date' columns the renderer is set up automatically (through using column's xtype), there's no appropriate xtype for our custom datetime column.
                    // Thus, we need to set the renderer manually.
                    // NOTE: for Ext there's no distinction b/w date and datetime; date fields can include time.
                    if (!c.renderer) {
                        // format in which the data will be rendered; if c.format is nil, Ext.Date.defaultFormat extended with time will be used
                        c.renderer = Ext.util.Format.dateRenderer(c.format || Ext.Date.defaultFormat + " H:i:s");
                    }
                };

                fields.push(fieldConfig);

                // We will not use meta columns as actual columns (not even hidden) - only to create the records
                if (c.meta) {
                    metaColumn = c;
                    return;
                }

                // if comboboxOptions are provided, we render a combobox instead of textfield
                // if (c.comboboxOptions && c.editor.xtype === "textfield") {
                //   c.editor = {xtype: "combobox", options: c.comboboxOptions.split('\\n')}
                // }


                // Set rendeder for association columns (the one displaying associations by the specified method instead of id)
                if (c.assoc) {
                    c.emptyText = c.emptyText || "---";

                    // Editor for association column
                    c.editor = Ext.apply({
                        parentId: this.id,
                        emptyText: c.emptyText,
                        name: c.name
                    }, c.editor);

                    // Renderer for association column
                    this.normalizeAssociationRenderer(c);
                }

                if (c.editor) {
                    Ext.applyIf(c.editor, {selectOnFocus: true});
                }

                // Setting the default filter type
                if (c.filterable && !c.filter) {
                    c.filter = {type: this.fieldTypeForAttrType(c.attrType)};
                }

                // setting dataIndex
                c.dataIndex = c.name;

            }, this);

            /* ... and done with the columns */

            // Define the model
            Ext.define(this.id, {
                extend: 'Ext.data.Model',
                idProperty: this.pri, // Primary key
                fields: fields
            });

            // After we created the record (model), we can get rid of the meta column
            Ext.Array.remove(this.columns, metaColumn);

            // Prepare column model config with columns in the correct order; columns out of order go to the end.
            var colModelConfig = [];
            var columns = this.columns;

            Ext.each(this.columnsOrder, function(c) {
                var mainColConfig;
                Ext.each(this.columns, function(oc) {
                    if (c.name === oc.name) {
                        mainColConfig = Ext.apply({}, oc);
                        return false;
                    }
                });

                colModelConfig.push(Ext.apply(mainColConfig, c));
            }, this);

            // We don't need original columns any longer
            delete this.columns;

            // ... instead, define own column model
            this.columns = colModelConfig;

            var reader = Ext.create('Ext.data.reader.Array', {root: 'data', totalProperty: 'total'});

            // DirectProxy that uses our Ext.direct provider
            var proxy = Ext.create('Ext.data.proxy.Direct', {
                directFn: Netzke.providers[this.id].getData,
                reader: reader,
                listeners: {
                    exception: {
                        fn: this.loadExceptionHandler,
                        scope: this
                    },
                    load: { // Netzke-introduced event; this will also be fired when an exception occurs.
                        fn: function(proxy, response, operation) {
                            // besides getting data into the store, we may also get commands to execute
                            response = response.result;
                            if (response) { // or did we have an exception?
                                Ext.each(['data', 'total', 'success'], function(property){delete response[property];});
                                this.bulkExecute(response);
                            }
                        },
                        scope: this
                    }
                }
            });

            this.store = Ext.create('Ext.data.Store', {
                model: this.id,
                proxy: proxy,
                pruneModifiedRecords: true,
                remoteSort: true,
                pageSize: this.rowsPerPage
            });

            if (this.inlineData) this.store.loadRawData(this.inlineData);

            // Drag'n'Drop
            if (this.enableRowsReordering){
                this.ddPlugin = new Ext.ux.dd.GridDragDropRowOrder({
                    scrollable: true // enable scrolling support (default is false)
                });
                this.plugins.push(this.ddPlugin);
            }

            // Cell editing
            if (!this.prohibitUpdate) {
                this.plugins.push(Ext.create('Ext.grid.plugin.CellEditing', {pluginId: 'celleditor'}));
            }

            //ExtJs4.2: New plugin added for Infinite scroll functionality, included as per reference in infinite_scroll.js file
            this.plugins.push(Ext.create('Ext.grid.plugin.BufferedRenderer', {pluginId: 'bufferedrenderer'}));

            // Toolbar
            this.dockedItems = this.dockedItems || [];
            if (this.enablePagination && this.infiniteScroll) {
                this.store = Ext.create('Ext.data.Store', {
                    model: this.id,
                    proxy: proxy,
                    pruneModifiedRecords: true,
                    remoteSort: true,
                    pageSize: this.rowsPerPage,
                    buffered: true,
                    autoLoad: true,
                    leadingBufferZone: this.rowsPerPage * 2
                });
            }else if(this.enablePagination) {
                this.dockedItems.push({
                    xtype: 'pagingtoolbar',
                    dock: 'bottom',
                    store: this.store,
                    displayInfo: false,
                    items: ['->'],
                    prependButtons: true
                });
            }
            if (this.bbar) {
                this.dockedItems.push({
                    xtype: 'toolbar',
                    dock: 'top',
                    items: ['->'].concat(this.bbar)
                });
            }


            delete this.bbar;

            // Now let Ext.grid.EditorGridPanel do the rest (original initComponent)
            this.callParent();

            // Context menu
            if (this.contextMenu) {
                this.on('itemcontextmenu', this.onItemContextMenu, this);
            }

            // Disabling/enabling editInForm button according to current selection
            if (this.enableEditInForm && !this.prohibitUpdate) {
                this.getSelectionModel().on('selectionchange', function(selModel, selected){
                    var disabled;
                    if (selected.length === 0) { // empty?
                        disabled = true;
                    } else {
                        // Disable "edit in form" button if new record is present in selection
                        Ext.each(selected, function(r){
                            if (r.isNew) { disabled = true; return false; }
                        });
                    };
                    this.actions.editInForm.setDisabled(disabled);
                }, this);
            }

            // Process selectionchange event to enable/disable actions
            this.getSelectionModel().on('selectionchange', function(selModel){
                if (this.actions.del) this.actions.del.setDisabled(!selModel.hasSelection() || this.prohibitDelete);
                if (this.actions.edit) this.actions.edit.setDisabled(selModel.getCount() != 1 || this.prohibitUpdate);
            }, this);

            // Drag n Drop event
            if (this.enableRowsReordering){
                this.ddPlugin.on('afterrowmove', this.onAfterRowMove, this);
            }

            // WIP: GridView
            this.getView().getRowClass = this.defaultGetRowClass;

            // this.on('edit', function(editor, e) {
            //   if (e.column.assoc && e.record.get('_meta')) {
            //     console.log("editor:", editor);
            //     editor.setRawValue("");
            //   }
            // });

            // When starting editing as assocition column, pre-load the combobox store from the meta column, so that we don't see the real value of this cell (the id of the associated record), but rather the associated record by the configured method.
            this.on('beforeedit', function(editor, e){
                if (e.column.assoc && e.record.get('_meta')) {
                    var c = e.column,
                        combo = c.getEditor(),
                        store = combo.store,
                        id = e.record.get(e.field);

                    if (id === 0 && -1 == store.find('field1', 0)) store.loadData([[0, c.emptyText]], true);

                    if (id && -1 == store.find('field1', id)) {
                        store.loadData([[e.record.get(e.field), e.record.get('_meta').associationValues[e.field]]], true);
                    }

                }
            }, this);

            this.on('afterrender', function() {
                // Persistence-related events (afterrender to avoid blank event firing on render)
                if (this.persistence) {
                    // Inform the server part about column operations
                    this.on('columnresize', this.onColumnResize, this);
                    this.on('columnmove', this.onColumnMove, this);
                    this.on('columnhide', this.onColumnHide, this);
                    this.on('columnshow', this.onColumnShow, this);
                }
            }, this);
        },

        fieldTypeForAttrType: function(attrType){
            var map = {
                integer   : 'int',
                decimal   : 'float',
                datetime  : 'date',
                date      : 'date',
                string    : 'string',
                text      : 'string',
                'boolean' : 'boolean'
            };
            return map[attrType] || 'string';
        },

        update: function(){
            this.store.load();
        },

        loadStoreData: function(data){
            var dataRecords = this.getStore().getProxy().getReader().read(data);
            this.getStore().loadData(dataRecords.records);
            Ext.each(['data', 'total', 'success'], function(property){delete data[property];}, this);
            this.bulkExecute(data);
        },

        // Tries editing the first editable (i.e. not hidden, not read-only) sell
        tryStartEditing: function(r){
            var editableIndex = 0;
            Ext.each(this.initialConfig.columns, function(c){
                // skip columns that cannot be edited
                if (!(c.hidden == true || c.editable == false || !c.editor || c.attrType == 'boolean')) {
                    return false;
                }
                editableIndex++;
            });

            if (editableIndex < this.initialConfig.columns.length) {this.getPlugin('celleditor').startEdit(r, this.columns[editableIndex]);}
        },

        // Called by the server side to update newly created records
        updateNewRecords: function(records){
            this.updateRecords(records);
        },

        // Called by the server side to update modified records
        updateModRecords: function(records){
            this.updateRecords(records, true);
        },

        // Updates modified or newly created records, by record ID
        // Example of the records argument (updated columns):
        //   {1098 => [1, 'value1', 'value2'], 1099 => [2, 'value1', 'value2']}
        // Example of the records argument (new columns, id autogenerated by Ext):
        //   {"ext-record-200" => [1, 'value1', 'value2']}
        updateRecords: function(records, mod){
            if (!mod) {mod = false;}
            var modRecordsInGrid = [].concat(this.store.getUpdatedRecords()); // there must be a better way to clone an array...
            // replace arrays of data in the args object with Ext.data.Record objects
            for (var k in records){
                records[k] = this.getStore().getProxy().getReader().read({data:[records[k]]}).records[0];
            }
            // for each new record write the data returned by the server, and commit the record
            Ext.each(modRecordsInGrid, function(recordInGrid){
                if (mod ^ recordInGrid.isNew) {
                    // if record is new, we access its id by "id", otherwise, the id is in the primary key column
                    var recordId = recordInGrid.getId();
                    // new data that the server sent us to update this record (identified by the id)
                    var newData =  records[recordId];

                    if (newData){
                        for (var k in newData.data){
                            recordInGrid.set(k, newData.get(k));
                        }

                        recordInGrid.isNew = false;
                        recordInGrid.commit();
                    }

                }
            }, this);

            // clear the selections
            this.getSelectionModel().clearSelections();

            // check if there are still records with errors
            var modRecords = this.store.getUpdatedRecords();
            if (modRecords.length == 0) {
                // if all records are accepted, reload the grid (so that eventual order/filtering is correct)
                this.store.load();

                // ... and set default getRowClass function
                this.getView().getRowClass = this.defaultGetRowClass;
            } else {
                this.getView().getRowClass = function(r){
                    return r.dirty ? "grid-dirty-record" : ""
                }
            }

            this.getView().refresh();
            this.getSelectionModel().fireEvent('selectionchange', this.getSelectionModel());
        },

        defaultGetRowClass: function(r){
            return r.isNew ? "grid-dirty-record" : ""
        },

        selectFirstRow: function(){
            this.getSelectionModel().suspendEvents();
            this.getSelectionModel().selectRow(0);
            this.getSelectionModel().resumeEvents();
        },

        // Normalizes the renderer for a column.
        // Renderer may be:
        // 1) a string that contains the name of the function to be used as renderer.
        // 2) an array, where the first element is the function name, and the rest - the arguments
        // that will be passed to that function along with the value to be rendered.
        // The function is searched in the following objects: 1) Ext.util.Format, 2) this.
        // If not found, it is simply evaluated. Handy, when as renderer we receive an inline JS function,
        // or reference to a function in some other scope.
        // So, these will work:
        // * "uppercase"
        // * ["ellipsis", 10]
        // * ["substr", 3, 5]
        // * "myRenderer" (if this.myRenderer is a function)
        // * ["Some.scope.Format.customRenderer", 10, 20, 30] (if Some.scope.Format.customRenderer is a function)
        // * "function(v){ return 'Value: ' + v; }"
        normalizeRenderer: function(c) {
            if (!c.renderer) return;

            var name, args = [];

            if ('string' === typeof c.renderer) {
                name = c.renderer.camelize(true);
            } else {
                name = c.renderer[0];
                args = c.renderer.slice(1);
            }

            // First check whether Ext.util.Format has it
            if (Ext.isFunction(Ext.util.Format[name])) {
                c.renderer = Ext.Function.bind(Ext.util.Format[name], this, args, 1);
            } else if (Ext.isFunction(this[name])) {
                // ... then if our own class has it
                c.renderer = Ext.Function.bind(this[name], this, args, 1);
            } else {
                // ... and, as last resort, evaluate it (allows passing inline javascript function as renderer)
                eval("c.renderer = " + c.renderer + ";");
            }
        },

        /*
         Set a renderer that displayes association values instead of association record ID.
         The association values are passed in the meta-column under associationValues hash.
         */
        normalizeAssociationRenderer: function(c) {
            c.scope = this;
            var passedRenderer = c.renderer; // renderer we got from normalizeRenderer
            c.renderer = function(value, a, r, ri, ci){
                var column = this.headerCt.items.getAt(ci),
                    editor = column.getEditor && column.getEditor(),
                    recordFromStore = editor && editor.isXType('combobox') && editor.getStore().findRecord('field1', value),
                    renderedValue;

                if (recordFromStore) {
                    renderedValue = recordFromStore.get('field2');
                } else if (c.assoc && r.get('_meta')) {
                    renderedValue = r.get('_meta').associationValues[c.name] || c.emptyText;
                } else {
                    renderedValue = value;
                }

                return passedRenderer ? passedRenderer.call(this, renderedValue) : renderedValue;
            };
        }
    }
    ,
    {
        // Handler for the 'add' button
        onAddInline: function(){
            // Note: default values are taken from the model's field's defaultValue property
            var r = Ext.ModelManager.create({}, this.id);

            r.isNew = true; // to distinguish new records

            this.getStore().add(r);

            this.tryStartEditing(r);
        },

        onDel: function() {
            Ext.Msg.confirm(this.i18n.confirmation, this.i18n.areYouSure, function(btn){
                if (btn == 'yes') {
                    var records = [];
                    this.getSelectionModel().selected.each(function(r){
                        if (r.isNew) {
                            // this record is not know to server - simply remove from store
                            this.store.remove(r);
                        } else {
                            records.push(r.getId());
                        }
                    }, this);

                    if (records.length > 0){
                        if (!this.deleteMask) this.deleteMask = new Ext.LoadMask(this.getEl(), {msg: this.deleteMaskMsg});
                        this.deleteMask.show();
                        // call API
                        this.deleteData({records: Ext.encode(records)}, function(){
                            this.deleteMask.hide();
                        }, this);
                    }
                }
            }, this);
        },

        onApply: function(){
            if (this.fireEvent('apply')) {
                var newRecords = [],
                    updatedRecords = [],
                    store = this.getStore();

                Ext.each(store.getUpdatedRecords().concat(store.getNewRecords()),
                    function(r) {
                        if (r.isNew) {
                            newRecords.push(r.data); // HACK: r.data seems private
                        } else {
                            updatedRecords.push(Ext.apply(r.getChanges(), {id:r.getId()}));
                        }
                    },
                    this);

                if (newRecords.length > 0 || updatedRecords.length > 0) {
                    var params = {};

                    if (newRecords.length > 0) {
                        params.created_records = Ext.encode(newRecords);
                    }

                    if (updatedRecords.length > 0) {
                        params.updated_records = Ext.encode(updatedRecords);
                    }

                    if (this.getStore().getProxy().extraParams !== {}) {
                        params.base_params = Ext.encode(this.getStore().getProxy().extraParams);
                    }

                    this.postData(params);
                }
            }
            this.fireEvent('afterApply', this);
        },

        // Handlers for tools
        //

        onRefresh: function() {
            if (this.fireEvent('refresh', this) !== false) {
                this.store.load();
            }
        },

        // Event handlers
        //

        onColumnResize: function(ct, cl, width){
            var index = ct.items.findIndex('id', cl.id);

            this.resizeColumn({
                index: index,
                size:  width
            });
        },

        onColumnHide: function(ct, cl){
            var index = ct.items.findIndex('id', cl.id);

            this.hideColumn({
                index:index,
                hidden:true
            });
        },

        onColumnShow: function(ct, cl){
            var index = ct.items.findIndex('id', cl.id);

            this.hideColumn({
                index:index,
                hidden:false
            });
        },

        onColumnMove: function(ct, cl, oldIndex, newIndex){
            this.moveColumn({
                old_index: oldIndex,
                new_index: newIndex
            });
        },

        onItemContextMenu: function(grid, record, item, rowIndex, e){
            e.stopEvent();
            var coords = e.getXY();

            if (!grid.getSelectionModel().isSelected(rowIndex)) {
                grid.getSelectionModel().selectRow(rowIndex);
            }

            var menu = new Ext.menu.Menu({
                items: this.contextMenu
            });

            menu.showAt(coords);
        },

        onAfterRowMove: function(dt, oldIndex, newIndex, records){
            var ids = [];
            // collect records ids
            Ext.each(records, function(r){ids.push(r.id)});
            // call GridPanel's API
            this.moveRows({ids: Ext.encode(ids), new_index: newIndex});
        },

        // Other methods. TODO: revise
        //

        /* Exception handler. TODO: will responses with status 200 land here? */
        loadExceptionHandler: function(proxy, response, operation){
            this.netzkeFeedback(response.message);
            // if (response.status == 200 && (responseObject = Ext.decode(response.responseText)) && responseObject.flash){
            //   this.feedback(responseObject.flash);
            // } else {
            //   if (error){
            //     this.feedback(error.message);
            //   } else {
            //     this.feedback(response.statusText);
            //   }
            // }
        },

        // Inline editing of 1 row
        onEdit: function(){
            var row = this.getSelectionModel().selected.first();
            if (row){
                this.tryStartEditing(row);
            }
        },

        // Not a very clean approach to clean-up. The problem is that this way the advanced search functionality stops being really pluggable. With Ext JS 4 find the way to make it truely so.
        onDestroy: function(){
            Netzke.classes.Basepack.GridPanel.superclass.onDestroy.call(this);

            // Destroy the search window (here's the problem: we are not supposed to know it exists)
            if (this.searchWindow) {
                this.searchWindow.destroy();
            }
        }
    }
    ,
    {
        onSearch: function(el){
            if (this.searchWindow) {
                this.searchWindow.show();
            } else {
                this.loadNetzkeComponent({name: 'search_form', callback: function(win){
                    this.searchWindow = win;
                    win.show();

                    win.items.first().on('apply', function(){
                        win.onSearch();
                        return false; // do not propagate the 'apply' event
                    }, this);

                    win.on('hide', function(){
                        var query = win.getQuery();
                        if (win.closeRes == 'search'){
                            var store = this.getStore(), proxy = store.getProxy();
                            proxy.extraParams.query = Ext.encode(query);
                            store.load();
                        }
                        el.toggle(query.length > 0); // toggle based on the state
                    }, this);
                }, scope: this});
            }
        }
    }
    ,
    {
        onEditInForm: function(){
            var selModel = this.getSelectionModel();
            if (selModel.getCount() > 1) {
                var recordId = selModel.selected.first().getId();
                this.loadNetzkeComponent({name: "multi_edit_form",
                    params: {record_id: recordId},
                    callback: function(w){
                        w.show();
                        var form = w.items.first();
                        form.on('apply', function(){
                            var ids = [];
                            selModel.selected.each(function(r){
                                ids.push(r.getId());
                            });
                            if (!form.baseParams) form.baseParams = {};
                            form.baseParams.ids = Ext.encode(ids);
                        }, this);

                        w.on('close', function(){
                            if (w.closeRes === "ok") {
                                this.store.load();
                            }
                        }, this);
                    }, scope: this});
            } else {
                var recordId = selModel.selected.first().getId();
                this.loadNetzkeComponent({name: "edit_form",
                    params: {record_id: recordId},
                    callback: function(w){
                        w.show();
                        w.on('close', function(){
                            if (w.closeRes === "ok") {
                                this.store.load();
                            }
                        }, this);
                    }, scope: this});
            }
        },

        onAddInForm: function(){
            this.loadNetzkeComponent({name: "add_form", callback: function(w){
                w.show();
                w.on('close', function(){
                    if (w.closeRes === "ok") {
                        this.store.load();
                    }
                }, this);
            }, scope: this});
        }
    }
    ,  {}));

Netzke.cache.push('netzkebasepackgridpanel');
Ext.override(Ext.ux.CheckColumn, {
    processEvent: function() {
        if (this.editable === false) return false;
        else return this.callOverridden(arguments);
    }
});

Ext.ns("Netzke.classes.Mahaswami");
Ext.define('Netzke.classes.Mahaswami.GridPanel', Netzke.chainApply({"rememberSelection":          function() {
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
    ,"clearUncheckedSelection":          function(selectedRecs){
        Ext.each(this.selectedRecordIds, function(rec_id, index){
            var rec = this.store.findRecord('id', rec_id);
            if(rec && Ext.Array.contains(selectedRecs, rec) == false){
                Ext.Array.remove(this.selectedRecordIds, rec_id);
            }
        }, this);
    }
    ,"refreshSelection":          function() {
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
    ,"initComponent":    function(){
        this.selectedRecordIds = [];
        if(this.checkboxModel)
            this.selModel = Ext.create('Ext.selection.CheckboxModel');
        this.plugins.push(new Ext.ux.grid.FilterRow(this));
        this.callParent();
        // setting the 'rowclick' event
        if (this.editOnDblClick === undefined || this.editOnDblClick == true) {
            //For associated field columns, somehow celldbclick takes priority, so stubbing it
            this.on('celldblclick', function( view, td, cellIndex, record, tr, rowIndex, e, eOpts) {
                this.fireEvent('itemdblclick', view, record, e);
                return false;
            });
            this.on('itemdblclick', function(view, record, e){
                this.onEditInForm();
            }, this);
        }
        if(this.checkboxModel){
            this.getView().on('refresh', this.refreshSelection, this);
            this.on('select', this.rememberSelection, this);
            this.on('deselect', this.rememberSelection, this);
        }
        this.store.on('beforeload', function(store, operation, eOpts){
            //load method call of store not fetching records properly, So emptying the store, load method fetches all records
            if(this.checkboxModel) this.rememberSelection();
            store.removeAll();
        }, this);
    }
    ,"performAction":      function(record_id, action) {
        this.triggerEvent({record_id: record_id, action: action});
    }
    ,"refreshData":      function() {
        this.getStore().load();
    }
    ,"loadStoreData":      function(data){
        // This code is commented because of buffered render reloading old records.
        //So using store load method fetches new records from server.
        //var dataRecords = this.getStore().getProxy().getReader().read(data);
        //this.getStore().loadData(dataRecords.records);
        //this.store.reload();
        //Ext.each(['data', 'total', 'success'], function(property){delete data[property];}, this);
        //this.bulkExecute(data);
        this.store.load();
    }
}, {
    extend: 'Netzke.classes.Basepack.GridPanel',
    alias: 'widget.mahaswamigridpanel'
}));

Netzke.cache.push('mahaswamigridpanel');
Ext.override(Ext.ux.CheckColumn, {
    processEvent: function() {
        if (this.editable === false) return false;
        else return this.callOverridden(arguments);
    }
});

Ext.define('Netzke.classes.EpisodesList', Netzke.chainApply({"sendUpdatedReferralReceivedDate":      function(w, record_id){
    var refDate = w.down('#date');
    var date = refDate.value;
    this.updateReferralReceivedDate({referral_id: record_id, ref_date: date});
    w.close();
}
    ,"setStartOfCareDate":    function(w, record_id){
        var socDate = w.down('#soc_date').value;
        this.updateSocDate({soc_date: socDate, referral_id: record_id}, function(result){
            if(result){
                w.close();
                this.store.load();
            }
            else{
                Ext.MessageBox.alert("Status", "Invalid Date. Please try again.");
            }
        }, this);
    }
    ,"statusRenderer":    function(value, metadata, record, rowIndex, colIndex, store){
        if (value == "P")
            return "<span style='color:#8B3AB2'>PE</span>"
        else if (value == "A")
            return "<span style='color:#000000'>AC</span>"
        else if (value == "D")
            return "<span style='color:#267FFF'>DC</span>"
        else if (value == "O")
            return "<span style='color:#4F9FB2'>HD</span>"
        else
            return value;
    }
    ,"disciplinesRenderer":    function(value, metadata, record, rowIndex, colIndex, store) {
        if(value == "")
            return;
        data = JSON.parse(value);
        value = "<div>";
        value  += (Ext.Array.map(data, function(item){
            color = "#8B3AB2"; //Purple
            if (item.s == "P")
                color = "#8B3AB2"; //Purple
            if (item.s == "A")
                color = "black";  //Black
            if (item.s == "O")
                color = "#4F9FB2"; //Teal
            if (item.s == "D")
                color = "#267FFF"; //Blue
            return "<span style='color:" + color + "'>" + item.d + "</span>"
        }).join(", "));
        value += "</div>"
        return value;
    }
    ,"stateRenderer":    function(value, metadata, record, rowIndex, colIndex, store) {
        var treatmentRequestId = record.get("treatment_request_id");
        var treatmentId = record.get("patient_treatment_id");
        var episodeId = record.get("e_id");
        var attrs = "' treatment_request_id='" + treatmentRequestId + "' treatment_id='" + treatmentId
            + "' episode_id='" + episodeId + "' width=15 height=15";
        metadata.style="text-align:center";
        var class_name = 'unknown';
        if (colIndex == 7)
            class_name = 'eligibility';
        if (colIndex == 8)
            class_name = 'staffing';
        if (colIndex == 9)
            class_name = 'referral';
        if (colIndex == 13)
            class_name = 'documents';
        if (colIndex == 14)
            class_name = 'medical_order';
        var joinedAttrs = treatmentRequestId + ':' + treatmentId + ':' + episodeId + ':' + class_name;
        var imageClick = 'Ext.ComponentQuery.query("#episodes_list")[0].displayWindow("'+joinedAttrs+'");';
        var arr = ["staffing", "medical_order", "documents"];
        if(arr.indexOf(class_name) != -1){
            if(value == "t")
                return "<div style='cursor:pointer;' onclick="+ imageClick +"><img class='checked_image_class'"+class_name+attrs+"/></div>";
            else if(value == "f")
                return "<div style='cursor:pointer;' onclick="+ imageClick +"><img class='cross_image_class'"+class_name+attrs+"/></div>";
            else if(value == "n")
                return "<div style='cursor:pointer;' onclick="+ imageClick +"><img class='progress_image_class'"+class_name+attrs+"/></div>";
            else
                return "-"
        }else{
            if(value == "t")
                return "<img class='checked_image_class'"+class_name+attrs+"/>";
            else if(value == "f")
                return "<img class='cross_image_class'"+class_name+attrs+"/>";
            else if(value == "n")
                return "<img class='progress_image_class'"+class_name+attrs+"/>";
            else
                return "-"
        }
    }
    ,"displayWindow":    function(joinedAttrs){
        var attrArr = joinedAttrs.split(":");
        var treatmentRequestId = attrArr[0];
        var treatmentId = attrArr[1];
        var episodeId = attrArr[2];
        var className = attrArr[3];
        var gridScope = this;
        if(className == "staffing"){
            if (treatmentId != 0)
                launchPatientWindow({component_class_name: "TreatmentStaffing", height: "80%", width: "90%", treatment_id: treatmentId,
                    params: {episode_id: episodeId}, grid_item_id: gridScope.itemId});
            else if (treatmentRequestId != 0)
                launchPatientWindow({component_class_name: "Staffing", height: "80%", width: "90%", treatment_request_id: treatmentRequestId,
                    params: {treatment_request_id: treatmentRequestId, treatment_id: null}, grid_item_id: gridScope.itemId});
            else
                Ext.MessageBox.alert('Status', 'Patient is yet to be admitted.');
        }else if(className == "medical_order"){
            if (treatmentId != 0)
                launchPatientWindow({component_class_name: "MedicalOrders", treatment_id: treatmentId, height: "60%", width: "60%",
                    grid_item_id: this.itemId, params: {episode_id: episodeId, episode_orders: true}});
            else
                Ext.MessageBox.alert('Status', 'Patient is yet to be admitted.');
        }else if(className == "documents"){
            if (treatmentId != 0)
                launchPatientWindow({component_class_name: "Documents", treatment_id: treatmentId, height: "60%", width: "60%",
                    grid_item_id: this.itemId, params: {parent_model: "PatientTreatment", association: "documents", treatment_id: treatmentId,
                        episode_id: episodeId, episode_docs: true, item_id: "episode_documents"}});
            else
                Ext.MessageBox.alert('Status', 'Patient is yet to be admitted.');
        }
    }
    ,"initComponent":    function() {
        this.callParent();
        this.actions.viewPatientChart.setDisabled(true);
        this.actions.viewPatientSchedule.setDisabled(true);
        this.actions.worksheet.setDisabled(true);
        this.on('itemclick', function(view, record){
            var recordType = this.getRecordType(record);
            this.actions.viewPatientChart.setDisabled(this.getSelectionModel().getCount() != 1);
            if (recordType == 3 || recordType == 1){
                this.actions.viewPatientSchedule.setDisabled(recordType != 1);
                this.actions.worksheet.setDisabled(this.getSelectionModel().getCount() != 1);
            }else{
                this.actions.viewPatientSchedule.setDisabled(true);
                this.actions.worksheet.setDisabled(true);
            }
        },this);
        this.on('itemdblclick', function(view, record, e){
            var mainApp = this.up("#app");
            var mainPanel = this.up("#main_panel");
            var recordType = this.getRecordType(record);
            this.viewChart(record,  recordType);
        }, this);
    }
    ,"getRecordType":    function(record){
        var patientRecordType = record.get("patient_record_type");
        var treatmentRequestRecordType = record.get("treatment_request_record_type");
        var patientTreatmentRecordType = record.get("patient_treatment_record_type");
        if(patientRecordType){
            var recordType = patientRecordType;
        }else if(treatmentRequestRecordType){
            var recordType = treatmentRequestRecordType;
        }else if(patientTreatmentRecordType){
            var recordType = patientTreatmentRecordType;
        }
        return recordType;
    }
    ,"viewChart":    function(record, recordType){
        var mainApp = this.up("#app");
        var mainPanel = this.up("#main_panel");
        if(recordType == 1){
            this.selectEpisode({episode_id: record.get('e_id')}, function(res) {
                if (res) {
                    mainApp.setContext(res, function() {
                        launchComponent("PProfile", "p_profile");
                    });
                }
            });
        }else if(recordType == 2){
            this.selectPatient({patient_id: record.get("patient_id")}, function(res){
                if(res){
                    mainApp.setContext(res, function() {
                        launchComponent("PProfile", "p_profile");
                    });
                }
            });
        }else if(recordType == 3){
            this.selectReferral({referral_id: record.get("treatment_request_id")}, function(res){
                if(res){
                    mainApp.setContext(res, function() {
                        launchComponent("PProfile", "p_profile");
                    });
                }
            });
        }
    }
    ,"onViewPatientChart":    function(){
        if(this.getSelectionModel().getCount() == 1){
            var record = this.getSelectionModel().selected.items[0];
            var recordType = this.getRecordType(record);
            this.viewChart(record, recordType);
        } else
            Ext.MessageBox.alert('Status', 'Please select episode to view chart.');
    }
    ,"onViewPatientSchedule":    function(){
        var selModel = this.getSelectionModel();
        if(selModel.getCount() == 1 && selModel.selected.items[0].get('patient_treatment_record_type') == 1){
            var episodeId = selModel.selected.items[0].get('e_id');
            this.selectEpisode({episode_id: episodeId}, function(res) {
                if (res) {
                    var main_app = this.up("#app");
                    main_app.setContext(res, function(){
                        var w = new Ext.window.Window({
                            height: "80%",
                            width: "85%",
                            modal: true,
                            layout:'fit',
                            buttons: [
                                {
                                    text: "Close",
                                    listeners: {
                                        click: function(){
                                            w.close();
                                        }
                                    }
                                }
                            ],
                            title: "Patient Schedule"
                        });
                        w.show();
                        main_app.loadNetzkeComponent({name: "patient_schedules_with_patient_details", container:w, callback: function(w){
                            w.show();
                        }});
                    }, this);
                } else
                    Ext.MessageBox.alert('Status', 'Patient is yet to be admitted.');
            });
        } else
            Ext.MessageBox.alert('Status', 'Please select episode to view schedule.');
    }
    ,"onWorksheet":    function(){
        var selModel = this.getSelectionModel();
        if (selModel.getCount() != 1) {
            Ext.MessageBox.alert('Status', 'Please select record to view profile.');
            return;
        }
        var record = selModel.selected.first();
        var data = record.data;
        var patientRecordType = data.patient_record_type;
        var treatmentRequestRecordType = data.treatment_request_record_type;
        var patientTreatmentRecordType = data.patient_treatment_record_type;
        if(patientRecordType){
            this.recordType = patientRecordType;
        }else if(treatmentRequestRecordType){
            this.recordType = treatmentRequestRecordType;
        }else if(patientTreatmentRecordType){
            this.recordType = patientTreatmentRecordType;
        }
        if(this.recordType == 1)
            recordId = record.get("e_id");
        else if(this.recordType == 3)
            recordId = record.get("treatment_request_id");
        this.viewWorksheet({record_id: recordId, record_type: this.recordType});
    }
    ,"launchReport":    function(options) {
        this.loadNetzkeComponent({name: "launch_report_window", callback: function(w){w.show();},
            params: {component_params: options}});
    }
    ,"onAddPatient":    function(){
        this.createNewRecordAndReturnId({},function(result) {
            var recordId = result.id;
            this.loadNetzkeComponent({name: "patient_edit_form",
                params: {record_id: recordId},
                callback: function(w){
                    w.show();
                    w.on('close', function(){
                        if (w.closeRes && w.closeRes.status === "referral_no") {
                            this.store.load();
                        }else if (w.closeRes && w.closeRes.status === "referral_yes") {
                            Ext.MessageBox.confirm('Confirm', 'Do you wish to create a staffing for this patient?', function(result){
                                if (result == "yes") {
                                    this.selectReferralId({patient_id: w.closeRes.patient_id}, function(treatment_request_id){
                                        launchPatientWindow({component_class_name: "Staffing", height: "80%", width: "90%", treatment_request_id: treatment_request_id,
                                            params: {treatment_request_id: treatment_request_id, treatment_id: null, episode_id: null, record_type: 3, patient_id: w.closeRes.patient_id}, grid_item_id: "episodes_list"});
                                    }, this);
                                } else {
                                    this.store.load();
                                }
                            }, this);
                        }
                    }, this);
                }, scope: this});
        });
    }
    ,"onAddReferral":    function(){
        this.loadNetzkeComponent({name: "referral_new_form", callback: function(w){
            w.show();
            w.on('close', function(){
                if (w.closeRes === "ok") {
                    this.store.load();
                }
            }, this);
        }, scope: this});
    }
    ,"onCensusReport":    function(){
        var g = this;
        var w = new Ext.window.Window({
            width: "858px",
            height: "423px",
            modal: true,
            layout:'fit',
            buttons: [
                {
                    text: "",
                    tooltip: "OK",
                    iconCls: "ok_icon",
                    listeners: {
                        click: function(){
                            w.down("#census_report").runCensusReport(w, g);
                        }
                    }
                },
                {
                    text: "",
                    tooltip: "Cancel",
                    iconCls: "cancel_icon",
                    listeners: {
                        click: function(){w.close();}
                    }
                }
            ],
            title: "Census Report",
        });
        w.show();
        this.loadNetzkeComponent({name: "census_report_form", container:w, callback: function(w){
            w.show();
        }});
    }
}, {
    extend: 'Netzke.classes.Mahaswami.GridPanel',
    alias: 'widget.episodeslist'
}));

Netzke.cache.push('episodeslist');

Ext.define('Netzke.classes.EpisodesListExplorer', Netzke.chainApply({"initComponent":    function(){
    this.callParent();
    //this.resetSessionContext();
    checkBoxList = this.down("#patients_list_filter").query("checkboxfield");
    Ext.each(checkBoxList, function(checkBox, index){
        checkBox.on('change', function(ele){
            var treatmentStatus = checkBox.up('checkboxgroup').getValue().treatment_status;
            this.setTreatmentStatus({treatment_status: treatmentStatus});
        }, this);
    }, this);
}
    ,"refreshGrids":    function(){
        this.down("#episodes_list").store.load();
    }
}, {
    extend: 'Netzke.classes.Basepack.Panel',
    alias: 'widget.episodeslistexplorer'
}));

Netzke.cache.push('episodeslistexplorer');
Ext.override(Ext.ux.StatusBar, {
    hideBusy : function(){
        return this.setStatus({
            text: this.defaultText,
            iconCls: this.defaultIconCls
        });
    }
});


Ext.ns("Netzke.classes.Basepack");
Ext.define('Netzke.classes.Basepack.SimpleApp', Netzke.chainApply({
        extend: 'Ext.container.Viewport',
        alias: 'widget.netzkebasepacksimpleapp',
        constructor: function(config) {
            Netzke.aliasMethodChain(this, "initComponent", "netzke");
            Netzke.classes.Basepack.SimpleApp.superclass.constructor.call(this, config);
        }
    }, Netzke.componentMixin,
    {
        initComponent: function(){
            this.callParent();

            this.mainPanel = this.down('panel[itemId="main_panel"]');
            this.menuBar   = this.down('container[itemId="menu_bar"]');
            var statusBar = this.statusBar = this.down('container[itemId="status_bar"]');

            Ext.util.History.on('change', this.processHistory, this);

            // Setting the "busy" indicator for Ajax requests
            Ext.Ajax.on('beforerequest',    function(){ statusBar.showBusy(); });
            Ext.Ajax.on('requestcomplete',  function(){ statusBar.hideBusy(); });
            Ext.Ajax.on('requestexception', function(){ statusBar.hideBusy(); });

            // Initialize history
            Ext.util.History.init();
        },

        afterRender: function(){
            this.callParent();

            // If we are given a token, load the corresponding component, otherwise load the last loaded component
            var currentToken = Ext.util.History.getToken();
            if (currentToken != "") {
                this.processHistory(currentToken);
            } else {
                var lastLoaded = this.initialConfig.componentToLoad; // passed from the server
                if (lastLoaded) Ext.util.History.add(lastLoaded);
            }
        },

        processHistory: function(token){
            if (token){
                this.mainPanel.removeAll();
                this.loadNetzkeComponent({name: token, container: this.mainPanel});
            } else {
                this.mainPanel.removeAll();
            }
        },

        // instantiateComponent: function(config){
        //   this.mainPanel.instantiateChild(config);
        // },

        appLoadComponent: function(name){
            Ext.util.History.add(name);
        },

        loadNetzkeComponentByAction: function(action){
            var componentName = action.component || action.name;
            if (componentName) this.appLoadComponent(componentName);
        },

        // DEPRECATED
        loadComponentByAction: function(action) {
            Netzke.deprecationWarning("loadComponentByAction is deprecated in favor of loadNetzkeComponentByAction");
            this.loadNetzkeComponentByAction(action);
        },

        onToggleConfigMode: function(params){
            this.toggleConfigMode();
        }
    }
    ,  {"layout":"border"}));

Netzke.cache.push('netzkebasepacksimpleapp');
Ext.override(Ext.ux.StatusBar, {
    hideBusy : function(){
        return this.setStatus({
            text: this.defaultText,
            iconCls: this.defaultIconCls
        });
    }
});

function launchComponent(componentName, url, params) {
    var main_app = Ext.ComponentQuery.query("#app")[0];
    window.history.pushState('', "Faster Notes", "/" + url);
    main_app.loadNetzkeComponent({name: componentName, container: main_app.mainPanel, params: {component_params: params}});
}

function launchPatientWindow(params) {
    var main_app = Ext.ComponentQuery.query("#app")[0];
    if (!params.hasOwnProperty("height"))
        params["height"] = "40%";
    if (!params.hasOwnProperty("width"))
        params["width"] = "60%";
    main_app.loadNetzkeComponent({name: "patient_window", params: {component_params: params}});
}

function launchComponentInWindow(componentName, params) {
    var main_app = Ext.ComponentQuery.query("#app")[0];
    var w = new Ext.window.Window({
        height: 500,
        width: 600,
        modal: true,
        layout:'fit',
        buttons: [
            {
                text: "OK",
                listeners: {
                    click: function(){
                        g.sendUpdatedReferralReceivedDate(w, "#{record.id}")
                    }
                }
            },
            {
                text: "Cancel",
                listeners: {
                    click: function(){w.close();}
                }
            }
        ],
        xtitle: "Referral Received Date"
    });
    w.show();
    main_app.loadNetzkeComponent({name: componentName, params: {component_params: params}, container:w, callback: function(w){
        w.show();
    }});

}

Ext.define('Netzke.classes.App', Netzke.chainApply({"onSignOut":    function() {
    window.location="/signout"
}
    ,"onAbout":    function(e){
        var msg = [
            '',
            "&copy; Copyright FasterNotes 2012.  All rights reserved."
        ].join("<br/>");

        Ext.Msg.show({
            width: 300,
            title:'About',
            msg: msg,
            buttons: Ext.Msg.OK,
            animEl: e.getId()
        });
    }
    ,"processHistory":    function(token){
        return true;
        if (token) {
            var node = this.navigation.getStore().getRootNode().findChildBy(function(n){
                return n.raw.component == token;
            }, this, true);

            if (node) this.navigation.getView().select(node);
        }

        this.callParent([token]);
    }
    ,"loadPatientsList":    function(){
        var main_app = this;
        this.clearPatientProfileInformation({}, function(){
            this.setContext({}, function(){
                main_app.loadNetzkeComponent({name: "EpisodesListExplorer", container: main_app.mainPanel, params: {}});
            }, this);
        }, this);
    }
}, {
    extend: 'Netzke.classes.Basepack.SimpleApp',
    alias: 'widget.app'
}));

Netzke.cache.push('app');
