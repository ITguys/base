require 'spec_helper'

describe AddressesController do
  before(:each) do
    create(:district)
  end

  describe "GET cities" do
    it "find the cities by province id" do
      province = Province.first
      cities = province.cities
      get 'cities', id: province.id
      expect(assigns[:cities].to_a).to eq(cities.to_a)
    end
  end

  describe "GET districts" do
    it "find the districts by city id" do
      city = City.first
      districts = city.districts
      get 'districts', id: city.id
      expect(assigns[:districts].to_a).to eq(districts.to_a)
    end
  end

end
