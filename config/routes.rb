Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "top#index"
  get "cards_list/:user_id", to:"cards#list"
  get "learning/:id", to:"training#learning"
  get "test/:user_id", to:"training#test"
  post "edit_multiple", to:"cards#edit_multiple"
  post "update_multiple", to:"cards#update_multiple"
  post "answers/:user_id",to: "answers#add_results"
  get "weakpoint/:card_id", to:"weakpoint#change"
  delete "destroy_multiple", to:"cards#destroy_multiple"
  resources :cards, only: [:new, :create,:edit,:destroy,:update]
  
end
