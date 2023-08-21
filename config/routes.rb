Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace "api" do
    namespace "v1" do
      resources :properties
      get '/properties', to: 'properties#index'
      get '/properties/:id', to: 'properties#show'
      post '/properties', to: 'properties#create'
      patch '/properties/:id', to: 'properties#update'
      put '/properties/:id', to: 'properties#update'
      delete '/properties/:id', to: 'properties#destroy'

      get '/properties/owner/:owner', to: 'properties#by_owner'
      get '/properties/bedrooms/:bedrooms', to: 'properties#by_bedrooms'
      get '/properties/bathrooms/:bathrooms', to: 'properties#by_bathrooms'
      get '/properties/address/:address', to: 'properties#by_address'
    end
  end
end
