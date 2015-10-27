require 'geometry'

class StaffingMap < Mahaswami::Panel

  include Geometry

  def initialize(conf = {}, parent = nil)
    super
  end
  def configuration
    c = super
    component_session[:patient_id] ||= c[:patient_id]
    c[:items] = [{:xtype => 'gx_mappanel', :item_id => 'map_panel',}]

    patient_info = patient_details(component_session[:patient_id])
    fs_details = FieldStaff.org_scope.collect{|f| [f.id, f.full_name, phone_numbers(f) , f.license_type.license_type_code] +
        long_lat_for_location(f.location)}
    c[:res] = {fs_details: fs_details, patient_info: patient_info}
    c.merge(
        title: "Staff located near Patient's residence"
    )
  end
  js_properties :requires => [
      'Ext.container.Viewport',
      'Ext.window.MessageBox',
      'GeoExt.panel.Map',
      'GeoExt.Action',
      'GeoExt.form.field.GeocoderComboBox',
      'Ext.XTemplate']

  js_method :after_render, <<-JS
    function() {
      this.callParent();
      this.setLoading(true);
      var res = this.res;
        var map = new OpenLayers.Map();
        map.addLayer(new OpenLayers.Layer.OSM());

        this.vector = new OpenLayers.Layer.Vector('Polygons', {styleMap: new OpenLayers.StyleMap({
                  "default": new OpenLayers.Style({
                      fillColor: "#00ffee",
                      strokeColor: "#000000",
                      strokeWidth: 2,
                      label: "${name}\\n",
                      fontColor: "blue",
                      fontSize: "12px",
                      xfontFamily: "Courier New, monospace",
                      fontWeight: "bold",
                      labelAlign: "cm",
                      labelXOffset: "0",
                      labelYOffset: "20",
                      labelOutlineColor: "white",
                      labelOutlineWidth: 3
                  }) }) });

        map.addLayer(this.vector);

        this.markers = new OpenLayers.Layer.Markers("Markers");
        var icon_size = new OpenLayers.Size(12,20);
        var icon_offset = new OpenLayers.Pixel(-(icon_size.w/2), -icon_size.h);
        var fs_icon = new OpenLayers.Icon('http://labs.google.com/ridefinder/images/mm_20_purple.png', icon_size, icon_offset);

        var patient_icon = new OpenLayers.Icon('http://labs.google.com/ridefinder/images/mm_20_green.png', icon_size, icon_offset);

        map.addLayer(this.markers);

        this.addMarker(res.patientInfo.long, res.patientInfo.lat, res.patientInfo.id, patient_icon, res.patientInfo.name,
                       res.patientInfo.contactInfo);
        this.addPoint(res.patientInfo.long, res.patientInfo.lat, "Patient");

        Ext.each(res.fsDetails, function(details){
          var id = details[0];
          var name = details[1];
          var contactInfo = details[2];
          var licenseType = details[3];
          var long = details[4];
          var lat = details[5];
          this.addMarker(long, lat, id, fs_icon, name, contactInfo);
          this.addPoint(long, lat, licenseType);
        }, this);

        map.addControl(new OpenLayers.Control.LayerSwitcher());
        map.addControl(new OpenLayers.Control.MousePosition());

        var datapoint = new OpenLayers.LonLat(res.patientInfo.long, res.patientInfo.lat);
        var mapHeight = this.getParentNetzkeComponent() ? this.getParentNetzkeComponent().height : 700
        var mapWidth = this.getParentNetzkeComponent() ? this.getParentNetzkeComponent().width : 900

        var mapPanel = Ext.ComponentQuery.query('#map_panel')[0];
        mapPanel.map = map;
        mapPanel.height = mapHeight;
        mapPanel.width = mapWidth;
        mapPanel.center = this.transformPoint(datapoint);
        mapPanel.zoom = 10;
        mapPanel.doLayout();

        this.setLoading(false);

    }

  JS

  js_method :transform_point, <<-JS
    function(point) {
      var proj_1 = new OpenLayers.Projection("EPSG:4326");
      var proj_2 = new OpenLayers.Projection("EPSG:900913");
      return point.transform(proj_1, proj_2);
    }
  JS

  js_method :add_marker, <<-JS
    function(long, lat, id, icon, name, contactInfo) {
      var datapoint = new OpenLayers.LonLat(long, lat);
      var marker = new OpenLayers.Marker(this.transformPoint(datapoint), icon.clone());
/*
      Ext.create('Ext.tip.ToolTip', {
          closable: true,
          itemId: "tip_" + id,
          target: this.body,
          anchorToTarget: false,
          dismissDelay: 2000,
          html: "<h2>" + name + "</h2><br/>" + contactInfo
      });
*/
      marker.events.register('mousedown', marker, function(evt) {
        //Ext.ComponentQuery.query("#tip_" + id)[0].show();
        Ext.MessageBox.alert("Details", "<b>Name : </b>" + name + "<br/><b>Phone Number(s) : </b>" + contactInfo);
        OpenLayers.Event.stop(evt);
      });
      this.markers.addMarker(marker);
    }
  JS

  js_method :add_point, <<-JS
    function(long, lat, label) {
      var point = new OpenLayers.Geometry.Point(long, lat);
      var pointFeature = new OpenLayers.Feature.Vector(this.transformPoint(point));
      pointFeature.attributes = {
          name: label
      };

      this.vector.addFeatures([pointFeature]);
    }
  JS

  def patient_details(patient_id)
    patient = Patient.find(patient_id)
    long, lat = long_lat_for_location patient.address_string
    {long: long, lat: lat, id: patient.id, name: patient.full_name, contact_info: phone_numbers(patient)}
  end

  def long_lat_for_location(location)
    results = Geocoder.search(location)
    return [0,0] if results.empty?
    long = results[0].geometry["location"]["lng"]
    lat = results[0].geometry["location"]["lat"]
    [long,lat]
  end

  def phone_numbers(user)
    phone_numbers = user.phone_numbers.join(", ")
    phone_numbers.empty? ? "Not available" : phone_numbers
  end

end