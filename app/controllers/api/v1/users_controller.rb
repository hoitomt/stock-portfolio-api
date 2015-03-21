class Api::V1::UsersController < ApplicationController
  skip_before_filter :authenticate

  def authenticate
    session[:local_referer] = "api"
    redirect_to Api::Github.auth_code_url
  end

  def verify
    @user = User.find(params[:user_id])
    render json: {access_token: @user}
  end

end