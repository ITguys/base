require 'rexml/document'
namespace :db do
  desc "import province_with_cities_with_districies"
  task :province_city_district => :environment do
    begin
      include REXML
      doc = Document.new(File.open("#{Rails.root}/lib/tasks/area.xml"))
      doc.get_elements("//province").each do |pro|
        province = Province.create(:name => pro.attribute("name").value)
        puts "--#{province.name}"
        pro.get_elements("city").each do |ci|
          city = City.create(province: province, name: ci.attribute("name").value)
          puts "------#{city.name}"
          ci.get_elements("country").each do |co|
            district = District.create(city: city, name: co.attribute("name").value)
            puts "------------#{district.name}"
          end
        end
      end
    end
  end
end
