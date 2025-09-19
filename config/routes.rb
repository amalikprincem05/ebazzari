Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


 
  get "home/index"
  get "home/contact"
  root "home#index"

 devise_for :users, controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations',
   passwords: 'users/passwords',
   confirmations: 'users/confirmations'
 }


  # admin namespace
  

  # shops and nested products
  resources :shops do
    resources :products
  end

  resources :products, only: [:index, :show] # public product listing

end
