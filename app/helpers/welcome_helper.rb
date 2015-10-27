module WelcomeHelper

  def current_user_is_office_staff?
    User.current.office_staff?
  end
end
