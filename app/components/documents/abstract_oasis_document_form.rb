class Documents::AbstractOasisDocumentForm < Documents::AbstractDocumentForm

  def configuration
    c = super
    component_session[:record_id] = c[:record_id] if c[:record_id]
    component_session[:params] = c[:strong_default_attrs] if c[:strong_default_attrs]
    c.merge(
        layout: :border,
        freeFormTemplate: false,
        show_oasis_document_actions: true,
        show_view_medications_action: true,
        items: [:patient_details.component, :oasis_container_form_panel.component]
    )
  end

  component :oasis_container_form_panel do
    items = get_form_panels
    count = -1
    {
        class_name: "Documents::OasisContainerFormPanel",
        title: "",
        region: :center,
        record: config[:record],
        record_id: component_session[:record_id],
        params: component_session[:params],
        model: config[:model],
        default: {
        header: false,
        border: false
    },
        items: items.collect{|i| count += 1; i.merge({header: false, border: false, auto_scroll: true, name: "panel_#{count}"}) },
        panel_details: get_combo_box_values,
        panel_details_1: get_combo_box_values_icd10,
        panel_details_2: get_combo_box_values_icd9
    }
  end

  def get_form_panels
    []
  end

  def get_combo_box_values
    []
  end

  def get_combo_box_values_icd10
    []
    end
  def get_combo_box_values_icd9
    []
  end


# Netze puts the external name for internal value for belongs_to automatically
# For those, regular column with remotecombo, we have to manually do this
  def js_record_data
    meta = meta_field
    meta[:association_values].merge!(additional_assoc_fields.literalize_keys) if meta[:association_values]
    form_fields = fields
    OasisExtension.store_attr_accessor.each do |field|
      form_fields.merge!({"#{field}".to_sym => {:name => field}})
    end
    res = record.netzke_hash(form_fields)
    res.merge(:_meta => meta).literalize_keys
  end

  def additional_assoc_fields
    r = {}
    r[:m1010_14_day_inp1_icd] = Icd9Code.find(record.m1010_14_day_inp1_icd).to_s if record.m1010_14_day_inp1_icd
    r
  end
end