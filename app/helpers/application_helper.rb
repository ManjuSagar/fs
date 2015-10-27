module ApplicationHelper

  def netzke_ext_js_include(params)
    super +
    javascript_include_tag("/javascripts/loader") +
    javascript_include_tag("/javascripts/openlayers/OpenLayers.js")
  end

  def netzke_ext_css_include(params)
    theme = "-#{params[:theme]}" unless params[:theme].blank?
    res = ["#{Netzke::Core.ext_uri}/ext-all#{theme}"]
    res = ["#{Netzke::Core.ext_uri}/ext-theme-neptune-all.css"]
    # Netzke-related dynamic css
    res << "/netzke/ext"

    res += Netzke::Core.external_ext_css

    stylesheet_link_tag(*res)
  end
end
