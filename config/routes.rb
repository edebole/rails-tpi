Rails.application.routes.draw do
  resources :users
  resources :contact_phones
  resources :clients
  resources :vat_conditions
  resources :products, as: :productos, path: "productos" do
    resources :items
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
