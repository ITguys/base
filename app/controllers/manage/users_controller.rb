class Manage::UsersController < ApplicationController
  layout "manage/application"
  before_action :check_user, only: [ :show, :edit, :update, :destroy ]
  def index
    order_by = params[:order_by] || {created_at: :desc}
    order_by = order_by.first.join(" ")
    @users = User.order(order_by).page(params[:page]).per(AppConfig.paginate.per_page)
  end

  def show
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
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Updated successfully"
      redirect_to manage_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Removed successfully"
    redirect_to manage_users_path
  end

  private

    def check_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :notify_user,
                                   contact_attributes: [:mobile_phone, :birthday, :gender])
    end
end
