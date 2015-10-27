class PatientBasicInfo < Mahaswami::Panel

  def initialize(conf = {}, parent = nil)
    super
    config[:treatment_id] = component_session[:treatment_id]
  end


  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    @treatment = PatientTreatment.user_scope.find(component_session[:treatment_id])
    @patient = @treatment.patient
    s.merge(
        {
            border: false,
            title: "Basic Information",
            layout: {
                type: 'table',
                columns: 4,
                table_attrs: {
                    style: {width: "100%", "cell-padding" =>  5}
                },
                td_attrs: {
                    style: {
                        padding: "2px"
                    }
                }
            },
            items: [
                {
                    xtype: 'label',
                    text: patient_mobile_number
                },
                {
                    xtype: 'label',
                    text: "#{@patient.gender_string}"
                },
                {
                    xtype: 'label',
                    text: caregiver_1_info
                },
                {
                    xtype: 'label',
                    text: "Allergies : None"
                },
                {
                    xtype: 'label',
                    text: patient_phone_number
                },
                {
                    xtype: 'label',
                    text: "#{@patient.languages.first.to_s}"
                },
                {
                    xtype: 'label',
                    text: caregiver_1_phone_number
                },
                {
                    xtype: 'label',
                    text: "#{@patient.address_line_1}"
                },
                {
                    xtype: 'label',
                    text: "DOB : #{@patient.dob_string}"
                },
                {
                    xtype: 'label',
                    text: "Acuity Level : #{Patient::ACUITY_TYPES.detect{|x| x[0]==@patient.acuity_level}[1]}"
                },
                {
                    xtype: 'label',
                    text: caregiver_2_info
                },
                {
                    xtype: 'label',
                    text: "#{@patient.address_line_2}"
                },
                {
                    xtype: 'label',
                    text: "SSN : #{@patient.ssn}"
                },
                {
                    xtype: 'label',
                    text: "DNR/DNI : #{Patient::DNR[@patient.dnr]}/#{Patient::DNI[@patient.dni]}"
                },
                {
                    xtype: 'label',
                    text: caregiver_2_phone_number
                }
            ]
        })
  end

  def patient_phone_number
    @patient.phone_number_2.nil? ? "Home No. not Provided" : "#{@patient.phone_number_2} home"
  end

  def patient_mobile_number
    @patient.phone_number.nil? ? "Mobile No. not Provided" : "#{@patient.phone_number} mobile"
  end

  def caregiver_1_info
    @patient.patient_caregivers.first.to_s if @patient.patient_caregivers.size >= 1
  end

  def caregiver_2_info
    @patient.patient_caregivers[1].to_s if @patient.patient_caregivers.size >= 2
  end

  def caregiver_1_phone_number
    @patient.patient_caregivers.first.phone_number if @patient.patient_caregivers.size >= 1
  end

  def caregiver_2_phone_number
    @patient.patient_caregivers[1].phone_number if @patient.patient_caregivers.size >= 2
  end

end
