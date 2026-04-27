class UsersController < ApplicationController
  load_resource
  load_and_authorize_resource
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).includes(:buildings, :assets, :rooms)
    @pagy, @users = pagy(@users, limit: 7)
  end
  def show
    @user = User.find(params[:id])
   @buildings = @user.buildings.includes(rooms: :assets)
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  private
  def user_params
    if can? :manage, User
    params.require(:user).permit(:first_name,:last_name, :email, :password, :phone, :password_confirmation, :role)
    elsif can? :edit, User
      params.require(:user).permit(:first_name,:last_name, :email, :phone, :password, :password_confirmation)
    end
  end

end
