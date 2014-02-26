# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :district do
    name "Test district"
    city
  end
end
