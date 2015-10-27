class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token

  #Logout action for clearing already login user before login other user.
  def logout_fn_user
    Devise.sign_out_all_scopes
    render text: "true", layout: false
  end
end
