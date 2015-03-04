require 'faker'

FactoryGirl.define do
 factory :address do
   city Faker::Address.city
   phone Faker::PhoneNumber.phone_number
 end
end