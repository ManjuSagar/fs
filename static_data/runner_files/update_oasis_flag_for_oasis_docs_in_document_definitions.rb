templates = DocumentFormTemplate.all
  templates.each{ |template|
    template.update_attributes({:oasis => true}) if template.document_class_name.include?('Oasis')
    doc_version = if template.document_class_name.include?('C1') and template.oasis == true
                    'C1'
                  elsif template.oasis == true
                    'C'
                  end
    template.update_attributes({:document_type => doc_version})
  }

