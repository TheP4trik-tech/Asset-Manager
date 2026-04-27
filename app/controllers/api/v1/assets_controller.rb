module Api
  module V1
    class AssetsController < ApiController



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
        else
          render json: @asset.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @asset = Asset.find(params[:id])
        if @asset.destroy
          head :no_content
        else
          render json: { errors: @asset.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def asset_params
        params.require(:asset).permit(:name, :room_id, :purchase_date, :last_check_date, :purchase_price, :note)
      end





    end
  end
end