FactoryGirl.define do
  factory :staff_member do
    email            Faker::Internet.email
    family_name      Faker::Name.last_name
    given_name       Faker::Name.first_name
    family_name_kana Faker::Name.last_name
    given_name_kana  Faker::Name.first_name
    password         Faker::Internet.password
    start_date       { Date.yesterday }
    end_date         { Date.tomorrow }
    suspended        false
  end
end
