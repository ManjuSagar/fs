module UsersHelper
  def current_user_is_office_staff?
    User.current.office_staff?
  end

  def current_user_is_consultant?
    User.current.consultant?
  end

  def created_user_is_field_staff?
    self.created_user.field_staff?
  end

  def created_user_is_office_staff?
    self.created_user.office_staff?
  end

  def current_user_is_created_user?
    User.current == self.created_user
  end

  def current_user_is_visited_fs?
    User.current.field_staff?
  end

  def ha_not_associated_with_consultant?
    self.org.consulting_companies.empty?
  end

end