class Notes < Mahaswami::Panel
  def configuration
    c = super
    component_session[:d_id] = c[:document_id] if c[:document_id]
    note_form_required = false
    if component_session[:d_id]
      doc = Document.find(component_session[:d_id])
      note_form_required = doc.note_form_is_required?
    end
    c.merge(
        header: false,
        bbar: false,
        model: 'DocumentNote',
        border: false,
        item_id: 'notes',
        infinite_scroll: false,
        layout: 'border',
        :items => [
            :notes_list.component]+
            (note_form_required == true ? [:note_form.component] : [])


    )
  end

  component :notes_list do
     {
        class_name: "DocumentsNotesList",
         region: 'center',
        bbar: false,
        context_menu: false,
        border: false,
        edit_on_dbl_click: false,
        parent_id: component_session[:d_id]
    }
  end

  component :note_form do
    {
        region: 'south',
        class_name: "NoteForm",
        strong_default_attrs: {document_id: component_session[:d_id]},
        height: 87,
        grid_item_id: config[:grid_item_id]
    }
  end

end