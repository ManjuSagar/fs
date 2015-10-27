class VisitAttachmentForm < TreatmentAttachmentForm
  def configuration
    s = super
    s.merge(
        model: "VisitAttachment"
    )
  end

end