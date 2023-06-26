Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :properties, only: [:index, :show, :create, :update, :destroy]

          # Retrieve a single property using property id
      get '/properties/:id', to: 'properties#show'

      # Retrieve multiple properties for a given owner
      get '/properties/owner/:owner', to: 'properties#properties_by_owner'

      # Retrieve multiple properties using additional filters
      get '/properties', to: 'properties#index'

      # Find a property by address
      get '/properties/address/:address', to: 'properties#find_by_address'
    end
  end

end
