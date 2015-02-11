# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :store_user do
    store nil
    username "MyString"
  end
end
