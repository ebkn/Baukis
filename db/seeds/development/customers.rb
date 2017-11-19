
family_names = %w[
  安藤:アンドウ
  井上:イノウエ
  木村:キムラ
  佐藤:サトウ
  市川:イチカワ
  武井:タケイ
  堀江:ホリエ
  白石:シライシ
  田中:タナカ
  山田:ヤマダ
]

given_names = %w[
  俊介:シュンスケ
  孝一:コウイチ
  大貴:ダイキ
  洸:コウ
  裕也:ユウヤ
  花蓮:カレン
  遥:ハルカ
  若菜:ワカナ
  美紅:ミク
  優子:ユウコ
]

city_names = %w[中央区 文京区 世田谷区 八王子市 町田市 横浜市]

company_names = %w[ABC XYZ BAUKIS CLI UNIQUE FORWARD]

division_names = %w[開発部 人事部 マーケティング部]

address1s = %w[小石川2-4 日本橋4-2 開発2-1 渋谷4-2]

address2s = %w[レイズハイツ301 Rubyビル3F センタービル1103 -3]

i = Customer.create!(
  email: 'customer@test.com',
  family_name: '海老沼',
  given_name: '健一',
  family_name_kana: 'エビヌマ',
  given_name_kana: 'ケンイチ',
  password: 'password',
  birthday: Date.new(1998, 2, 12),
  gender: 'male'
)

i.create_home_address!(
  postal_code: sprintf('%07d', rand(10000000)),
  prefecture: Address::PREFECTURE_NAMES.sample,
  city: city_names.sample,
  address1: address1s.sample,
  address2: address2s.sample
)

i.create_work_address!(
  postal_code: sprintf('%07d', rand(10000000)),
  prefecture: Address::PREFECTURE_NAMES.sample,
  city: company_names.sample,
  address1: address1s.sample,
  address2: address2s.sample
)

10.times do |n|
  10.times do |m|
    fn = family_names[n].split(':')
    gn = given_names[m].split(':')

    c = Customer.create!(
      email: Faker::Internet.email,
      family_name: fn[0],
      given_name: gn[0],
      family_name_kana: fn[1],
      given_name_kana: gn[1],
      password: Faker::Internet.password,
      birthday: 60.years.ago.advance(seconds: rand(40.years)).to_date,
      gender: m < 5 ? 'male' : 'female'
    )

    c.create_home_address!(
      postal_code: sprintf('%07d', rand(10000000)),
      prefecture: Address::PREFECTURE_NAMES.sample,
      city: city_names.sample,
      address1: address1s.sample,
      address2: address2s.sample
    )

    c.create_work_address!(
      postal_code: sprintf('%07d', rand(10000000)),
      company_name: company_names.sample,
      division_name: division_names.sample,
      prefecture: Address::PREFECTURE_NAMES.sample,
      city: city_names.sample,
      address1: address1s.sample,
      address2: address2s.sample
    )
  end
end
