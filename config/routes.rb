Rails.application.routes.draw do
  # match "/users/auth/sreamlabs", via: [:get, :post], to: "connections#streamlabs"
  devise_for :users, controllers: { omniauth_callbacks: 'login' }



  # match "/connect/streamelements", via: [:get, :post], to: "connections#passthru"

  get :logout, to: "sessions#logout", as: :logout
  root to: "pages#startpage"


  # create donations
  scope format: false do
    get  "/:donation_url", to: "donations#new", as: :new_donation
    post "/:donation_url", to: "donations#create", as: :donations
    get "/:donation_url/:uuid", to: "donations#show", as: :donation
  end




end
