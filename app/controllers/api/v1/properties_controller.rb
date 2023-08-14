module Api
  module V1
    class PropertiesController < ApplicationController
      before_action :set_property, only: [:show, :update, :destroy]

      def index
        if params[:owner].present?
          @properties = Property.where(owner: params[:owner])
        elsif params[:num_bedrooms].present? || params[:num_bathrooms].present?
          @properties = Property.where('num_bedrooms = ? AND num_bathrooms = ?', params[:num_bedrooms], params[:num_bathrooms])
        elsif params[:address].present?
          @properties = Property.where("address LIKE ?", "%#{params[:address]}%")
        else
          @properties = Property.all
        end

        render json: @properties, status: :ok
      end

      def show
        render json: @property, status: :ok
      end

      def create
        @property = Property.new(property_params)
        if @property.save
          render json: @property, status: :created
        else
          render json: @property.errors, status: :unprocessable_entity
        end
      end

      def update
        if @property.update(update_property_params)
          render json: @property, status: :ok
        else
          render json: @property.errors, status: :unprocessable_entity
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
        params.require(:property).permit(:address, :property_type, :num_bedrooms, :num_sitting_rooms, :num_kitchens, :num_bathrooms, :num_toilets, :owner, :description, :valid_from, :valid_to)
      end

      def update_property_params
        params.require(:property).permit(:bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, :description, :valid_to)
      end
    end
  end
end
