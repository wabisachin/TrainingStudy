Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "top#index"
  get "cards_list/:user_id", to:"cards#list"
  resources :cards, only: [:new, :create]
  
end
