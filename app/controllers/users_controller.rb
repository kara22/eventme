class UsersController < ApplicationController
    before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def edit
    authorize @user
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit({avatars: []})
  end
end
