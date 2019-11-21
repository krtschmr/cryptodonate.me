Rails.application.routes.draw do
  # match "/users/auth/sreamlabs", via: [:get, :post], to: "connections#streamlabs"
  devise_for :users, controllers: { omniauth_callbacks: 'login' }



  # match "/connect/streamelements", via: [:get, :post], to: "connections#passthru"


  get :logout, to: "sessions#logout", as: :logout
  root to: "pages#startpage"

end
