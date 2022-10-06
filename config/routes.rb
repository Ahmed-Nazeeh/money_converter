Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  post "exchange", to: "site#exchange", as: "exchange"
  get "site#index", to: "site#index", as: "site_index"
  root "welcome#index"
end
