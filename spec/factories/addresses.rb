# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    district_id 1
    contact_id 1
    detail "MyString"
  end
end
