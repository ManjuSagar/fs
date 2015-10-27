class MedicareInsuranceExports < OasisExportDocuments
  def configuration
    c = super
    c.merge(
        model: 'OasisExport',
        scope: :medicare_scope,

    )
  end

end