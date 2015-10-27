require 'geometry'

class ServiceAreaSelectionWindow < Netzke::Basepack::Window

  include Geometry
  
  def configuration
    super.tap do |c|
      c[:width] = 800
      c[:height] = 600
      c[:auto_height] = true
      c[:collapsible] = true
      c[:title] = 'Select Service Areas'
      c[:items] = [{:xtype => 'gx_mappanel', :zoom => 5, 
      :item_id => 'map_panel',}]
      long, lat = fs_location
      c[:location] = {lat: lat, long: long}
      
      c[:coverageAreas] = FieldStaff.user_scope.first.field_staff_detail.areas_covered
    end
  end
  
  def fs_location
      fs = FieldStaff.user_scope.first
      combined_address = "#{fs.street_address} #{fs.suite_number}, #{fs.city}, #{fs.state}, #{fs.zip_code}"
      results = Geocoder.search(combined_address)
      long = results[0].geometry["location"]["lng"]
      lat = results[0].geometry["location"]["lat"]
      [long,lat]
  end

  js_properties :button_align => :right,
                :modal => true,
                :fbar => [:save.action, :check.action, :clear.action, :close.action],
                :collapsible => true, :requires => [
    'Ext.container.Viewport',
    'Ext.window.MessageBox',
    'GeoExt.panel.Map',
    'GeoExt.Action',
    'GeoExt.form.field.GeocoderComboBox',
    'Ext.XTemplate'
]


  action :save, text: "", icon: :save_new

  js_method :on_save, <<-JS
    function(params){
      var toSavePolygons = [];
      Ext.each(this.vector.features, function(p) {
        var vert = p.geometry.getVertices();
        var points = [];
        var proj_1 = new OpenLayers.Projection("EPSG:4326");
        var proj_2 = new OpenLayers.Projection("EPSG:900913");
        Ext.each(vert, function(p) {
          var datapoint = new OpenLayers.LonLat(p.x, p.y);
          var newPoint = datapoint.transform(proj_2, proj_1);    
          points.push([newPoint.lon, newPoint.lat]);
        }, this);
        toSavePolygons.push(points);
      }, this);
      this.save({coverageAreas: toSavePolygons}, function() {
        alert('Coverage Area Set successfully.');
      }, this);      
    }
  JS

  endpoint :save do |params|
    coverageAreas = params[:coverageAreas]
    fs = FieldStaff.user_scope.first
    fs.field_staff_detail.areas_covered = coverageAreas
    fs.field_staff_detail.save!
    {}
  end  

  action :clear 

  js_method :on_clear, <<-JS
    function(params){
      this.vector.removeAllFeatures();
    }
  JS

  action :close, text: "", icon: :cancel_new

  js_method :on_close, <<-JS
    function(params){
      var mapPanel = Ext.ComponentQuery.query('#map_panel')[0];
      mapPanel.map.destroy();
      this.close();
    }
  JS
  
  action :check, hidden: true

  js_method :on_check, <<-JS
    function(params){
      this.check({}, function(result) {
        alert('Using Field Staff himself as Patient: Covered = ' + result['covered']);
      } ,this);
    }
  JS
  
  endpoint :check do |params|
    fs = FieldStaff.user_scope.first
    # For test use the Field Staff himself as if he is a patient
    long, lat = fs.geocode_party(fs.address_string)
    {:set_result => {:covered => fs.is_within_preferred_coverage_area?(long, lat) }}
  end  
  
  js_method :restoredSavedCoverageAreas, <<-JS
    function(params){
      
      var proj_1 = new OpenLayers.Projection("EPSG:4326");
      var proj_2 = new OpenLayers.Projection("EPSG:900913");
      
      console.log(this.coverageAreas);
      Ext.each(this.coverageAreas, function(p) {
        var convertedPoints = [];
        Ext.each(p, function(point) {
          var datapoint = new OpenLayers.LonLat(point[0], point[1]);
          var newPoint = datapoint.transform(proj_1, proj_2);    
          convertedPoints.push(new OpenLayers.Geometry.Point(newPoint.lon, newPoint.lat));
        }, this);
        
        console.log(convertedPoints);

        var ring = new OpenLayers.Geometry.LinearRing(convertedPoints);
        var polygon = new OpenLayers.Geometry.Polygon([ring]);

        // create some attributes for the feature
        var attributes = {name: "my name", bar: "foo"};

        var feature = new OpenLayers.Feature.Vector(polygon, attributes);
        this.vector.addFeatures([feature]);        
        
      }, this);
         
    }
  JS
  

  js_method :init_component, <<-JS
    function(params){
    
    this.callParent();

    var mapPanel;

    var ctrl, toolbarItems = [], action, actions = {};
    var map = new OpenLayers.Map();
    var vector = new OpenLayers.Layer.Vector("vector");
    this.vector = vector;
    
    var locationLayer = new OpenLayers.Layer.Vector("Location", {
        styleMap: new OpenLayers.Style({
            externalGraphic: "http://openlayers.org/api/img/marker.png",
            graphicYOffset: -25,
            graphicHeight: 25,
            graphicTitle: "${name}"
        })
    });
    
    map.addLayers([new OpenLayers.Layer.OSM(), vector, locationLayer]);
    var lonLat = new OpenLayers.LonLat(this.location.long, this.location.lat);
    console.log(map.getProjectionObject());
    var datapoint = new OpenLayers.LonLat(this.location.long, this.location.lat);
    var proj_1 = new OpenLayers.Projection("EPSG:4326");
    var proj_2 = new OpenLayers.Projection("EPSG:900913");
    var newPoint = datapoint.transform(proj_1, proj_2);    
    map.setCenter(newPoint, 10);

    action = new GeoExt.Action({
        control: new OpenLayers.Control.ZoomToMaxExtent(),
        map: map,
        text: "Home",
        tooltip: "zoom to max extent"
    });
    actions["max_extent"] = action;
    toolbarItems.push(Ext.create('Ext.button.Button', action));
    toolbarItems.push("-");

    // Navigation control and DrawFeature controls
    // in the same toggle group
    action = new GeoExt.Action({
        text: "Navigate",
        control: new OpenLayers.Control.Navigation(),
        map: map,
        // button options
        toggleGroup: "draw",
        allowDepress: false,
        pressed: true,
        tooltip: "navigate",
        // check item options
        group: "draw",
        checked: true
    });
    actions["nav"] = action;
    toolbarItems.push(Ext.create('Ext.button.Button', action));

    polyOptions = {sides: 4, irregular: false};
    action = new GeoExt.Action({
        text: "Draw An Area",
        control: new OpenLayers.Control.DrawFeature(
            vector, OpenLayers.Handler.Polygon, {handlerOptions: polyOptions}
        ),
        map: map,
        // button options
        toggleGroup: "draw",
        allowDepress: false,
        tooltip: "Select An Area",
        // check item options
        group: "draw"
    });
    actions["draw_poly"] = action;
    toolbarItems.push(Ext.create('Ext.button.Button', action));

    // SelectFeature control, a "toggle" control
    action = new GeoExt.Action({
        text: "select",
        control: new OpenLayers.Control.SelectFeature(vector, {
            type: OpenLayers.Control.TYPE_TOGGLE,
            hover: true
        }),
        map: map,
        // button options
        enableToggle: true,
        tooltip: "select feature",
        hidden: true
    });
    actions["select"] = action;
    toolbarItems.push(Ext.create('Ext.button.Button', action));
    toolbarItems.push("-");

    // Navigation history - two "button" controls
    ctrl = new OpenLayers.Control.NavigationHistory();
    map.addControl(ctrl);

    action = new GeoExt.Action({
        text: "",
        control: ctrl.previous,
        disabled: true,
        iconCls: "icon-previous",
        tooltip: "Previous in history"
    });
    actions["previous"] = action;
    toolbarItems.push(Ext.create('Ext.button.Button', action));

    action = new GeoExt.Action({
        text: "",
        control: ctrl.next,
        disabled: true,
        iconCls: "icon-next",
        tooltip: "Next in history"
    });
    actions["next"] = action;
    toolbarItems.push(Ext.create('Ext.button.Button', action));
    toolbarItems.push("->");    
    toolbarItems.push(
        {
          xtype: "gx_geocodercombo",
          layer: locationLayer,
          url: "http://nominatim.openstreetmap.org/search?addressdetails=1&format=json&countrycodes=US",
          width: 300,
          hidden: true
        }
    );    

    var mapPanel = Ext.ComponentQuery.query('#map_panel')[0];
    var myToolbar = new Ext.Toolbar({
      dock: 'top',
      title: 'My Toolbar',
      items: toolbarItems
    });    
    mapPanel.addDocked(myToolbar);    

    mapPanel.map = map;
    mapPanel.doLayout();
    
    this.restoredSavedCoverageAreas();
    
      
    }
  JS
  
  
end

