FactoryBot.define do
  factory :staff_member do
    email            { Faker::Internet.email }
    family_name      { Faker::Japanese::Name.last_name }
    given_name       { Faker::Japanese::Name.first_name }
    family_name_kana { family_name ? family_name.yomi : Faker::Japanese::Name.last_name.yomi }
    given_name_kana  { given_name ? given_name.yomi : Faker::Japanese::Name.first_name.yomi }
    password         { Faker::Internet.password }
    start_date       { Time.zone.yesterday }
    end_date         { Time.zone.tomorrow }
    suspended        false
  end
end
