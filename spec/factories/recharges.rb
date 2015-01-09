# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recharge do
    user nil
    amount 1
    state "MyString"
  end
end
