class Manage::ApplicationController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout 'manage/application'
  protect_from_forgery with: :exception
  before_action :require_login, except: [:not_authenticated]

  def index
    render text: '', layout: true
  end

  protected

  def not_authenticated
    redirect_to '/login', alert: "Please login first."
  end

end