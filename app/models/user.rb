class User < ActiveRecord::Base

  validates :github_id, presence: true
  validates :auth_token, presence: true

  def self.authenticate(auth_token)
    User.find_by_auth_token(auth_token)
  end

  def self.fetch(access_token)
    user_params = user_params(access_token)
    find_or_create(access_token, user_params)
  end

  def self.find_or_create(access_token, user_params)
    user = find_or_create_by(github_id: user_params[:id]) do |user|
      user.name = user_params[:name]
      user.email = user_params[:email]
      user.github_access_token = access_token
      user.auth_token = SecureRandom.urlsafe_base64(nil, false)
    end
    user.valid? ? user : nil
  end

  def self.user_params(access_token)
    github_user = Api::Github.get_user(access_token)
    HashWithIndifferentAccess.new(github_user)
  end
end
