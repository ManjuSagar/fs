module ReportDataSource
  class AlirtsDataSource
    include JasperRails
    include AlirtsReportRelatedMethods
    attr_accessor :year, :date, :excess_visits

    def initialize(params)
      @year = params[:date].year
      @date = params[:date] if params[:date]
    end

    def non_covered_excess_visits
      list = ReportDataSource::VisitsNotCoveredByPlanOfCare.new({year: year})
      @excess_visits = list.visits_not_covered_by_plan_of_care
    end

    def patients_and_visits_by_ages
      list = ReportDataSource::PatientsAndVisitsByAge.new(date, excess_visits)
      list.patients_and_visits_by_age
    end

    def discharge_reasons
      list = ReportDataSource::DischargesByReason.new(year)
      list.dischanges_by_reason
    end

    def primary_source_of_payments
      list = ReportDataSource::AlirtsReportByPrimarySource.new(year, excess_visits)
      list.get_visits_by_primary_source
    end

    def discipline_visits
      list = ReportDataSource::VisitsByTypeOfStaff.new(year, excess_visits)
      list.visit_by_type_of_staff
    end

    def source_of_referral_admissions
      list = ReportDataSource::AdmissionsBySourceOfReferral.new(year)
      list.admission_by_source_of_referral
    end

    def patient_and_visits_by_icd_codes
      list = ReportDataSource::AlirtsReportByPrimaryDiagnosis.new(year, excess_visits)
      list.patients_visits_by_primary_diagnosis
    end

    def patient_and_visits_by_hiv_alzeimers
      list = ReportDataSource::AlirtsReportByPrimaryDiagnosis.new(year, excess_visits)
      list.get_hiv_codes
    end

  end

end
