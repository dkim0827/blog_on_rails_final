Rails.application.routes.draw do
  root 'welcome#index'

  get '/users/:id/password/edit', to: 'users#password_edit', as: 'password'
  patch '/users/:id/password/edit', to: 'users#password_update', as: 'update_password'
  
  resources :posts do
    resources :comments, only: [:create, :edit, :destroy, :update]
  end
  
  resources :users
  
  resource :session, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
