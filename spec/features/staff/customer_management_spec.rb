require 'rails_helper'

feature 'customer management by staff' do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member, password: 'password') }
  let!(:customer) { create(:customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario 'register customer' do
    email            = Faker::Internet.email
    password         = Faker::Internet.password
    family_name      = Faker::Japanese::Name.last_name
    given_name       = Faker::Japanese::Name.first_name
    family_name_kana = family_name.yomi
    given_name_kana  = given_name.yomi
    birth_date       = '1970-01-01'
    postal_code      = '1111111'
    city             = '中央区'
    address1         = '千代田1-1-1'
    company_name     = 'XXX'

    click_link '顧客管理'
    click_link '新規登録'

    within('.customer_fields') do
      fill_in 'メールアドレス', with: email
      fill_in 'パスワード', with: password
      fill_in 'form_customer_family_name', with: family_name
      fill_in 'form_customer_given_name', with: given_name
      fill_in 'form_customer_family_name_kana', with: family_name_kana
      fill_in 'form_customer_given_name_kana', with: given_name_kana
      fill_in '生年月日', with: birth_date
      choose '女性'
    end

    check '自宅住所を入力する'

    within('.home_address_fields') do
      fill_in '郵便番号', with: postal_code
      select '東京都', from: '都道府県'
      fill_in '市区町村', with: city
      fill_in '町域、番地等', with: address1
      fill_in '建物名、部屋番号等', with: ''
    end

    check '勤務先を入力する'

    within('.work_address_fields') do
      fill_in '会社名', with: company_name
      fill_in '部署名', with: ''
      fill_in '郵便番号', with: ''
      select '', from: '都道府県'
      fill_in '市区町村', with: ''
      fill_in '町域、番地等', with: ''
      fill_in '建物名、部屋番号等', with: ''
    end

    click_button '登録'

    new_customer = Customer.where(email: email).first

    expect(new_customer.email).to eq email
    expect(new_customer.family_name).to eq family_name
    expect(new_customer.given_name).to eq given_name
    expect(new_customer.family_name_kana).to eq family_name_kana
    expect(new_customer.given_name_kana).to eq given_name_kana
    expect(new_customer.birthday).to eq Date.new(1970, 1, 1)
    expect(new_customer.gender).to eq 'female'

    home_address = new_customer.home_address
    expect(home_address.postal_code).to eq postal_code
    expect(home_address.prefecture).to eq '東京都'
    expect(home_address.city).to eq city
    expect(home_address.address1).to eq address1

    expect(new_customer.work_address.company_name).to eq company_name
  end

  scenario "update customer's information" do
    new_email = Faker::Internet.email
    new_home_address_postal_code = '0000000'
    new_work_address_company_name = 'XXX'

    click_link '顧客管理'
    first('.customers_data').click_link '編集'

    within('.customer_fields') do
      fill_in 'メールアドレス', with: new_email
    end

    within('.home_address_fields') do
      fill_in '郵便番号', with: new_home_address_postal_code
    end

    within('.work_address_fields') do
      fill_in '会社名', with: new_work_address_company_name
    end

    click_button '更新'

    customer.reload
    expect(customer.email).to eq new_email
    expect(customer.home_address.postal_code).to eq new_home_address_postal_code
    expect(customer.work_address.company_name).to eq new_work_address_company_name
  end
end
