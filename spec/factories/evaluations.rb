# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :evaluation do
    order nil
    score 1
    note "MyString"
  end
end
