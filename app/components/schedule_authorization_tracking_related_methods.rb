module ScheduleAuthorizationTrackingRelatedMethods

  def self.included(klass)
    klass.class_eval do
      endpoint :set_ins_id do |params|
        component_session[:ins_id] = params[:ins_id]
        ins = PatientInsuranceCompany.org_scope.where(insurance_company_id: component_session[:ins_id], patient_id: component_session[:patient_id]).first
        res = ins.patient_insurance_number if ins.present?
        {refresh_combo_store: [:patient_number, :insurance_case_manager]}
        {set_result: res}
      end

      endpoint :get_patient_primary_insurance_number do |params|
        {set_result: component_session[:primary_insurance_number]}
      end

      endpoint :set_case_manager do |params|
        result = []
        component_session[:ins_id] = params[:ins_id];
        insurance_company = InsuranceCompany.org_scope.where(id: params[:ins_id]).first
        case_managers = insurance_company.insurance_case_managers
        case_managers.each do |case_manager|
          res = [case_manager.id, case_manager.full_name]
          result << res
        end
        {set_result: result}
      end

      endpoint :set_discipline_id do |params|
        component_session[:discipline_id] = params[:discipline_id]
        {refresh_combo_store: :field_staff}
      end

      def episode_patient_name
        patient_combo = []
        patient = TreatmentEpisode.org_scope.where(id: component_session[:episode_id]).first.treatment.patient
        component_session[:patient_id] = patient.id
        patient_combo << [patient.id, patient.full_name]
        patient_combo
      end

      def patient_episode
        res = []
        treatment_episode = TreatmentEpisode.org_scope.where(id: component_session[:episode_id]).first
        res << [treatment_episode.id, treatment_episode.to_s]
        res
      end

      def insurance_case_manager__full_name_combobox_options(params)
        insurance_company = InsuranceCompany.org_scope.where(id: component_session[:ins_id]).first
        values = insurance_company.insurance_case_managers.collect{|i| [i.id, i.full_name]}
        {data: values}
      end


      def field_staff__to_s_combobox_options(params)
        discipline_id = component_session[:discipline_id]
        field_staffs =  FieldStaff.field_staffs_by_discipline(discipline_id)
        data = if params[:query].blank?
                 field_staffs.collect{|s| [s.id, s.to_s]}
               else
                 query = "#{params[:query].upcase}%"
                 values = field_staffs.empty??  [] : field_staffs.where(["upper(first_name) LIKE ? or upper(last_name) LIKE ?", query, query])
                 values = values.reject{|x| x.clinical_staff.present?}
                 values.collect!{|x| [x.id, x.full_name]}
               end
        {data: data}
      end

      js_method :insurance_company_change_event, <<-JS
        function(insuranceNumber, insCaseManager){
          this.down("#insurance_company").on("select", function(val){
           insuranceNumber.setValue(' ');
           insCaseManager.setValue(' ');
             this.setInsId({ins_id: val.value}, function(res){
               insuranceNumber.setValue(res);
             },this);
           this.setCaseManager({ins_id: val.value}, function(res){
             var insCaseManagerStore = this.down('#insurance_case_manager').store;
             var insCaseManager = this.down('#insurance_case_manager');
             insCaseManagerStore.removeAll();
             insCaseManagerStore.add(res);
             insCaseManager.setValue(insCaseManagerStore.getAt(0));
           },this);
         },this);
        }
     JS
    end
  end
end
