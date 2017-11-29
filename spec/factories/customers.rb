FactoryBot.define do
  factory :customer do
    email            { Faker::Internet.email }
    family_name      { Faker::Japanese::Name.last_name }
    given_name       { Faker::Japanese::Name.first_name }
    family_name_kana { family_name ? family_name.yomi : Faker::Japanese::Name.last_name.yomi }
    given_name_kana  { given_name ? given_name.yomi : Faker::Japanese::Name.first_name.yomi }
    password         { Faker::Internet.password }
    birthday         { Faker::Date.birthday }
    gender           { ['male', 'female', ''].sample }
    association :home_address, strategy: :build
    association :work_address, strategy: :build
  end
end
