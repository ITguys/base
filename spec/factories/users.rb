# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    ignore do
      user_name 'User'
    end
    sequence(:name) { |n| "#{user_name}#{n}" }
    email {"#{name}@example.com".downcase}
    factory :manager do
      user_name 'Manager'
    end
  end
end
