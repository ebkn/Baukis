FactoryGirl.define do
  factory :administrator do
    email     { Faker::Internet.email }
    password  { Faker::Internet.password }
    suspended false
  end
end
