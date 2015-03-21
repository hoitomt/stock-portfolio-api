module ApplicationHelper
  def signed_in?
    if Rails.env.development?
      @user = User.first
      return @user
    end
    auth_token = session[:auth_token]
    @user = User.authenticate(auth_token)
  end
end
