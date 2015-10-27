TreatmentEpisode.all.each do |episode|
  rap_invoice = episode.rap_invoice

  if rap_invoice.present?
    org = episode.treatment.patient.org
    next if org.blank?
    User.current = episode.treatment.patient.org.org_users.where({:role_type => 'A'}).first.user
    doc = episode.valid_oasis_doc
    next if doc.blank?
    episode.update_attributes({:rap_generated_document => doc.id})
  end

end