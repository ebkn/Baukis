FactoryBot.define do
  factory :home_address do
    postal_code { '1234567' }
    prefecture  { '神奈川県' }
    city        { '中央区' }
    address1    { '1-1' }
    address2    { '201' }
  end

  factory :work_address do
    company_name  { 'XYZ' }
    division_name { '開発部' }
    postal_code   { '1234567' }
    prefecture    { '東京都' }
    city          { '渋谷区' }
    address1      { '2-2' }
    address2      { '1101' }
  end
end
