Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :users, only: %i[show create destroy update]
      resources :users do
        resources :destinations, only: %i[index create update destroy show]
      end

      post '/login', to: 'sessions#create', as: 'login'
      delete '/logout', to: 'sessions#destroy', as: 'logout'
    end
  end

  namespace :api, format: 'json' do
    resources :towns, only: [:index]
    post 'search', to: 'search#search'
  end

  root to: 'home#index'
  get 'sandbox', to: 'home#index'
  get 'account/new', to: 'home#index'
  get 'search', to: 'home#index'

  get '*unmatched_route', to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
