FactoryGirl.define do
  factory :recommendation do
    association :provider
    association :customer
    rating 0
  end

end
