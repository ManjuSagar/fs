class VitalSignReferenceRangeForm < Mahaswami::FormPanel
  # To change this template use File | Settings | File Templates.


  def configuration
    c =  super
    c.merge(
        model: "VitalsReferenceRange",
        edit_form_window_config: { title: "Edit Document Set"},
        header: "Edit title",
        :strong_default_attrs => c[:strong_default_attrs],
        items: [
                  {name: :minimum_value, header: "Minimum Value" },
                  {name: :maximum_value, header: "Maximum Value"}
        ],
    )
  end
end