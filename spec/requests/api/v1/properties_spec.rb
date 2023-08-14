require 'swagger_helper'

RSpec.describe 'api/v1/properties', type: :request do

  path '/api/v1/properties' do

    post 'Creates a property' do
      tags 'Properties'
      consumes 'application/json'
      parameter name: :property, in: :body, schema: {
        type: :object,
        properties: {
          address: { type: :string },
          property_type: { type: :string },
          num_bedrooms: { type: :integer },
          num_sitting_rooms: { type: :integer },
          num_kitchens: { type: :integer },
          num_bathrooms: { type: :integer },
          num_toilets: { type: :integer },
          owner: { type: :string },
          description: { type: :string },
          valid_from: { type: :string, format: :'date-time' },
          valid_to: { type: :string, format: :'date-time' }
        },
        required: [ 'address', 'property_type', 'num_bedrooms', 'num_sitting_rooms', 'num_kitchens', 'num_bathrooms', 'num_toilets', 'owner', 'description', 'valid_from', 'valid_to' ]
      }

      response '201', 'property created' do
        let(:property) { { address: 'Doe', property_type: 'Flat', num_bedrooms: 2, num_sitting_rooms: 1, num_kitchens: 1, num_bathrooms: 2, num_toilets: 2, owner: 'John', description: 'A beautiful flat', valid_from: '2023-09-25', valid_to: '2024-09-25'} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:property) { { address: 'Doe' } }
        run_test!
      end
    end

    get 'Retrieves properties' do
      tags 'Properties'
      produces 'application/json'
      parameter name: :owner, in: :query, type: :string, description: 'Owner of the properties'
      parameter name: :num_bedrooms, in: :query, type: :integer, description: 'Number of bedrooms in the properties'
      parameter name: :num_bathrooms, in: :query, type: :integer, description: 'Number of bathrooms in the properties'
      parameter name: :address, in: :query, type: :string, description: 'Address of the properties'

      response '200', 'properties found' do
        run_test!
      end

      response '404', 'properties not found' do
        let(:owner) { 'invalid' }
        run_test!
      end
    end

  end

  path '/api/v1/properties/{id}' do

    get 'Retrieves a property' do
      tags 'Properties'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'property found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            address: { type: :string },
            property_type: { type: :string },
            num_bedrooms: { type: :integer },
            num_sitting_rooms: { type: :integer },
            num_kitchens: { type: :integer },
            num_bathrooms: { type: :integer },
            num_toilets: { type: :integer },
            owner: { type: :string },
            description: { type: :string },
            valid_from: { type: :string, format: :'date-time' },
            valid_to: { type: :string, format: :'date-time' }
          },
          required: [ 'id', 'address', 'property_type', 'num_bedrooms', 'num_sitting_rooms', 'num_kitchens', 'num_bathrooms', 'num_toilets', 'owner', 'description', 'valid_from', 'valid_to' ]

        let(:id) { Property.create(address: 'Doe', property_type: 'Flat', num_bedrooms: 2, num_sitting_rooms: 1, num_kitchens: 1, num_bathrooms: 2, num_toilets: 2, owner: 'John', description: 'A beautiful flat', valid_from: '2023-09-25', valid_to: '2024-09-25').id }
        run_test!
      end

      response '404', 'property not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a property' do
      tags 'Properties'
      parameter name: :id, :in => :path, :type => :string
      parameter name: :property, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          num_bedrooms: { type: :integer },
          num_sitting_rooms: { type: :integer },
          num_kitchens: { type: :integer },
          num_bathrooms: { type: :integer },
          num_toilets: { type: :integer },
          valid_to: { type: :string, format: :'date-time' }
        },
        required: []
      }

      response '200', 'property updated' do
        let(:id) { Property.create(address: 'Doe', property_type: 'Flat', num_bedrooms: 2, num_sitting_rooms: 1, num_kitchens: 1, num_bathrooms: 2, num_toilets: 2, owner: 'John', description: 'A beautiful flat', valid_from: '2023-09-25', valid_to: '2024-09-25').id }
        let(:property) { { description: 'A newly updated beautiful flat' } }
        run_test!
      end

      response '404', 'property not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'Deletes a property' do
      tags 'Properties'
      parameter name: :id, :in => :path, :type => :string

      response '204', 'property deleted' do
        let(:id) { Property.create(address: 'Doe', property_type: 'Flat', num_bedrooms: 2, num_sitting_rooms: 1, num_kitchens: 1, num_bathrooms: 2, num_toilets: 2, owner: 'John', description: 'A beautiful flat', valid_from: '2023-09-25', valid_to: '2024-09-25').id }
        run_test!
      end

      response '404', 'property not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

  end
end
