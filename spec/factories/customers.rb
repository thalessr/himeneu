FactoryGirl.define do
  factory :customer do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    wedding_date Faker::Date.forward(90)
    age 36
    is_deleted false
    association :user
    association :address
  end

end
