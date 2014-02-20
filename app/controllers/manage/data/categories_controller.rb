class Manage::Data::CategoriesController < ApplicationController

  def index
    @categories = Data::Category.where(params[:where]).order(params[:order]).paginate(:page)
  end

  def show

  end


end
