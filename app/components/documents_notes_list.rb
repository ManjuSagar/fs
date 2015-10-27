class DocumentsNotesList < Mahaswami::HasManyCollectionList
  association "document_notes"
  parent_model "Document"

  def configuration
    s = super
    s.merge(
        title: false,
        border: false,
        bbar: false,
        fbar: false,
        margin: "-2 0 0 0",
        padding: "0 5 2 0",
        cls: "document_notes",
        header: false,
        item_id: :notes_list,
        hideHeaders: true,
        emptyText: '',
        columns:[
            {name: :notes, editable: false, label: " ", id: "notes-row", getter: lambda {|r| document_notes(r)}, width: '100%'}
        ]
    )
  end

  def document_notes(r)
    r.event_changed == true ? user_action(r) : notes(r)
  end

  def notes(r)
    if User.current.user_type == 'OrgStaff'
      if r.created_user.user_type == 'OrgStaff'
        "<div class='bubble bubble-alt green'> #{r.notes_text} <span class=text-font-size> #{r.org_staff_name}</span></div>"
      else
        "<div class='bubble '> #{r.notes_text} <span class=text-font-size> #{r.field_staff_name}</span> </div>"
      end
    else
      if r.created_user.user_type == 'OrgStaff'
        "<div class='bubble green'> #{r.notes_text} <span class=text-font-size> #{r.org_staff_name}</span></div>"
      else
        "<div class='bubble bubble-alt'> #{r.notes_text} <span class=text-font-size> #{r.field_staff_name}</span> </div>"
      end
    end
  end

  def user_action(r)
    if r.created_user.user_type == 'OrgStaff'
      "<div class='without-bubble green'> #{r.created_user.full_name} (Office Staff) #{r.notes} #{r.note_date_format_with_out_time}</div>"
    else
      "<div class='without-bubble'> #{r.created_user.full_name} #{r.notes} #{r.note_date_format_with_out_time}</div>"
    end
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      this.getStore().on("load", function(s, records, successful, eOpts ){
        var d = this.getSelectionModel();
        d.select(s.count()-1);
      }, this);
    }
  JS
end