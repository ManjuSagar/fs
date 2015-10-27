class MappingGrid < Netzke::Base

  js_base_class "gemgrid"
  def configuration
    s = super
    s.merge(
        border: false,
        height: 250,
        width: '100%',
        header: false,
        frame: true,
        style: {borderWidth: 1},
        item_id: 'mapping_gem_grid',
    )
  end

end