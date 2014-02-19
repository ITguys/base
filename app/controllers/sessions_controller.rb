class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  layout 'sessions'

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email],params[:password],params[:remember])
    if @user
      redirect_back_or_to '/'
    else
      flash.now[:error] = "Login failed."
      render :action => "new"
    end
  end

  def destroy
    logout
    redirect_to(:users, :notice => 'Logged out!')
  end
end
