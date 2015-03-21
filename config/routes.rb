Rails.application.routes.draw do
  root to: "pages#index"

  get 'github_login', to: 'pages#github_login'

  # Used by github for authentication loop
  get 'github_verify', to: 'pages#github_verify'

  namespace :api do
    namespace :v1 do
      namespace :users do
        get 'authenticate'
        get 'verify'
      end
    end
  end

  get 'test', to: "pages#test"
end
