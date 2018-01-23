require 'rails_helper'

RSpec.describe Customer::SessionsController, type: :controller do
  describe '#new' do
    context 'when current_customer exists' do
      let(:customer) { create(:customer) }
      before do
        session[:customer_id] = customer.id
        session[:last_access_time] = 1.second.ago
        get :new
      end
      it { expect(flash[:notice]).to eq '既にログイン済みです' }
      it { expect(response).to redirect_to customer_root_path }
    end

    context 'when current_customer does not exist' do
      before { get :new }
      it { expect(assigns(:form)).to be_a_kind_of(Customer::LoginForm) }
      it { expect(response).to render_template :new }
    end
  end

  describe '#create' do
    let(:email)    { Faker::Internet.email }
    let(:password) { Faker::Internet.password }
    let(:another_email)    { "xxx#{email}" }
    let(:another_password) { "xxx#{password}" }
    let(:params) { nil }
    subject { post :create, params: { customer_login_form: params } }

    context 'when success to login' do
      let!(:customer) { create(:customer, email: email, password: password) }

      context 'when remember_me is checked' do
        before do
          post :create, params: {
            customer_login_form: { email: email, password: password, remember_me: '1' }
          }
        end
        it { expect(session[:customer_id]).to be_nil }
        it { expect(response.cookies['customer_id']).to match(/[0-9a-f]{40}\z/) }
        it { expect(flash[:notice]).to eq 'ログインしました' }
        it { expect(response).to redirect_to customer_root_path }
      end

      context 'when remember_me is not checked' do
        let(:params) { { email: email, password: password } }
        before { subject }
        it { expect(session[:customer_id]).to eq customer.id }
        it { expect(cookies[:customer_id]).to be_nil }
        it { expect(flash[:notice]).to eq 'ログインしました' }
        it { expect(response).to redirect_to customer_root_path }
      end
    end

    context 'when failed to login' do
      context 'when form does not filled' do
        context 'when both email and password not found' do
          let(:params) { { email: '', password: '' } }
          before { subject }
          it { expect(flash[:alert]).to eq 'メールアドレスとパスワードを入力してください' }
          it { expect(response).to render_template :new }
        end

        context 'when email not found' do
          let(:params) { { email: '', password: password } }
          before { subject }
          it { expect(flash[:alert]).to eq 'メールアドレスとパスワードを入力してください' }
          it { expect(response).to render_template :new }
        end

        context 'when password not found' do
          let(:params) { { email: email, password: '' } }
          before { subject }
          it { expect(flash[:alert]).to eq 'メールアドレスとパスワードを入力してください' }
          it { expect(response).to render_template :new }
        end
      end

      context 'when form filed' do
        context 'when email is incorrect' do
          let(:params) { { email: another_email, password: password } }
          before do
            create(:customer, email: email, password: password)
            subject
          end
          it { expect(flash[:alert]).to eq 'メールアドレスが間違っています' }
          it { expect(response).to render_template :new }
        end

        context 'when email is correct' do
          context 'when password is incorrect' do
            let(:params) { { email: email, password: another_password } }
            before do
              create(:customer, email: email, password: password)
              subject
            end
            it { expect(flash[:alert]).to eq 'パスワードが間違っています' }
            it { expect(response).to render_template :new }
          end
        end
      end
    end
  end

  describe '#destroy' do
    before { delete :destroy }
    it { expect(session[:customer_id]).to be_nil }
    it { expect(cookies[:customer_id]).to be_nil }
    it { expect(flash[:notice]).to eq 'ログアウトしました' }
    it { expect(response).to redirect_to customer_root_path }
  end
end
