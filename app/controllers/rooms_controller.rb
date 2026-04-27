class RoomsController < ApplicationController
  load_and_authorize_resource


  def index
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true).includes(:building, :assets)
    @pagy, @rooms = pagy(@rooms, limit: 7)

  end
  def show
    @room = Room.includes(:assets, :building).find(params[:id])
  end

  def new
    properties_for_current_user
    @room = Room.new
  end
  def create
    properties_for_current_user
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room
    else
      render new_room_path, notice: "Please fill out all fields",status: :unprocessable_entity
    end
  end
  def edit
    @room = Room.find(params[:id])
    properties_for_current_user
  end
  def update
    properties_for_current_user
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to @room
    else
      render :new, notice: "Please fill out all fields",status: :unprocessable_entity
    end
  end
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  private
  def room_params
    params.require(:room).permit(:room_number, :room_date, :building_id, :name)
  end

  def properties_for_current_user
    if current_user.super_admin?
      @buildings = Building.all
    end
    if current_user.admin?
      @buildings = current_user.buildings
    end
  end


end
