class AddressesController < ApplicationController
  skip_before_action :require_login

  def cities
    @cities = City.where(province_id: params[:id])
    render text: view_context.options_from_collection_for_select(@cities, 'id', 'name')
  end

  def districts
    @districts = District.where(city_id: params[:id])
    render text: view_context.options_from_collection_for_select(@districts, 'id', 'name')
  end

end
