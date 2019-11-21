Rails.application.routes.draw do

  # Login and Logout
  devise_for :users, controllers: { omniauth_callbacks: 'login' }
  get :logout, to: "sessions#logout", as: :logout

  # Everything the user can do when he is logged in
  namespace :internal do
    # Connect streamelements and streamlabs
    # match "/users/auth/sreamlabs", via: [:get, :post], to: "connections#streamlabs"
    # match "/connect/streamelements", via: [:get, :post], to: "connections#passthru"


    # View Donations

    # View Stats

    # View history

    # Create Withdarawl

    # Account Settings

    # Overlay Settings


  end


  namespace :overlay do
    # custom :layout
    # custom :css
    # configurable via the settings
    get "/:uuid", to: "overlay#show"
  end

  #public pages
  # whatever we  need here?
  get "/how-it-works"
  get "/terms"
  get "/support"
  root to: "pages#startpage"


  #donation stuff to create new donations
  scope format: false do
    get  "/:donation_url",       to: "donations#new",    as: :new_donation
    post "/:donation_url",       to: "donations#create", as: :donations
    get  "/:donation_url/:uuid", to: "donations#show",   as: :donation
  end

end
