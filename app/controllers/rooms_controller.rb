class RoomsController < ApplicationController
  load_and_authorize_resource


  def index
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true)
  end
  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room
    else
      render :new
    end
  end
  def edit
    @room = Room.find(params[:id])
  end
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to @room
    else
      render :edit
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
end
