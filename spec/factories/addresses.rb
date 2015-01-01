# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address "MyString"
    type ""
    lat 1.5
    lon 1.5
    user nil
  end
end
