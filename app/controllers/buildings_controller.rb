class BuildingsController < ApplicationController
  load_and_authorize_resource


  def index
    @q = Building.ransack(params[:q])
    @buildings = @q.result(distinct: true)
  end


  def show
    @building = Building.find(params[:id])
    @rooms = @building.rooms
  end

  def edit
    @building = Building.find(params[:id])
  end

  def new
    @building = Building.new
  end

  def destroy
    @building = Building.find(params[:id])
    @building.destroy
    redirect_to buildings_path
  end

  def create
    @building = Building.new(building_params)
    if @building.save
      redirect_to @building
    else
      render :new
    end
  end

  def update
    @building = Building.find(params[:id])
    if @building.update(building_params)
      redirect_to @building
    else
      render :edit, notice: "Please fill out all fields",status: :unprocessable_entity
    end
  end

  private
  def building_params
    params.require(:building).permit(:name, :contact_email, :contact_phone, :street, :city, :zip_code, :building_date, :user_id)
  end


end
