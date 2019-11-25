Rails.application.routes.draw do
  post 'usuarios', to: 'users#create'
  post 'sesiones', to: 'authentication#login'
  resources :products, only: [:index, :show], as: :productos, path: "productos"  do
    resources :items, only: [:index, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
