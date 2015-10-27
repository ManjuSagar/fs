class RateVisitTypeCodeNullableInInsCompVisitTypeRates < ActiveRecord::Migration
  def change
    change_column :insurance_company_visit_type_rates, :rate, :decimal, :precision => 8, :scale => 2, :null => true
    change_column :insurance_company_visit_type_rates, :external_visit_type_code, :string, :limit => 20, :null => true
  end
end
