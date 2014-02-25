class Manage::Data::CategoriesController < Manage::Data::ApplicationController

  def index
    @data_categories = Data::Category.active.order(params[:order]).page(params[:page])
    respond_with(@data_categories)
  end

  def show
    @data_category = Data::Category.find params[:id]
    respond_with(@categories)
  end

  def new
    @data_category = Data::Category.new
		@data_category.attributes = Data::Category.find(params[:id]).attributes.slice('name', 'parent_id', 'description') if params[:id]
    render :show
  end

  def edit
    @data_category = Data::Category.find params[:id]
    render :show
  end

  def create
    @data_category = Data::Category.new params.require(:data_category).permit(:name, :parent_id, :description)
    @data_category.save
    render :show
  end

  def update
    @data_category = Data::Category.find params[:id]
    @data_category.update_attributes(params.require(:data_category).permit(:name, :parent_id, :description))
    respond_with(@data_category) do |format|
      format.html { render :show }
      format.js { head @data_category.valid? ? :accepted : :bad_request }
    end
  end

  def destroy
    @data_category = Data::Category.find params[:id]
    @data_category.attributes = {active: false}
    @data_category.save
    respond_with(@data_category) do |format|
      format.html { render :show }
      format.js { head @data_category.valid? ? :accepted : :bad_request }
    end
  end


end
