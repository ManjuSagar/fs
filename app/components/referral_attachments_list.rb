class ReferralAttachmentsList < Mahaswami::HasManyCollectionList
  association "referral_attachments"
  parent_model "TreatmentRequest"
  title "Attachments"

 def configuration
   s = super
   s.merge(
     columns: [
         {name: :attachment_type__attachment_description, header: "Type" },
         {name: :attachment_file_name, label: "File Name"},
         { name: :attachment, label: "", getter: lambda{ |r| link_to("Download", r.attachment.url, :target => "_blank")}},

     ],
     add_form_window_config: {
         title: "Add Attachment"
     },

     add_form_config: {
         class_name: "ReferralAttachmentForm",
     },
     bbar: ((Org.current.is_a? StaffingCompany) ? [] : [:add_in_form.action, :del.action]),
     context_menu: ((Org.current.is_a? StaffingCompany) ? [] : [:add_in_form.action, :del.action])

   )
 end


end