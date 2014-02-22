class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  layout 'sessions'

  def new
    @user = User.new
  end

  def create

    @user = login(params[:email],params[:password],params[:remember])
    if @user
      redirect_back_or_to root_path
    else
      check_login_attempt
      render :action => "new"
    end
  end

  def destroy
    logout
    redirect_to login_path, :notice => 'Logged out!'
  end

  protected

  def check_login_attempt
    @user = User.find_by_email(params[:email])
    if @user.present?
      if @user.locked
        flash.now[:error] = '您的登录失败次数过多，请在1分钟后重试'
      else
        flash.now[:error] = '用户密码错误，请重新输入密码'
      end
    else
      flash.now[:error] = '用户不存在，请检查修改您的邮箱，重新登录'
    end
  end
end
