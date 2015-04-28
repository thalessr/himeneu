require 'sidekiq/web'
Rails.application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, :controllers => { registrations: 'registrations', confirmations: 'confirmations'  }
  root to: 'dashboard#index'
  get 'dashboard' => 'dashboard#index'
  get 'privacy' => 'dashboard#privacy'
  get '/anuncie' => 'static_pages#anuncie'
  get '/sobre' => 'static_pages#sobre'
  get '/contato' => 'static_pages#contato'
  # get 'newpro' => 'static_pages#newpro'


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_scope :admin_user do
    authenticate :admin_user do
      mount Sidekiq::Web => 'admin/sidekiq'
    end
  end

# devise_scope :user do
#   authenticated :user do
#     root 'dashboard#index', as: :authenticated_root
#   end

#   unauthenticated do
#     root 'devise/sessions#new', as: :unauthenticated_root
#   end
# end

resources :customers do
  get 'search', on: :collection
  get 'recover', on: :collection
end

resources :providers do
  resources :address, only: [:create, :index]
  resources :recommendations
  get 'search', on: :collection
  get 'carousel', on: :collection
  get 'recover', on: :collection
  get 'cloud', on: :collection
end

resources :interests, :only => :create do
  post 'change_state', on: :collection
end

resources :feature_images, only: [:create, :destroy]
resources :estimates, :except => [:index, :new, :destroy]


end
