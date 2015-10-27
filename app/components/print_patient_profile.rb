module PrintPatientProfile

  def self.included(klass)
    klass.class_eval do
      endpoint :print_profile do |params|
        episodeId = component_session[:episode_id]
        patient_id = TreatmentEpisode.find(episodeId).treatment.patient_id
        report_url = "/reports/worksheet/#{patient_id}.pdf"
        {:launch_report => {url: report_url, title: "Profile", width: 800, height: 600}}
      end

      js_method :launch_report, <<-JS
        function(options) {
          this.loadNetzkeComponent({name: "launch_report_window", callback: function(w){w.show();},
          params: {component_params: options}});
        }
      JS

      component :launch_report_window do
        {
            class_name: "LaunchReport",
        }
      end

      component :treatment_activity_form do
        form_config = {
            class_name: "TreatmentActivityForm",
            parent_model: "PatientTreatment",
            treatment_id: component_session[:treatment_id],
            episode_id: component_session[:episode_id],
            event_name: component_session[:event_name],
            strong_default_attrs: {treatment_id: component_session[:treatment_id]},
            :border => true,
        :bbar => false,
        :prevent_header => true
        }
        {
            :lazy_loading => true,
            :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
            :width => "50%",
            :height => "70%",
            :title => (component_session[:event_name] ? "#{component_session[:event_name].titleize} Treatment" : "Treatment"),
            :button_align => "right",
            :items => [form_config]
        }
      end

      component :recertification_form do
        episode = TreatmentEpisode.find_by_id(component_session[:episode_id])
        episode_instance = TreatmentEpisode.new(treatment_id: component_session[:treatment_id])
        if episode
          episode_instance.start_date = episode.end_date + 1
          episode_instance.end_date = episode.end_date + episode.treatment.episode_period
        end
        form_config = {
            class_name: "RecertificationForm",
            treatment_id: component_session[:treatment_id],
            strong_default_attrs: {treatment_id: component_session[:treatment_id]},
            :border => true,
        :bbar => false,
        :prevent_header => true,
        :record => episode_instance
        }
        {
            :lazy_loading => true,
            :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
            :width => "50%",
            :height => "50%",
            :title => "Re-Certification",
            :button_align => "right",
            :items => [form_config]
        }

      end

      endpoint :select_treatment_and_event do |params|
        episode = TreatmentEpisode.find_by_id(params[:episode_id].to_i)
        component_session[:episode_id] = params[:episode_id].to_i
        component_session[:treatment_id] = episode.treatment_id if episode
        component_session[:event_name] = params[:event_name]
        {}
      end

      endpoint :undo_treatment do |params|
        debug_log component_session[:episode_id]
        episode_id = component_session[:episode_id] || params[:episode_id]
        episode = TreatmentEpisode.find(episode_id)
        treatment = episode.treatment if episode
        if treatment
          treatment.undo! if treatment.discharged?
          episode.reset_medicare_status
        end
        {}
      end
    end
  end

end