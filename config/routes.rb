Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  post "exchange", to: "site#exchange", as: "exchange"
  root "site#index"
end
