class PrivateInsuranceExports < OasisExportDocuments
  def configuration
    s = super
    s.merge(
         model: "OasisExport",
         title: "Private",
         columns: s[:columns] + [
             {name: :insurance_company, editable: false, header: "Insurance Company",  width: "15%",  addHeaderFilter: true}
         ],
         scope: :private_scope
    )
  end
end