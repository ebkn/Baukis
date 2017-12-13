require 'rails_helper'

RSpec.describe Customer::SessionsController, type: :controller do
  describe '#new' do
    context 'when current_customer exists' do
      let(:customer) { create(:customer) }

      it 'redirects admin_root_path' do
        session[:customer_id] = customer.id
        session[:last_access_time] = 1.second.ago
        get :new
        expect(response).to redirect_to customer_root_path
      end
    end

    context 'when current_customer does not exist' do
      before { get :new }

      it 'assigns the login form object to @form' do
        expect(assigns(:form)).to be_a_kind_of(Customer::LoginForm)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe '#create' do
    before(:each) do
      @email = Faker::Internet.email
      @password = Faker::Internet.password
    end

    context 'when success to login' do
      let!(:customer) { create(:customer, email: @email, password: @password) }

      context 'when remember_me is checked' do
        before do
          post :create, params: {
            customer_login_form: { email: @email, password: @password, remember_me: '1' }
          }
        end

        it 'does not set session[:customer_id]' do
          expect(session[:customer_id]).to be_nil
        end

        it 'sets cookies[:customer_id]' do
          expect(response.cookies['customer_id']).to match(/[0-9a-f]{40}\z/)
        end

        it 'shows notice flash' do
          expect(flash[:notice]).to eq 'ログインしました'
        end

        it 'redirects customer_root_path' do
          expect(response).to redirect_to customer_root_path
        end
      end

      context 'when remember_me is not checked' do
        before do
          post :create, params: {
            customer_login_form: { email: @email, password: @password }
          }
        end

        it 'sets session[:customer_id]' do
          expect(session[:customer_id]).to eq customer.id
        end

        it 'does not set cookies[:customer_id]' do
          expect(cookies[:customer_id]).to be_nil
        end

        it 'shows notice flash' do
          expect(flash[:notice]).to eq 'ログインしました'
        end

        it 'redirects customer_root_path' do
          expect(response).to redirect_to customer_root_path
        end
      end
    end

    context 'when failed to login' do
      context 'when form does not filled' do
        context 'when both email and password not found' do
          before do
            post :create, params: {
              customer_login_form: { email: '', password: '' }
            }
          end

          it 'shows alert flash' do
            expect(flash[:alert]).to eq 'メールアドレスとパスワードを入力してください'
          end

          it 'renders the :new template' do
            expect(response).to render_template :new
          end
        end

        context 'when email not found' do
          before do
            post :create, params: {
              customer_login_form: { email: '', password: @password }
            }
          end

          it 'shows alert flash' do
            expect(flash[:alert]).to eq 'メールアドレスとパスワードを入力してください'
          end

          it 'renders the :new template' do
            expect(response).to render_template :new
          end
        end

        context 'when password not found' do
          before do
            post :create, params: {
              customer_login_form: { email: @email, password: '' }
            }
          end

          it 'shows alert flash' do
            expect(flash[:alert]).to eq 'メールアドレスとパスワードを入力してください'
          end

          it 'renders the :new template' do
            expect(response).to render_template :new
          end
        end
      end

      context 'when form filed' do
        context 'when email is incorrect' do
          before do
            another_email = Faker::Internet.email
            create(:customer, email: @email, password: @password)
            post :create, params: {
              customer_login_form: { email: another_email, password: @password }
            }
          end

          it 'shows alert flash' do
            expect(flash[:alert]).to eq 'メールアドレスが間違っています'
          end

          it 'renders the :new template' do
            expect(response).to render_template :new
          end
        end

        context 'when email is correct' do
          context 'when password is incorrect' do
            before do
              another_password = Faker::Internet.password
              create(:customer, email: @email, password: @password)
              post :create, params: {
                customer_login_form: { email: @email, password: another_password }
              }
            end

            it 'shows alert flash' do
              expect(flash[:alert]).to eq 'パスワードが間違っています'
            end

            it 'renders the :new template' do
              expect(response).to render_template :new
            end
          end
        end
      end
    end
  end

  describe '#destroy' do
    before { delete :destroy }

    it 'deletes session :customer_id' do
      expect(session[:customer_id]).to be_nil
    end

    it 'delete cookie :customer_id' do
      expect(cookies[:customer_id]).to be_nil
    end

    it 'shows notice flash' do
      expect(flash[:notice]).to eq 'ログアウトしました'
    end

    it 'redirects customer_root_path' do
      expect(response).to redirect_to customer_root_path
    end
  end
end
