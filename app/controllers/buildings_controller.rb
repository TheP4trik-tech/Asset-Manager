class BuildingsController < ApplicationController
  load_and_authorize_resource


  def index
    @q = Building.ransack(params[:q])
    @buildings = @q.result(distinct: true)
    @pagy, @buildings = pagy(@buildings, limit: 7)
  end


  def show
    @building = Building.find(params[:id])
    @rooms = @building.rooms
  end

  def edit
    @building = Building.find(params[:id])
    @users = User.all if current_user.super_admin?
  end

  def new
    @building = Building.new
    @users = User.all if current_user.super_admin?
  end

  def destroy
    @building = Building.find(params[:id])
    @building.destroy
    redirect_to buildings_path, notice: "Building deleted successfully"
  end

  def create
    @building = Building.new(building_params)
    @users = User.all

    if @building.save
      respond_to do |format|
        format.turbo_stream { redirect_to @building, notice: "Building created successfully" }
        format.html { redirect_to @building, notice: "Building created successfully" }
      end
    else
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
  @building = Building.find(params[:id])

  respond_to do |format|
    if @building.update(building_params)
      format.turbo_stream
      format.html { redirect_to @building, notice: "Building updated successfully" }
    else
      format.turbo_stream { render :edit, status: :unprocessable_entity }
      format.html { render :edit, status: :unprocessable_entity }
      end
  end
  end

  private
  def building_params
    params.require(:building).permit(:name, :contact_email, :contact_phone, :street, :city, :zip_code, :building_date, :user_id)
  end



end
