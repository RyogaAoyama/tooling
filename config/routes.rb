Rails.application.routes.draw do
  namespace :api, format: 'json' do
    resources :towns, only: [:index]
    
    post "search", to: "search#search"
  end
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
