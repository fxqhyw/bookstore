module HomeHelper
  def log_helper
    if user_signed_in?
      link_to 'Log out', destroy_user_session_path, method: :delete
    else
      link_to 'Log in', new_user_session_path, method: :get
    end
  end
end
