Ext.ns('Netzke');
Ext.ns('Netzke.core');
Netzke.RelativeUrlRoot = '';
Netzke.RelativeExtUrl = '/assets';
Netzke.core.directMaxRetries = 0;
// Some Ruby-ish String extensions
// from http://code.google.com/p/inflection-js/
if (!String.prototype.camelize) String.prototype.camelize = function(lowFirstLetter)
{
  var str=this; //.toLowerCase();
  var str_path=str.split('/');
  for(var i=0;i<str_path.length;i++)
  {
    var str_arr=str_path[i].split('_');
    var initX=((lowFirstLetter&&i+1==str_path.length)?(1):(0));
    for(var x=initX;x<str_arr.length;x++)
      str_arr[x]=str_arr[x].charAt(0).toUpperCase()+str_arr[x].substring(1);
    str_path[i]=str_arr.join('');
  }
  str=str_path.join('::');
  return str;
};

if (!String.prototype.capitalize) String.prototype.capitalize = function()
{
  var str=this.toLowerCase();
  str=str.substring(0,1).toUpperCase()+str.substring(1);
  return str;
};

if (!String.prototype.humanize) String.prototype.humanize = function(lowFirstLetter)
{
  var str=this.toLowerCase();
  str=str.replace(new RegExp('_id','g'),'');
  str=str.replace(new RegExp('_','g'),' ');
  if(!lowFirstLetter)str=str.capitalize();
  return str;
};

// This one is borrowed from prototype.js
if (!String.prototype.underscore) String.prototype.underscore = function() {
  return this.replace(/::/g, '/')
             .replace(/([A-Z]+)([A-Z][a-z])/g, '$1_$2')
             .replace(/([a-z\d])([A-Z])/g, '$1_$2')
             .replace(/-/g, '_')
             .toLowerCase();
};
/**
This file gets loaded along with the rest of Ext library at the initial load
At this time the following constants have been set by Rails:

  Netzke.RelativeUrlRoot - set to ActionController::Base.config.relative_url_root
  Netzke.RelativeExtUrl - URL to ext files
*/

// Initial stuff
Ext.ns('Ext.netzke'); // namespace for extensions that depend on Ext
Ext.ns('Netzke.page'); // namespace for all component instances on the page
Ext.ns('Netzke.classes'); // namespace for all component classes
Ext.ns('Netzke.classes.Core'); // namespace for Core mixins

Netzke.deprecationWarning = function(msg){
  if (typeof console == 'undefined') {
    // no console defined
  } else {
    console.info("Netzke: " + msg);
  }
};

Netzke.warning = Netzke.deprecationWarning;

Netzke.exception = function(msg) {
  throw("Netzke: " + msg);
};

// Used in testing
if( Netzke.nLoadingFixRequests == undefined ){
  Netzke.nLoadingFixRequests=0;
  Ext.Ajax.on('beforerequest',    function(conn,opt) { Netzke.nLoadingFixRequests+=1; });
  Ext.Ajax.on('requestcomplete',  function(conn,opt) { Netzke.nLoadingFixRequests-=1; });
  Ext.Ajax.on('requestexception', function(conn,opt) { console.log("Exception"); 
	  Netzke.nLoadingFixRequests-=1;
 });
  Netzke.ajaxIsLoading = function() { return Netzke.nLoadingFixRequests > 0; };
}

// Used in testing, too
Netzke.runningRequests = 0;
Netzke.isLoading=function () {
  return Netzke.runningRequests != 0;
}

// Similar to Ext.apply, but can accept any number of parameters, e.g.
//
//     Netzke.chainApply(targetObject, {...}, {...}, {...});
Netzke.chainApply = function(){
  var res = {};
  Ext.each(arguments, function(o){
    Ext.apply(res, o);
  });
  return res;
};

/* Similar to Rails' alias_method_chain. Usefull when using mixins. E.g.:

    Netzke.aliasMethodChain(this, "initComponent", "netzke")

    will result in 2 new methods on this.initComponentWithNetzke and this.initComponentWithoutNetzke
*/
Netzke.aliasMethodChain = function(klass, method, feature) {
  klass[method + "Without" + feature.capitalize()] = klass[method];
  klass[method] = klass[method + "With" + feature.capitalize()];
};

// xtypes of cached Netzke classes
Netzke.cache = [];

Netzke.componentNotInSessionHandler = function() {
	window.location.reload();
  //throw "Netzke: component not in Rails session. Define Netzke.componentNotInSessionHandler to handle this.";
};

Netzke.classes.Core.Mixin = {};

// Properties/methods common to all Netzke component classes
Netzke.componentMixin = Ext.applyIf(Netzke.classes.Core.Mixin, {
  isNetzke: true, // to distinguish Netzke components from regular Ext components

  /*
  Detects component placeholders in the passed object (typically, "items"),
  and merges them with the corresponding config from this.netzkeComponents.
  This way it becomes ready to be instantiated properly by Ext.
  */
  detectComponents: function(o){
    if (Ext.isObject(o)) {
      if (o.items) this.detectComponents(o.items);
    } else if (Ext.isArray(o)) {
      var a = o;
      Ext.each(a, function(c, i){
        if (c.netzkeComponent) {
          var cmpName = c.netzkeComponent,
              cmpCfg = this.netzkeComponents[cmpName.camelize(true)];
          if (!cmpCfg) throw "Netzke: unknown component reference " + cmpName;
          a[i] = Ext.apply(cmpCfg, c);
          delete a[i].netzkeComponent; // not needed any longer
        } else if (c.items) this.detectComponents(c.items);
      }, this);
    }
  },

  /*
  Evaluates CSS
  */
  evalCss : function(code){
    var head = Ext.fly(document.getElementsByTagName('head')[0]);
    Ext.core.DomHelper.append(head, {
      tag: 'style',
      type: 'text/css',
      html: code
    });
  },

  /*
  Evaluates JS
  */
  evalJs : function(code){
    eval(code);
  },

  /*
  Gets id in the context of provided parent.
  For example, the components "properties", being a child of "books" has global id "books__properties",
  which *is* its component's real id. This methods, with the instance of "books" passed as parameter,
  returns "properties".
  */
  localId : function(parent){
    return this.id.replace(parent.id + "__", "");
  },

  /*
  Executes a bunch of methods. This method is called almost every time a communication to the server takes place.
  Thus the server side of a component can provide any set of commands to its client side.
  Args:
    - instructions: can be
      1) a hash of instructions, where the key is the method name, and value - the argument that method will be called with (thus, these methods are expected to *only* receive 1 argument). In this case, the methods will be executed in no particular order.
      2) an array of hashes of instructions. They will be executed in order.
      Arrays and hashes may be nested at will.
      If the key in the instructions hash refers to a child Netzke component, bulkExecute will be called on that component with the value passed as the argument.

  Examples of the arguments:
      // same as this.feedback("Your order is accepted");
      {feedback: "You order is accepted"}

      // same as: this.setTitle('Suprise!'); this.setDisabled(true);
      [{setTitle:'Suprise!'}, {setDisabled:true}]

      // the same as this.getChildNetzkeComponent('users').bulkExecute([{setTitle:'Suprise!'}, {setDisabled:true}]);
      {users: [{setTitle:'Suprise!'}, {setDisabled:true}] }
  */
  bulkExecute : function(instructions){
    if (Ext.isArray(instructions)) {
      Ext.each(instructions, function(instruction){ this.bulkExecute(instruction)}, this);
    } else {
      for (var instr in instructions) {
        if (Ext.isFunction(this[instr])) {
          // Executing the method.
          this[instr].apply(this, [instructions[instr]]);
        } else {
          var childComponent = this.getChildNetzkeComponent(instr);
          if (childComponent) {
            childComponent.bulkExecute(instructions[instr]);
          } else {
            throw "Netzke: Unknown method or child component '" + instr +"' in component '" + this.id + "'"
          }
        }
      }
    }
  },

  // Used by Touch components
  endpointUrl: function(endpoint){
    return Netzke.RelativeUrlRoot + "/netzke/dispatcher?address=" + this.id + "__" + endpoint;
  },

  // Does the call to the server and processes the response
  callServer : function(intp, params, callback, scope){
    Netzke.runningRequests++;
    if (!params) params = {};
      Ext.Ajax.request({
      params: params,
      url: this.endpointUrl(intp),
      callback: function(options, success, response){
        if (success && response.responseText) {
          // execute commands from server
          this.bulkExecute(Ext.decode(response.responseText));

          // provide callback if needed
          if (typeof callback == 'function') {
            if (!scope) scope = this;
            callback.apply(scope, [this.latestResult]);
          }
        }
        Netzke.runningRequests--;
      },
      scope : this
    });
  },

  setResult: function(result) {
    this.latestResult = result;
  },

  // When an endpoint call is issued while the session has expired, this method is called. Override it to do whatever is appropriate.
  componentNotInSession: function() {
    Netzke.componentNotInSessionHandler();
  }
});


// DEPRECATED as whole. Netzke extensions for Ext.Container.
Ext.override(Ext.Container, {
  // Instantiates an component by its config. If it appears to be a window, shows it instead of adding as item.
  instantiateChild: function(config){
    Netzke.deprecationWarning("instantiateChild is deprecated");
    var instance = Ext.createByAlias( config.alias, config );
    this.insertNetzkeComponent(instance);
    return instance;
  },

  insertNetzkeComponent: function(cmp) {
    this.removeChild(); // first delete previous component
    this.add(cmp);

    // Sometimes a child is getting loaded into a hidden container...
    if (this.isVisible()) {
      this.doLayout();
    } else {
      this.on('show', function(cmp){cmp.doLayout();}, {single: true});
    }
  },

  /**
    Get Netzke component that this Ext.Container is part of (*not* the parent component, for which call getParent)
    It searches up the Ext.Container hierarchy until it finds a Container that has isNetzke property set to true
    (or until it reaches the top).
  */
  getOwnerComponent: function(){
    Netzke.deprecationWarning("getOwnerComponent is deprecated");
    if (this.initialConfig.isNetzke) {
      return this;
    } else {
      if (this.ownerCt){
        return this.ownerCt.getOwnerComponent();
      } else {
        return null;
      }
    }
  },

  // Get the component that we are hosting
  getNetzkeComponent: function(){
    Netzke.deprecationWarning("getNetzkeComponent is deprecated");
    return this.items ? this.items.first() : null; // need this check in case when the container is not yet rendered, like an inactive tab in the TabPanel
  },

  // Remove the child
  removeChild: function(){
    Netzke.deprecationWarning("removeChild is deprecated");
    var currentChild = this.getNetzkeComponent();
    if (currentChild) {this.remove(currentChild);}
  }
});
// Enable Ext 4 migration errors traceback display
if (Ext.Compat) Ext.Compat.showErrors = true;

// Because of Netzke's double-underscore notation, Ext.TabPanel should have a different id-delimiter (yes, this should be in netzke-core)
Ext.TabPanel.prototype.idDelimiter = "___";

Ext.QuickTips.init();

// We don't want no state managment by default, thank you!
Ext.state.Provider.prototype.set = Ext.emptyFn;

// Checking Ext JS version: both major and minor versions must be the same
(function(){
  var requiredVersionMajor = 4,
      requiredVersionMinor = 1,
      extVersion = Ext.getVersion('extjs'),
      currentVersionMajor = extVersion.getMajor(),
      currentVersionMinor = extVersion.getMinor(),
      requiredString = "" + requiredVersionMajor + "." + requiredVersionMinor + ".x";

  if (requiredVersionMajor != currentVersionMajor || requiredVersionMinor != currentVersionMinor) {
    Netzke.warning("Ext JS " + requiredString + " required (you have " + extVersion.toString() + ").");
  }
})();

// FeedbackGhost is a little class that displays unified feedback from Netzke components.
Ext.define('Netzke.FeedbackGhost', {
  showFeedback: function(msg){
    if (!msg) Netzke.exception("Netzke.FeedbackGhost#showFeedback: wrong number of arguments (0 for 1)");
    if (Ext.isObject(msg)) {
      this.msg(msg.level.camelize(), msg.msg);
    } else if (Ext.isArray(msg)) {
      Ext.each(msg, function(m) { this.showFeedback(m); }, this);
    } else {
      this.msg(null, msg); // no header for now
    }
  },

  msg: function(title, format){
      if(!this.msgCt){
          this.msgCt = Ext.core.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
      }
      var s = Ext.String.format.apply(String, Array.prototype.slice.call(arguments, 1));
      var m = Ext.core.DomHelper.append(this.msgCt, this.createBox(title, s), true);
      m.hide();
      m.slideIn('t').ghost("t", { delay: 1000, remove: true});
  },

  createBox: function(t, s){
    if (t) {
      return '<div class="msg"><h3>' + t + '</h3><p>' + s + '</p></div>';
    } else {
      return '<div class="msg"><p>' + s + '</p></div>';
    }
  }
});

// Mix it into every Netzke component as feedbackGhost
Netzke.componentMixin.feedbackGhost = Ext.create("Netzke.FeedbackGhost");

Ext.define('Netzke.classes.NetzkeRemotingProvider', {
  extend: 'Ext.direct.RemotingProvider',

  getCallData: function(t){
    return {
      act: t.action, // rails doesn't really support having a parameter named "action"
      method: t.method,
      data: t.data,
      type: 'rpc',
      tid: t.id
    }
  },

  addAction: function(action, methods) {
    var cls = this.namespace[action] || (this.namespace[action] = {});
    for(var i = 0, len = methods.length; i < len; i++){
      method = Ext.create('Ext.direct.RemotingMethod', methods[i]);
      cls[method.name] = this.createHandler(action, method);
    }
  },

  // HACK: Ext JS 4.0.0 retry mechanism is broken
  getTransaction: function(opt) {
    if (opt.$className == "Ext.direct.Transaction") {
      return opt;
    } else {
      return this.callParent([opt]);
    }
  }
});

Netzke.directProvider = new Netzke.classes.NetzkeRemotingProvider({
  type: "remoting",       // create a Ext.direct.RemotingProvider
  url: Netzke.RelativeUrlRoot + "/netzke/direct/", // url to connect to the Ext.Direct server-side router.
  namespace: "Netzke.providers", // namespace to create the Remoting Provider in
  actions: {},
  maxRetries: Netzke.core.directMaxRetries,
  enableBuffer: true, // buffer/batch requests within 10ms timeframe
  timeout: 30000 // 30s timeout per request
});

Ext.Direct.addProvider(Netzke.directProvider);

// Methods/properties that each and every Netzke component will have
Ext.apply(Netzke.classes.Core.Mixin, {
  /*
  Mask shown during loading of a component. Set to false to not mask. Pass config for Ext.LoadMask for configuring msg/cls, etc.
  Set msg to null if mask without any msg is desirable.
  */
  componentLoadMask: true,

  /* initComponent common for all Netzke components */
  initComponentWithNetzke: function(){
    this.normalizeActions();

    this.detectActions(this);

    // Detects component placeholders in the passed object (typically, "items"),
    // and merges them with the corresponding config from this.netzkeComponents.
    // This way it becomes ready to be instantiated properly by Ext.
    this.detectComponents(this.items);

    this.normalizeTools();

    this.processEndpoints();

    this.processPlugins();

    // This is where the references to different callback functions will be stored
    this.callbackHash = {};

    // This is where we store the information about components that are currently being loaded with this.loadComponent()
    this.componentsBeingLoaded = {};

    // Set title
    if (this.mode === "config"){
      if (!this.title) {
        this.title = '[' + this.id + ']';
      } else {
        this.title = this.title + ' [' + this.id + ']';
      }
    } else {
      if (!this.title) {
        this.title = this.id.humanize();
      }
    }

    // Call the original initComponent
    this.initComponentWithoutNetzke();
  },

  /*
  Dynamically creates methods for endpoints, so that we could later call them like: this.myEndpointMethod()
  */
  processEndpoints: function(){
    var endpoints = this.endpoints || [];
    endpoints.push('deliver_component'); // all Netzke components get this endpoint
    var directActions = [];
    var that = this;

    Ext.each(endpoints, function(intp){
      directActions.push({"name":intp.camelize(true), "len":1});
      this[intp.camelize(true)] = function(arg, callback, scope) {
        Netzke.runningRequests++;

        scope = scope || that;
        Netzke.providers[this.id][intp.camelize(true)].call(scope, arg, function(result, remotingEvent) {
          if(remotingEvent.message) {
            console.error("RPC event indicates an error: ", remotingEvent);
            throw new Error(remotingEvent.message);
          }
          that.bulkExecute(result); // invoke the endpoint result on the calling component
          if(typeof callback == "function") {
            callback.call(scope, that.latestResult); // invoke the callback on the provided scope, or on the calling component if no scope set. Pass latestResult to callback
          }
          Netzke.runningRequests--;
        });
      }
    }, this);

    Netzke.directProvider.addAction(this.id, directActions);
  },

  normalizeTools: function() {
    if (this.tools) {
      var normTools = [];
      Ext.each(this.tools, function(tool){
        // Create an event for each action (so that higher-level components could interfere)
        this.addEvents(tool.id+'click');

        var handler = Ext.Function.bind(this.toolActionHandler, this, [tool]);
        normTools.push({type : tool, handler : handler, scope : this});
      }, this);
      this.tools = normTools;
    }
  },

  /*
  Replaces actions configs with Ext.Action instances, assigning default handler to them
  */
  normalizeActions : function(){
    var normActions = {};
    for (var name in this.actions) {
      // Create an event for each action (so that higher-level components could interfere)
      this.addEvents(name+'click');

      // Configure the action
      var actionConfig = Ext.apply({}, this.actions[name]); // do not modify original this.actions
      actionConfig.customHandler = actionConfig.handler;
      actionConfig.handler = Ext.Function.bind(this.actionHandler, this); // handler common for all actions
      actionConfig.name = name;
      normActions[name] = new Ext.Action(actionConfig);
    }
    delete(this.actions);
    this.actions = normActions;
  },

  /*
  Detects action configs in the passed object, and replaces them with instances of Ext.Action created by normalizeActions().
  This detects action in arbitrary level of nesting, which means you can put any other components in your toolbar, and inside of them specify menus/items or even toolbars.
  */
  detectActions: function(o){
    if (Ext.isObject(o)) {
      if ((typeof o.handler === 'string') && Ext.isFunction(this[o.handler.camelize(true)])) {
         // This button config has a handler specified as string - replace it with reference to a real function if it exists
        o.handler = this[o.handler.camelize(true)].createDelegate(this);
      }
      // TODO: this should be configurable!
      Ext.each(["bbar", "tbar", "fbar", "menu", "items", "contextMenu", "buttons", "dockedItems"], function(key){
        if (o[key]) {
          var items = [].concat(o[key]); // we need to do it in order to esure that this instance has a separate bbar/tbar/etc, NOT shared via class' prototype
          delete(o[key]);
          o[key] = items;
          this.detectActions(o[key]);
        }
      }, this);
    } else if (Ext.isArray(o)) {
      var a = o;
      Ext.each(a, function(el, i){
        if (Ext.isObject(el)) {
          if (el.action) {
            if (!this.actions[el.action.camelize(true)]) throw "Netzke: action '"+el.action+"' not defined";
            a[i] = this.actions[el.action.camelize(true)];
            delete(el);
          } else {
            this.detectActions(el);
          }
        }
      }, this);
    }
  },

  /*
  Dynamically loads a Netzke component.
  Config options:
  'name' (required) - the name of the child component to load
  'container' - if specified, the id (or instance) of a panel with the 'fit' layout where the loaded component will be added to; the previously existing component will be destroyed
  'callback' - function that gets called after the component is loaded; it receives the component's instance as parameter
  'scope' - scope for the callback
  */
  loadNetzkeComponent: function(params){
    if (params.id) {
      params.name = params.id;
      Netzke.deprecationWarning("Using 'id' in loadComponent is deprecated. Use 'name' instead.");
    }

    params.name = params.name.underscore();

    // params that will be provided for the server API call (deliver_component); all what's passed in params.params is merged in. This way we exclude from sending along such things as :scope, :callback, etc.
    var serverParams = params.params || {};
    serverParams.name = params.name;

    // coma-separated list of xtypes of already loaded classes
    serverParams.cache = Netzke.cache.join();

    var storedConfig = this.componentsBeingLoaded[params.name] = params;

    // Remember where the loaded component should be inserted into
    var containerCmp = params.container && Ext.isString(params.container) ? Ext.getCmp(params.container) : params.container;
    storedConfig.container = containerCmp;

    // Show loading mask if possible
    var containerEl = (containerCmp || this).getEl();
    if (this.componentLoadMask && containerEl){
      storedConfig.loadMaskCmp = new Ext.LoadMask(containerEl, this.componentLoadMask);
      storedConfig.loadMaskCmp.show();
    }

    // do the remote API call
    this.deliverComponent(serverParams);
  },

  // DEPRECATED in favor or loadNetzkeComponent
  loadComponent: function(params) {
    Netzke.deprecationWarning("loadComponent is deprecated in favor of loadNetzkeComponent");
    params.container = params.container || this.getId(); // for backward compatibility
    this.loadNetzkeComponent(params);
  },

  /*
  Called by the server after we ask him to load a component
  */
  componentDelivered: function(config){
    // retrieve the loading config for this component
    var storedConfig = this.componentsBeingLoaded[config.name] || {};
    delete this.componentsBeingLoaded[config.name];

    if (storedConfig.loadMaskCmp) {
      storedConfig.loadMaskCmp.hide();
      storedConfig.loadMaskCmp.destroy();
    }

    var componentInstance = Ext.createByAlias(config.alias, config);

    if (storedConfig.container) {
      var containerCmp = storedConfig.container;
      if (!storedConfig.append) containerCmp.removeAll();
      containerCmp.add(componentInstance);

      if (containerCmp.isVisible()) {
        containerCmp.doLayout();
      } else {
        // if loaded into a hidden container, we need a little trick
        containerCmp.on('show', function(cmp){ cmp.doLayout(); }, {single: true});
      }
    }

    if (storedConfig.callback) {
      storedConfig.callback.call(storedConfig.scope || this, componentInstance);
    }

    this.fireEvent('componentload', componentInstance);
  },

  componentDeliveryFailed: function(params) {
    var storedConfig = this.componentsBeingLoaded[params.componentName] || {};
    delete this.componentsBeingLoaded[params.componentName];

    if (storedConfig.loadMaskCmp) {
      storedConfig.loadMaskCmp.hide();
      storedConfig.loadMaskCmp.destroy();
    }

    this.netzkeFeedback({msg: params.msg, level: "Error"});
  },

  /*
  DEPRECATED. Instantiates and renders a component with given config and container.
  */
  instantiateAndRenderComponent: function(config, containerId){
    var componentInstance;
    if (containerId) {
      var container = Ext.getCmp(containerId);
      componentInstance = container.instantiateChild(config);
    } else {
      componentInstance = this.instantiateChild(config);
    }
    return componentInstance;
  },

  /*
  Returns parent Netzke component
  */
  getParentNetzkeComponent: function(){
    // simply cutting the last part of the id: some_parent__a_kid__a_great_kid => some_parent__a_kid
    var idSplit = this.id.split("__");
    idSplit.pop();
    var parentId = idSplit.join("__");

    return parentId === "" ? null : Ext.getCmp(parentId);
  },

  // DEPRECATED
  getParent: function() {
    Netzke.deprecationWarning("getParent is deprecated in favor of getParentNetzkeComponent");
    return this.getParentNetzkeComponent();
  },

  /*
  Reloads current component (calls the parent to reload us as its component)
  */
  reload: function(){
    var parent = this.getParentNetzkeComponent();
    if (parent) {
      parent.loadNetzkeComponent({id:this.localId(parent), container:this.ownerCt.id});
    } else {
      window.location.reload();
    }
  },

  /*
  DEPRECATED: Reconfigures the component
  */
  reconfigure: function(config){
    this.ownerCt.instantiateChild(config)
  },

  /*
  Instantiates and returns a Netzke component by its name.
  */
  instantiateChildNetzkeComponent: function(name) {
    name = name.camelize(true);
    return Ext.createByAlias(this.netzkeComponents[name].alias, this.netzkeComponents[name])
  },

  /*
  Returns *instantiated* child component by its relative id, which may contain the 'parent' part to walk _up_ the hierarchy
  */
  getChildNetzkeComponent: function(id){
    if (id === "") {return this};
    id = id.underscore();
    var split = id.split("__");
    if (split[0] === 'parent') {
      split.shift();
      var childInParentScope = split.join("__");
      return this.getParentNetzkeComponent().getChildNetzkeComponent(childInParentScope);
    } else {
      return Ext.getCmp(this.id+"__"+id);
    }
  },

  // DEPRECATED
  getChildComponent: function(id) {
    Netzke.deprecationWarning("getChildComponent is deprecated in favor of getChildNetzkeComponent");
    return this.getChildNetzkeComponent(id);
  },

  /*
  Provides a visual feedback. TODO: refactor
  */
  netzkeFeedback: function(msg){
    if (this.initialConfig && this.initialConfig.quiet) {
      return false;
    }

    if (this.feedbackGhost) {
      this.feedbackGhost.showFeedback(msg);
    } else {
      // there's no application to show the feedback - so, we do it ourselves
      if (typeof msg == 'string'){
        alert(msg);
      } else {
        var compoundResponse = "";
        Ext.each(msg, function(m){
          compoundResponse += m.msg + "\n"
        });
        if (compoundResponse != "") {
          alert(compoundResponse);
        }
      }
    }
  },

  // DEPRECATED in favor of netzkeFeedback
  feedback: function(msg) {
    Netzke.deprecationWarning("feedback is deprecated in favor of netzkeFeedback");
    this.netzkeFeedback(msg);
  },

  /*
  Common handler for all netzke's actions. <tt>comp</tt> is the Component that triggered the action (e.g. button or menu item)
  */
  actionHandler: function(comp){
    var actionName = comp.name;
    // If firing corresponding event doesn't return false, call the handler
    if (this.fireEvent(actionName+'click', comp)) {
      var action = this.actions[actionName];
      var customHandler = action.initialConfig.customHandler;
      var methodName = (customHandler && customHandler.camelize(true)) || "on" + actionName.camelize();
      if (!this[methodName]) {throw "Netzke: action handler '" + methodName + "' is undefined"}

      // call the handler passing it the triggering component
      this[methodName](comp);
    }
  },

  // Common handler for tools
  toolActionHandler: function(tool){
    // If firing corresponding event doesn't return false, call the handler
    if (this.fireEvent(tool.id+'click')) {
      var methodName = "on"+tool.camelize();
      if (!this[methodName]) {throw "Netzke: handler for tool '"+tool+"' is undefined"}
      this[methodName]();
    }
  },

  processPlugins: function() {
    if (this.netzkePlugins) {
      if (!this.plugins) this.plugins = [];
      Ext.each(this.netzkePlugins, function(p){
        this.plugins.push(this.instantiateChildNetzkeComponent(p));
      }, this);
    }
  },

  onComponentLoad:Ext.emptyFn // gets overridden
});
/**
 * @class Ext.ux.form.field.DateTime
 * @extends Ext.form.FieldContainer
 * @version 0.2 (July 20th, 2011)
 * @author atian25 (http://www.sencha.com/forum/member.php?51682-atian25)
 * @author ontho (http://www.sencha.com/forum/member.php?285806-ontho)
 * @author jakob.ketterl (http://www.sencha.com/forum/member.php?25102-jakob.ketterl)
 * @link http://www.sencha.com/forum/showthread.php?134345-Ext.ux.form.field.DateTime
 * from http://www.sencha.com/forum/showthread.php?134345-Ext.ux.form.field.DateTime&p=863449&viewfull=1#post863449
 */
Ext.define('Ext.ux.form.field.DateTime', {
    extend:'Ext.form.FieldContainer',
    mixins:{
        field:'Ext.form.field.Field'
    },
    alias: 'widget.xdatetime',

    //configurables

    combineErrors: true,
    msgTarget: 'under',
    layout: 'hbox',
    readOnly: false,

    /**
     * @cfg {String} dateFormat
     * Convenience config for specifying the format of the date portion.
     * This value is overridden if format is specified in the dateConfig.
     * The default is 'Y-m-d'
     */
    dateFormat: 'Y-m-d',
    /**
     * @cfg {String} timeFormat
     * Convenience config for specifying the format of the time portion.
     * This value is overridden if format is specified in the timeConfig.
     * The default is 'H:i:s'
     */
    timeFormat: 'H:i:s',
//    /**
//     * @cfg {String} dateTimeFormat
//     * The format used when submitting the combined value.
//     * Defaults to 'Y-m-d H:i:s'
//     */
//    dateTimeFormat: 'Y-m-d H:i:s',
    /**
     * @cfg {Object} dateConfig
     * Additional config options for the date field.
     */
    dateConfig:{},
    /**
     * @cfg {Object} timeConfig
     * Additional config options for the time field.
     */
    timeConfig:{},


    // properties

    dateValue: null, // Holds the actual date
    /**
     * @property dateField
     * @type Ext.form.field.Date
     */
    dateField: null,
    /**
     * @property timeField
     * @type Ext.form.field.Time
     */
    timeField: null,

    initComponent: function(){
        var me = this
            ,i = 0
            ,key
            ,tab;

        me.items = me.items || [];

        me.dateField = Ext.create('Ext.form.field.Date', Ext.apply({
            format:me.dateFormat,
            flex:1,
            isFormField:false, //exclude from field query's
            submitValue:false
        }, me.dateConfig));
        me.items.push(me.dateField);

        me.timeField = Ext.create('Ext.form.field.Time', Ext.apply({
            format:me.timeFormat,
            flex:1,
            isFormField:false, //exclude from field query's
            submitValue:false
        }, me.timeConfig));
        me.items.push(me.timeField);

        for (; i < me.items.length; i++) {
            me.items[i].on('focus', Ext.bind(me.onItemFocus, me));
            me.items[i].on('blur', Ext.bind(me.onItemBlur, me));
            me.items[i].on('specialkey', function(field, event){
                key = event.getKey();
                tab = key == event.TAB;

                if (tab && me.focussedItem == me.dateField) {
                    event.stopEvent();
                    me.timeField.focus();
                    return;
                }

                me.fireEvent('specialkey', field, event);
            });
        }

        me.callParent();

        // this dummy is necessary because Ext.Editor will not check whether an inputEl is present or not
        //this.inputEl = {
        //    dom: document.createElement('div'),
        //    swallowEvent:function(){}
        //};

        me.initField();
    },

    focus:function(){
        this.callParent(arguments);
        this.dateField.focus();
    },

    onItemFocus:function(item){
        if (this.blurTask){
            this.blurTask.cancel();
        }
        this.focussedItem = item;
    },

    onItemBlur:function(item, e){
        var me = this;
        if (item != me.focussedItem){ return; }
        // 100ms to focus a new item that belongs to us, otherwise we will assume the user left the field
        me.blurTask = new Ext.util.DelayedTask(function(){
            me.fireEvent('blur', me, e);
        });
        me.blurTask.delay(100);
    },

    getValue: function(){
        var value = null
            ,date = this.dateField.getSubmitValue()
            ,time = this.timeField.getSubmitValue()
            ,format;

        if (date){
            if (time){
                format = this.getFormat();
                value = Ext.Date.parse(date + ' ' + time, format);
            } else {
                value = this.dateField.getValue();
            }
        }
        return value;
    },

    getSubmitValue: function(){
//        var value = this.getValue();
//        return value ? Ext.Date.format(value, this.dateTimeFormat) : null;

        var me = this
            ,format = me.getFormat()
            ,value = me.getValue();

        return value ? Ext.Date.format(value, format) : null;
    },

    setValue: function(value){
        if (Ext.isString(value)){
            value = Ext.Date.parse(value, this.getFormat()); //this.dateTimeFormat
        }
        this.dateField.setValue(value);
        this.timeField.setValue(value);
    },

    getFormat: function(){
        return (this.dateField.submitFormat || this.dateField.format) + " " + (this.timeField.submitFormat || this.timeField.format);
    },

    // Bug? A field-mixin submits the data from getValue, not getSubmitValue
    getSubmitData: function(){
        var me = this
            ,data = null;

        if (!me.disabled && me.submitValue && !me.isFileUpload()) {
            data = {};
            data[me.getName()] = '' + me.getSubmitValue();
        }
        return data;
    }
});
Ext.ns("Netzke.pre");
Ext.ns("Netzke.pre.Basepack");
Ext.ns("Ext.ux.grid");

Ext.apply(Ext.History, new Ext.util.Observable());

// A convenient passfield
// Ext.netzke.PassField = Ext.extend(Ext.form.TextField, {
//   inputType: 'password'
// });
// Ext.reg('passfield', Ext.netzke.PassField);

// Ext.override(Ext.ux.form.DateTimeField, {
//   format: "Y-m-d",
//   timeFormat: "g:i:s",
//   picker: {
//     minIncremenet: 15
//   }
// });

// ComboBox that gets options from the server (used in both grids and panels)
Ext.define('Ext.netzke.ComboBox', {
  extend        : 'Ext.form.field.ComboBox',
  alias         : 'widget.netzkeremotecombo',
  valueField    : 'field1',
  displayField  : 'field2',
  triggerAction : 'all',
  // WIP: Breaking - should not be 'true' if combobox is not editable
  // typeAhead     : true,

  initComponent : function(){
    var modelName = this.parentId + "_" + this.name;

    Ext.define(modelName, {
        extend: 'Ext.data.Model',
        fields: ['field1', 'field2']
    });

    var store = new Ext.data.Store({
      model: modelName,
      proxy: {
        type: 'direct',
        directFn: Netzke.providers[this.parentId].getComboboxOptions,
        reader: {
          type: 'array',
          root: 'data'
        }
      }
    });

    // TODO: find a cleaner way to pass this.name to the server
    store.on('beforeload', function(self, params) {
      params.params.column = this.name;
    },this);

    store.on('load', function(self, params) {
      self.insert(0, Ext.create(modelName, {field1: 0, field2: this.emptyText}));
    }, this);

    // If inline data was passed (TODO: is this actually working?)
    if (this.store) store.loadData({data: this.store});

    this.store = store;

    this.callParent();
  },

  collapse: function(){
    // HACK: do not hide dropdown menu while loading items
    if( !this.store.loading ) this.callParent();
  }
});

Ext.util.Format.mask = function(v){
  return "********";
};

// Ext.netzke.JsonField = Ext.extend(Ext.form.TextField, {
//   validator: function(value) {
//     try{
//       var d = Ext.decode(value);
//       return true;
//     } catch(e) {
//       return "Invalid JSON"
//     }
//   }
//
//   ,setValue: function(value) {
//     this.setRawValue(Ext.encode(value));
//   }
//
// });
//
// Ext.reg('jsonfield', Ext.netzke.JsonField);
//
// WIP: todo - rewrite Ext.lib calls below
// Ext.grid.HeaderDropZone.prototype.onNodeDrop = function(n, dd, e, data){
//     var h = data.header;
//     if(h != n){
//         var cm = this.grid.colModel;
//         var x = Ext.lib.Event.getPageX(e);
//         var r = Ext.lib.Dom.getRegion(n.firstChild);
//         var pt = (r.right - x) <= ((r.right-r.left)/2) ? "after" : "before";
//         var oldIndex = this.view.getCellIndex(h);
//         var newIndex = this.view.getCellIndex(n);
//         if(pt == "after"){
//             newIndex++;
//         }
//         if(oldIndex < newIndex){
//             newIndex--;
//         }
//         cm.moveColumn(oldIndex, newIndex);
//         return true;
//     }
//     return false;
// };
//
//
// Ext.ns('Ext.ux.form');

Ext.define('Ext.ux.form.TriCheckbox', {
  extend: 'Ext.form.field.ComboBox',
  alias: 'widget.tricheckbox',
  store: [[true, "Yes"], [false, "No"]],
  forceSelection: true
});

// Enabling checkbox submission when unchecked
// TODO: it would be nice to standardize return values
//  because currently checkboxes return "on", if checked,
//  and boolean 'false' otherwise. It's not nice
//  MAV
//  TODO: maybe we should simply initialize 'uncheckedValue' somewhere else,
//  instead
Ext.override( Ext.form.field.Checkbox, {
  getSubmitValue: function() {
    return this.callOverridden() || false; // 'off';
  }
});
