require 'rails_helper'

describe Admin::SessionsController, type: :controller do
  describe 'GET #index' do
    it 'redirects to admin_login_path' do
      get :index
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'GET #new' do
    context 'when current_administrator exists' do
      it 'redirects admin_root_path' do
        num = Faker::Number.number(1)
        create(:administrator, id: num)
        session[:administrator_id] = num
        get :new
        expect(response).to redirect_to admin_root_path
      end
    end

    context 'when current_administrator does not exist' do
      before { get :new }

      it 'assigns the login form object to @form' do
        expect(assigns(:form)).to be_a_kind_of(Admin::LoginForm)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    before(:each) do
      @email = Faker::Internet.email
      @password = Faker::Internet.password
    end

    context 'when success to login' do
      before do
        create(:administrator, email: @email, password: @password)
        post :create, params: {
          admin_login_form: { email: @email, password: @password }
        }
      end

      it 'shows notice flash' do
        expect(flash[:notice]).to eq 'ログインしました'
      end

      it 'ridirects admin_root_path' do
        expect(response).to redirect_to admin_root_path
      end
    end

    context 'when failed to login' do
      context 'when form does not filled' do
        context 'when both email and password not found' do
          before do
            post :create, params: {
              admin_login_form: { email: '', password: '' }
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
              admin_login_form: { email: '', password: @password }
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
              admin_login_form: { email: @email, password: '' }
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
            create(:administrator, email: @email, password: @password)
            post :create, params: {
              admin_login_form: { email: another_email, password: @password }
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
          context 'when account suspended' do
            before do
              create(:administrator, email: @email, password: @password, suspended: true)
              post :create, params: {
                admin_login_form: { email: @email, password: @password }
              }
            end

            it 'shows alert flash' do
              expect(flash[:alert]).to eq 'アカウントが凍結されています'
            end

            it 'renders the :new template' do
              expect(response).to render_template :new
            end
          end

          context 'when password is incorrect' do
            before do
              another_password = Faker::Internet.password
              create(:administrator, email: @email, password: @password)
              post :create, params: {
                admin_login_form: { email: @email, password: another_password }
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

  describe 'delete #destroy' do
    before { delete :destroy }

    it 'deletes session :administrator_id' do
      expect(session[:administrator_id]).to be_nil
    end

    it 'shows notice flash' do
      expect(flash[:notice]).to eq 'ログアウトしました'
    end

    it 'redirects admin_root_path' do
      expect(response).to redirect_to admin_root_path
    end
  end
end
