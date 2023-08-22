module Api
  module V1
    class PropertiesController < ApplicationController

      # This is to allow cross origin requests for the API
      skip_before_action :verify_authenticity_token, only: [:create]
      skip_before_action :verify_authenticity_token, only: [:update, :destroy]
      before_action :set_property, only: [:show, :update, :destroy]

      def index
        if params[:owner].present?
          @properties = Property.where(owner: params[:owner])
        elsif params[:bedrooms].present? || params[:bathrooms].present?
          @properties = Property.where('bedrooms = ? AND bathrooms = ?', params[:bedrooms], params[:bathrooms])
        elsif params[:address].present?
          @properties = Property.where("property_address LIKE ?", "%#{params[:address]}%")
        else
          @properties = Property.all
        end

        render json: @properties, status: :ok
      end

      def show
        render json: @property, status: :ok
      end

      def by_owner
        @properties = Property.where(owner: params[:owner])
        render json: @properties, status: :ok
      end

      def by_address
        @properties = Property.where("property_address LIKE ?", "%#{params[:address]}%")
        render json: @properties, status: :ok
      end

      def by_bedrooms
        @properties = Property.where(bedrooms: params[:bedrooms])
        render json: @properties, status: :ok
      end

      def by_bathrooms
        @properties = Property.where(bathrooms: params[:bathrooms])
        render json: @properties, status: :ok
      end

      def by_filter
        properties = Property.where("owner = :owner OR property_type = :property_type OR
        bedrooms = :bedrooms OR sitting_rooms = :sitting_rooms OR
        kitchens = :kitchens OR bathrooms = :bathrooms OR
        toilets = :toilets OR valid_to = :valid_to",
                                owner: params[:owner], property_type: params[:property_type],
                                bedrooms: params[:bedrooms], sitting_rooms: params[:sitting_rooms],
                                kitchens: params[:kitchens], bathrooms: params[:bathrooms],
                                toilets: params[:toilets], valid_to: params[:valid_to])
        if properties.present?
          render json: properties, status: 200
        else
          render json: { error: "No records found" }, status: 404
        end
      end

      def create
        @property = Property.new(property_params)
        if @property.save
          render json: @property, status: :created
        else
          render json: { error: @property.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      def update
        if @property.update(property_params)
          render json: @property, status: :ok
        else
          render json: { error: @property.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      def destroy
        @property.destroy
        head :no_content, status: :ok
      end

      private

      def set_property
        @property = Property.find(params[:id])
      end

      def property_params
        params.require(:property).permit(:property_address, :property_type, :bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, :owner, :description, :valid_from, :valid_to)
      end

      def update_property_params
        params.require(:property).permit(:bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, :description, :valid_to)
      end
    end
  end
end
