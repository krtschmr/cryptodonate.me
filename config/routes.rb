Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'login' }

  get :logout, to: "sessions#logout", as: :logout
  root to: "pages#startpage"

end
