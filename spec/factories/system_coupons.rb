# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :system_coupon do
    product nil
    amount 1.5
    description "MyString"
  end
end
