module Api
  module V1

    class PropertiesController < ApplicationController

      # This is to allow cross origin requests for the API
      skip_before_action :verify_authenticity_token, only: [:create]
      skip_before_action :verify_authenticity_token, only: [:update, :destroy]

      before_action :set_property, only: %i[show edit update destroy]

      # GET /properties or /properties.json
      def index
        @properties = Property.all
        render json: @properties
      end

      # GET /properties/1 or /properties/1.json
      def show
        render json: @property
      end

      #get  properties by owner name
      def properties_by_owner
        @properties = Property.where('lOWER(owner) = ?', params[:owner].downcase)
        render json: @properties
      end

      #GET  properties by params
      def findPropertiesByParams
        if params[:owner]
          @properties = Property.where(owner: params[:owner])
        elsif params[:bedrooms] || params[:bathrooms]
          @properties = Property.where(bedrooms: params[:bedrooms], bathrooms: params[:bathrooms])
        elsif params[:property_address]
          @properties = Property.where('LOWER(property_address) ILIKE ?', "%#{params[:property_address].downcase}%")
        else
          @properties = Property.all
        end
        render json: @properties
      end

      #get property by address
      def filter_by_address
        @properties = Property.where("LOWER(property_address) LIKE ?", "%#{params[:property_address].downcase}%")
        render json: @properties
      end

      # GET /properties/new
      def new
        @property = Property.new
      end

      # GET /properties/1/edit
      def edit
      end

      # POST /properties or /properties.json

      def create
        property = Property.create!(property_params)
          render json: { status: 201, message: "Property created successfully", data: property }, status: 201
        rescue ActiveRecord::RecordInvalid => invalid
          render json: { status: 400, message: invalid.record.errors.full_messages }, status: 400
      end

      # PUT /properties/1 or /properties/1.json
      def update
        begin
          property = Property.find(params[:id])
        rescue => exception
          render json: { status: 404, message: "Property not found" }, status: 404
        else
          property.update!(update_property_params)
          render json: { status: 200, message: "Property updated successfully", data: property }
        end
      end

      # DELETE /properties/1 or /properties/1.json
      def destroy
        @property.destroy
        render json: { status: 200, message: "Property deleted successfully" }
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_property
        @property = Property.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def property_params
        params.require(:property).permit(:property_address, :property_type, :bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, :owner, :description, :valid_from, :valid_to)
      end

      def update_property_params
        params.require(:property).permit(:bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, :description, :valid_to)
      end
    end

  end
end
