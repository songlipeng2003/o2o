# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :permission do
    name "MyString"
    subject_class "MyString"
    subject_id 1
    action "MyString"
    description "MyText"
  end
end
