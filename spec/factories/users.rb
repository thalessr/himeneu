require 'faker'
I18n.reload!

FactoryGirl.define do
  factory :user do

    email { Faker::Internet.email }
    confirmed_at Faker::Date.backward(7)
    password Faker::Internet.password(8)
    is_completed true
    roles {[FactoryGirl.build(:role)]}

  end
end
