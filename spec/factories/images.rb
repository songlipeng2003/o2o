# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    file "MyString"
    filesize 1
    object nil
  end
end
