family_names = %w[
  大島:オオシマ
  阿部:アベ
  吉田:ヨシダ
  森:モリ
]

given_names = %w[
  隼也:シュンヤ
  勇気:ユウキ
  武:タケシ
  紗香:サヤカ
  真理子:マリコ
]

20.times do |i|
  fn = family_names[i % 4].split(':')
  gn = given_names[i % 5].split(':')

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
