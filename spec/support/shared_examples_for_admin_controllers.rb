shared_examples 'a administrator who does not login' do
  describe 'GET #index' do
    before { get :index }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'POST #create' do
    let(:staff_member_params) { attributes_for(:staff_member) }

    before { post :create, params: { staff_member: staff_member_params } }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'GET #edit' do
    before do
      staff_member = create(:staff_member)
      get :edit, params: { id: staff_member }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'PATCH #update' do
    let(:staff_member_params) { attributes_for(:staff_member) }

    before do
      create(:staff_member)
      patch :update, params: { id: 1, staff_member: staff_member_params }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'GET #show' do
    before do
      staff_member = create(:staff_member)
      get :show, params: { id: staff_member }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'DELETE #destroy' do
    before do
      @staff_member = create(:staff_member)
      delete :destroy, params: { id: @staff_member }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end
end

shared_examples 'a administrator whose session is time out' do
  let(:administrator) { create(:administrator) }

  before do
    session[:administrator_id] = administrator.id
    session[:last_access_time] = Staff::Base::TIMEOUT.ago.advance(seconds: -1)
  end

  describe 'GET #index' do
    before { get :index }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'POST #create' do
    let(:staff_member_params) { attributes_for(:staff_member) }

    before { post :create, params: { staff_member: staff_member_params } }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'GET #edit' do
    before do
      staff_member = create(:staff_member)
      get :edit, params: { id: staff_member }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'PATCH #update' do
    let(:staff_member_params) { attributes_for(:staff_member) }

    before do
      create(:staff_member)
      patch :update, params: { id: 1, staff_member: staff_member_params }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'GET #show' do
    before do
      staff_member = create(:staff_member)
      get :show, params: { id: staff_member }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end

  describe 'DELETE #destroy' do
    before do
      @staff_member = create(:staff_member)
      delete :destroy, params: { id: @staff_member }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_login_path
    end
  end
end

shared_examples 'a administrator who is suspended' do
  let(:administrator) { create(:administrator, suspended: true) }

  before do
    session[:administrator_id] = administrator.id
    session[:last_access_time] = 1.second.ago
  end

  describe 'GET #index' do
    before { get :index }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'アカウントが無効になりました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_root_path
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'アカウントが無効になりました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_root_path
    end
  end

  describe 'POST #create' do
    let(:staff_member_params) { attributes_for(:staff_member) }

    before { post :create, params: { staff_member: staff_member_params } }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'アカウントが無効になりました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_root_path
    end
  end

  describe 'GET #edit' do
    before do
      staff_member = create(:staff_member)
      get :edit, params: { id: staff_member }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'アカウントが無効になりました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_root_path
    end
  end

  describe 'PATCH #update' do
    let(:staff_member_params) { attributes_for(:staff_member) }

    before do
      create(:staff_member)
      patch :update, params: { id: 1, staff_member: staff_member_params }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'アカウントが無効になりました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_root_path
    end
  end

  describe 'GET #show' do
    before do
      staff_member = create(:staff_member)
      get :show, params: { id: staff_member }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'アカウントが無効になりました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_root_path
    end
  end

  describe 'DELETE #destroy' do
    before do
      @staff_member = create(:staff_member)
      delete :destroy, params: { id: @staff_member }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'アカウントが無効になりました'
    end

    it 'redirects to admin_root_path' do
      expect(response).to redirect_to admin_root_path
    end
  end
end
