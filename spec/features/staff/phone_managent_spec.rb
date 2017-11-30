require 'rails_helper'

feature 'customer\'s phone managent by staff' do
  include FeaturesSpecHelper

  let(:staff_member) { create(:staff_member, password: 'password') }
  let!(:customer) { create(:customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario 'add customer\'s phone number by staff' do
    phone_number = '090-0000-0000'
    click_link '顧客管理'
    first('.customers_data').click_link '編集'

    fill_in 'form_customer_phones_0_number', with: phone_number
    check 'form_customer_phones_0_primary'
    click_button '更新'

    customer.reload
    expect(customer.personal_phones.size).to eq 1
    expect(customer.personal_phones[0].number).to eq phone_number
  end

  scenario 'add customer\'s home phone number by staff' do
    phone_number = '090-0000-0000'
    click_link '顧客管理'
    first('.customers_data').click_link '編集'

    fill_in 'form_home_address_phones_0_number', with: phone_number
    check 'form_home_address_phones_0_primary'
    click_button '更新'

    customer.reload
    expect(customer.home_address.phones.size).to eq 1
    expect(customer.home_address.phones[0].number).to eq phone_number
  end

  scenario 'add customer\'s work phone number by staff' do
    phone_number = '090-0000-0000'
    click_link '顧客管理'
    first('.customers_data').click_link '編集'

    fill_in 'form_work_address_phones_0_number', with: phone_number
    check 'form_work_address_phones_0_primary'
    click_button '更新'

    customer.reload
    expect(customer.work_address.phones.size).to eq 1
    expect(customer.work_address.phones[0].number).to eq phone_number
  end
end
