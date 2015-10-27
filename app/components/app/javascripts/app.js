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