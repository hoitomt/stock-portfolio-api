class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  def authenticate
    unless signed_in?
      puts "Unauthenticated User - Please sign in"
      redirect_to root_path, notice: "Please sign in"
    end
  end


end
