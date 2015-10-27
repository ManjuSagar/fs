class MedicalOrderDocumentAttachmentForm < Mahaswami::FormPanel

  def configuration
    c = super
    component_session[:treatment_id] ||= MedicalOrder.find_by_id(c[:medical_order_id]).treatment.id if c[:medical_order_id]
    c.merge(
        items: [
            {name: :document__document_name, field_label: 'Document Name'},
        ]
    )
  end

  def document__document_name_combobox_options(params)
    values = []
    unless component_session[:treatment_id].nil?
      documents = PatientTreatment.find(component_session[:treatment_id]).documents.order('document_date ASC')
      attached_medical_order_docs = MedicalOrder.find_by_id(config[:medical_order_id]).attached_docs
      attached_docs = attached_medical_order_docs.collect{|md| md.document }
      values = documents.reject{|d| attached_docs.include?(d) }.collect{|d| [d.id, "#{d.document_definition.document_name} (#{d.document_date.strftime('%m/%d/%Y')})"]}
    end
    {:data => values}
  end

end