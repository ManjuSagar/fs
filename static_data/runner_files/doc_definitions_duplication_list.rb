DOC_DEFINITIONS =  ['SOC_OASIS_C1', 'OASIS_DAH_C1', 'OASIS_DFA_C1', "OASIS_OF_C1", "OASIS_RR_C1", "OASIS_ROC_C1",
                    "OASIS_TIFPD_C1", "OASIS_TIFPND_C1"]

orgs = HealthAgency.all
org_doc_definitions = []
used_doc_definitions = []
docs_duplicated_agencies = []

orgs.each do |org|
  Org.current = org
  org_definitions = DocumentDefinition.org_scope.where(document_code: DOC_DEFINITIONS).group_by(&:document_name)
  org_definitions.each do |key, value|
    next if value.size == 1
    docs_duplicated_agencies << org.to_s
    value.each {|v|
      doc_count = Document.org_scope(org).where(document_definition_id: v.id).count
      if doc_count == 0
        debug_log "Agency: #{org}: doc: #{v}: count: #{doc_count}: Deleting"
        v.destroy
        break
      end
    }
=begin
    records_list = Document.org_scope(org).where(["document_definition_id in (?)", value.map(&:id)]).map(&:document_definition_id)
    debug_log "records_list.........#{records_list}"

    if records_list.uniq.size > 1
      org_doc_definitions << {:"#{org.to_s}" => {:"#{key}" => records_list}}
    else
      used_doc_definitions << {:"#{org.to_s}" => {:"#{key}" => records_list}} unless records_list.empty?
    end
=end
  end
end

debug_log "duplicates list ...#{org_doc_definitions}"
debug_log "used list ...#{used_doc_definitions}"
debug_log "docs_duplicated_agencies ...#{docs_duplicated_agencies.uniq}"

list = [1351, 1352, 1353, 1354, 1355, 1356, 1357, 1358]
  DocumentDefinition.where(id: list).destroy_all






