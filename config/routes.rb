Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
