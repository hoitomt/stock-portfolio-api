class PagesController < ApplicationController
  skip_before_filter :authenticate, only: [:index, :github_login, :github_verify]

  def index
    puts "Params #{params}"
  end

  def test
    put "Testing Authentication"
  end

  def github_login
    redirect_to Api::Github.auth_code_url
  end

  def github_verify
    puts "Verify Params #{params}"
    access_token = Api::Github.get_access_token(params[:code])

    @user = User.fetch(access_token)
    session[:auth_token] = @user.auth_token
    logger.info("session[:local_referer] #{session[:local_referer]}")
    if session[:local_referer] == "api"
      session[:local_referer] = nil
      redirect_to api_v1_users_verify_path(user_id: @user.id)
    else
      session[:local_referer] = nil
      redirect_to root_path
    end
  end
end