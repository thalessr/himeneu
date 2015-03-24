require 'faker'
I18n.reload!

FactoryGirl.define do
 factory :provider do
   first_name Faker::Name.first_name
   last_name Faker::Name.last_name
   experience Faker::Lorem.paragraph
   is_deleted false
   profession_list "dev"
   association :user
   addresses {[build(:address)]}
 end
end