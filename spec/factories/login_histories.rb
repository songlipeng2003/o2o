# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :login_history do
    user nil
    devise "MyString"
    devise_type 'ios'
    ip "MyString"
  end
end
