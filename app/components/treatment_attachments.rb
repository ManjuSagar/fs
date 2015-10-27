class TreatmentAttachments < Mahaswami::HasManyCollectionList
  association "attachments"
  parent_model "PatientTreatment"

  def initialize(conf = {}, parent = nil)
    super
  end
  action :add_in_form, text: "Add Attachment"

  def configuration
    c = super
    c.merge({
      columns: [ {name: :attachment_type__attachment_description, header: "Type" },
                 {name: :attachment_file_name, label: "File Name"},
                 {name: :attachment, label: "", getter: lambda{ |r| link_to("Download", r.attachment.url, :target => "_blank")}},

      ],
      add_form_window_config: {
          title: "Add Attachment"
      },
      add_form_config: {
          class_name: "TreatmentAttachmentForm",
      },
      scope: {treatment_episode_id: c[:episode_id]},
      strong_default_attrs: c[:strong_default_attrs].merge({treatment_episode_id: PatientTreatment.find(component_session[:parent_id]).treatment_episodes.first})
    })
  end

  def default_bbar
    [:add_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :del.action]
  end



end