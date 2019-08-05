Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "top#index"
  get "cards_list/:user_id", to:"cards#list"
  post "edit_multiple", to:"cards#edit_multiple"
  resources :cards, only: [:new, :create,:edit,:destroy,:update]
  
end
