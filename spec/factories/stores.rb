# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :store do
    name "MyString"
    phone "MyString"
    address "MyString"
    description "MyString"
    good_rate 1.5
    collect_count 1
    score 1.5
  end
end
