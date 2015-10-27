class PagingFormSample < Mahaswami::PagingFormPanel
  def configuration
    super.merge(
        :lazy_loading => true,
        :title => "Clerk Paging Form",
        :model => "Discipline",
        :scope => ["id = ?", 17]
    )
  end
end