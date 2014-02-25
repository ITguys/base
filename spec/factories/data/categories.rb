# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :data_category, :class => 'Data::Category' do
    sequence(:name) { |n| "分类名称_#{n}" }
    parent_id 1
    description {"描述"}
  end
end
