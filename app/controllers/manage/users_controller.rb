class Manage::UsersController < ApplicationController
  def index
    @users = User.order('updated_at DESC').page(params[:page]).per(AppConfig.paginate.per_page)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Created successfully"
      redirect_to manage_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Updated successfully"
      redirect_to manage_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Removed successfully"
    redirect_to manage_users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :notify_user,
                                   contact_attributes: [:mobile_phone])
    end
end
