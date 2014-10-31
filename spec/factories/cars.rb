# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :car do
    license_tag "MyString"
    car_model ""
    buy_date "2014-10-31"
  end
end
