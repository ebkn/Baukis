FactoryBot.define do
  factory :staff_member do
    email            { Faker::Internet.email }
    family_name      { Faker::Japanese::Name.last_name }
    given_name       { Faker::Japanese::Name.first_name }
    family_name_kana { family_name.yomi }
    given_name_kana  { given_name.yomi }
    password         { Faker::Internet.password }
    start_date       { Date.yesterday }
    end_date         { Date.tomorrow }
    suspended        false
  end
end
