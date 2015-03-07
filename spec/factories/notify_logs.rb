# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notify_log do
    payment nil
    type ""
    params "MyText"
  end
end
