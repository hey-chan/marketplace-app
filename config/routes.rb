Rails.application.routes.draw do
  resources :addresses
  resources :listings
  devise_for :users

  root to: "listings#index"
  get "/addresses", to: "addresses#my_address", as: "my_address"
  get "/addresses", to: "addresses#new_address"
  get "/success", to: "payments#success", as: "payment_success"
  post "/payments/webhook", to: "payments#webhook", as: "webhook"
  post "/payments", to: "payments#create_payment_intent", as: "create_payment_intent"
end
