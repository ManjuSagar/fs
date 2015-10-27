class ChangeRelationToInsuredColumn < ActiveRecord::Migration
  def change
    relationships = {Self: "18", Father: "G8", Mother: "G8", Spouse: "01", Son: "19", Daughter: "19",Other: "G8"}

    PatientInsuranceCompany.all.each do |p_ins|
      if p_ins.relation_to_insured
        rel_code = relationships[p_ins.relation_to_insured.to_sym]
        p_ins.update_column(:relation_to_insured, rel_code)
      end
    end
  end

end
