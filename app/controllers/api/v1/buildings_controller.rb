module Api
  module V1
    class BuildingsController < ApiController


      def index
        @buildings = Building.all
        render json: @buildings
      end

      def show
        @building = Building.find(params[:id])
        render json: @building
      end
    end
  end
end