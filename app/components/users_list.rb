class UsersList < Mahaswami::GridPanel
  model 'UserRole'
  attr_accessor :user

  def config
    super.merge(
      columns: [:user]
    )
  end


end