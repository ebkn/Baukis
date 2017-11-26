require 'rails_helper'

feature 'customer management by staff' do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member, password: 'password') }
  let!(:customer) { create(:customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario "update customer's information" do
    new_email = Faker::Internet.email
    new_home_address_postal_code = '00000000'
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
