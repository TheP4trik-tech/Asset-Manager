class AssetsController < ApplicationController
  load_and_authorize_resource


  def show
    @asset = Asset.find(params[:id])
  end
  def index
    @q = Asset.ransack(params[:q])
    @assets = @q.result(distinct: true)
  end
  def new
    @asset = Asset.new
    properties_for_current_user
  end
  def create
    properties_for_current_user
    @asset = Asset.new(asset_params)
    if @asset.save
      redirect_to @asset
    else
      render :new
    end
  end
  def edit
    @asset = Asset.find(params[:id])
    properties_for_current_user

  end
  def update
    @asset = Asset.find(params[:id])
    if @asset.update(asset_params)
      redirect_to @asset
    else
      render :edit
    end
  end
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    redirect_to assets_path
  end

  private
  def asset_params
    params.require(:asset).permit(:name, :room_id, :purchase_date, :last_check_date, :purchase_price, :note)
  end

  def properties_for_current_user
    if current_user.super_admin?
      @rooms = Room.all.includes(:building)
      @buildings = Building.all
    elsif current_user.admin?
      @buildings = current_user.buildings
      @rooms = Room.where(building_id: @buildings).includes(:building)

    end
  end
end
