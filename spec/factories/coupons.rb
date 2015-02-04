# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coupon do
    user nil
    system_coupon nil
    amount 1.5
    state "MyString"
    expired_at "MyString"
  end
end
