# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    name "MyString"
    description "MyString"
    code "MyString"
    pay_fee 1.5
  end
end
