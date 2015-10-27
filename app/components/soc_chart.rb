class SocChart < Mahaswami::Panel
  include Mahaswami::NetzkeBase

  def initialize(conf = {}, parent = nil)
    super
    config[:treatment_id] = component_session[:treatment_id]
  end


  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:treatment_request_id] = s[:treatment_request_id]
    component_session[:chart_episode_id] = s[:chart_episode_id] if s[:chart_episode_id]
    s.merge(
        layout: :border,
        title: "",
        header: false,
        items: [
                 :referral_attachments.component
              ] + (component_session[:treatment_id] ? [:patient_episodes.component] : [])
    )
  end

  component :patient_episodes do
    {
       class_name: "Episodes",
       treatment_id: component_session[:treatment_id],
       parent_id: component_session[:treatment_id],
       chart_episode_id: component_session[:chart_episode_id],
       region: :center,
       border: false,
       height: 900,
       title: "Certification Periods"
    }
  end

  component :referral_attachments do
    {
       class_name: "ReferralAttachmentsList",
       treatment_id: component_session[:treatment_id],
       treatment_request_id: component_session[:treatment_request_id],
       parent_id: component_session[:treatment_request_id],
       region: (component_session[:treatment_id] ? "south" : "center"),
       title: "Referral Attachments",
       border: false,
       height:200
    }
  end

end