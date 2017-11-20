module FeaturesSpecelper
  def switch_namespace(namespace)
    config = Rails.appliction.config.baukis
    Capybara.app_host = "http://#{config[namespace][:host]}"
  end

  def login_as_staff_member(staff_member, password = 'password')
    visit staff_login_path
    within('#generic-form') do
      fill_in 'メールアドレス', with: staff_member.email
      fill_in 'パスワード', with: password
      click_button 'ログイン'
    end
  end
end
