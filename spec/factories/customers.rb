FactoryGirl.define do
  factory :customer do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    experience Faker::Lorem.paragraph
    is_deleted false
    association :user
    association :address
  end

end
