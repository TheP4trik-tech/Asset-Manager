class AssetsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user


  def show
    @asset = Asset.find(params[:id])
    @qr_svg = Qr.call(@asset)

  end
  def index
    @q = Asset.ransack(params[:q])
    @assets = @q.result(distinct: true).includes(room: :building)

    @pagy, @assets = pagy(@assets, limit: 7)

    @search_params = params[:q]&.permit!
    export_path = Rails.root.join('public', 'exports', 'majetek.csv')
    @export_ready = File.exist?(export_path)
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

  def qr_code
    @asset = Asset.find(params[:id])
    svg = Qr.call(@asset)
    render plain: svg, content_type: 'image/svg+xml'
  end

  def export
    CsvExportJob.perform_later(params[:q]&.to_unsafe_h || {})
    redirect_to assets_path, notice: "Export byl zařazen do fronty. Za malý okamžik bude připraven ke stažení níže."
  end

  private
  def asset_params
    params.require(:asset).permit(:name, :room_id, :purchase_date, :last_check_date, :purchase_price, :note)
  end

  def set_user
    Current.user = current_user
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
