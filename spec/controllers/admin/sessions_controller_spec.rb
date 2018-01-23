require 'rails_helper'

describe Admin::SessionsController, type: :controller do
  describe 'GET #new' do
    context 'when current_administrator exists' do
      before do
        create(:administrator)
        session[:administrator_id] = 1
        session[:last_access_time] = 1.second.ago
        get :new
      end
      it { expect(flash[:notice]).to eq '既にログインしています' }
      it { expect(response).to redirect_to admin_root_path }
    end

    context 'when current_administrator does not exist' do
      before { get :new }
      it 'assigns the login form object to @form' do
        expect(assigns(:form)).to be_a_kind_of(Admin::LoginForm)
      end
      it { expect(response).to render_template :new }
    end
  end

  describe 'POST #create' do
    let(:email)    { Faker::Internet.email }
    let(:password) { Faker::Internet.password }
    let(:another_email)    { "xx#{email}}" }
    let(:another_password) { "xx#{password}" }
    let(:params) { nil }
    subject { post :create, params: { admin_login_form: params } }

    context 'when success to login' do
      let(:params) { { email: email, password: password } }
      before do
        create(:administrator, email: email, password: password)
        subject
      end
      it { expect(flash[:notice]).to eq 'ログインしました' }
      it { expect(response).to redirect_to admin_root_path }
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
          before { subject }
          it { expect(flash[:alert]).to eq 'メールアドレスが間違っています' }
          it { expect(response).to render_template :new }
        end

        context 'when email is correct' do
          context 'when account suspended' do
            let(:params) { { email: email, password: password } }
            before do
              create(:administrator, email: email, password: password, suspended: true)
              subject
            end
            it { expect(flash[:alert]).to eq 'アカウントが凍結されています' }
            it { expect(response).to render_template :new }
          end

          context 'when password is incorrect' do
            let(:params) { { email: email, password: another_password } }
            before do
              create(:administrator, email: email, password: password)
              subject
            end
            it { expect(flash[:alert]).to eq 'パスワードが間違っています' }
            it { expect(response).to render_template :new }
          end
        end
      end
    end
  end

  describe 'delete #destroy' do
    before { delete :destroy }
    it 'deletes session :administrator_id' do
      expect(session[:administrator_id]).to be_nil
    end
    it { expect(flash[:notice]).to eq 'ログアウトしました' }
    it { expect(response).to redirect_to admin_root_path }
  end
end
