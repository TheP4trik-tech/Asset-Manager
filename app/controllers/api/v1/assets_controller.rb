module Api
  module V1
    class AssetsController < ApiController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      before_action :authenticate



      def show
        @asset = Asset.find(params[:id])
        render json: @asset
      end

      def index
        @assets = Asset.all
        render json: @assets
      end


      def update
        @asset = Asset.find(params[:id])
        if @asset.update(asset_params)
          render json: @asset
        end
      end

      def destroy
        @asset = Asset.find(params[:id])
        @asset.destroy
      end

      def asset_params
        params.require(:asset).permit(:name, :description, :image, :building_id)
      end

      private
      def authenticate
        authenticate_or_request_with_http_token do |token, options|
          User.find_by(api_key: token)

        end
      end


    end
  end
end