# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trading_record do
    user nil
    type ""
    amount 1
    remark "MyString"
  end
end
