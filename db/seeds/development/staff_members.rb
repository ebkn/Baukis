StaffMember.create!(
  email: 'staff@test.com',
  family_name: '海老沼',
  given_name: '健一',
  family_name_kana: 'エビヌマ',
  given_name_kana: 'ケンイチ',
  password: 'password',
  start_date: 100.days.ago.to_date,
  end_date: nil,
  suspended: false
)

family_names = %w[
  大島:オオシマ
  阿部:アベ
  高橋:タカハシ
  金田:カネダ
  篠田:シノダ
  山口:ヤマグチ
  吉田:ヨシダ
  森:モリ
]

given_names = %w[
  祐介:ユウスケ
  隼也:シュンヤ
  勇気:ユウキ
  芽衣:メイ
  紗香:サヤカ
  真理子:マリコ
  咲:サキ
]

64.times do |i|
  fn = family_names[i % 8].split(':')
  gn = given_names[i % 7].split(':')

  StaffMember.create!(
    email: Faker::Internet.email,
    family_name: fn[0],
    given_name: gn[0],
    family_name_kana: fn[1],
    given_name_kana: gn[1],
    password: Faker::Internet.password,
    start_date: (100 - i).days.ago.to_date,
    end_date: i.zero? ? Date.today : nil,
    suspended: i == 1
  )
end
