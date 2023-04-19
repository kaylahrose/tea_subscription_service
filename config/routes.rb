Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :customers, only: [] do
        resources :teas, only: [] do
          resources :subscriptions, only: [:create]
        end
        resources :subscriptions, only: [:index], controller: 'customers/subscriptions'
      end
      resources :subscriptions, only: [:update]
    end
  end
end
