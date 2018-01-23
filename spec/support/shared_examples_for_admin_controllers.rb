shared_examples 'a administrator who does not login' do
  let(:staff_member) { create(:staff_member) }
  let(:staff_member_params) { attributes_for(:staff_member) }
  subject do
    expect(flash[:alert]).to eq 'ログインしてください'
    expect(response).to redirect_to admin_login_path
  end

  describe 'GET #index' do
    before { get :index }
    it { subject }
  end

  describe 'GET #new' do
    before { get :new }
    it { subject }
  end

  describe 'POST #create' do
    before { post :create, params: { staff_member: staff_member_params } }
    it { subject }
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: staff_member } }
    it { subject }
  end

  describe 'PATCH #update' do
    before { patch :update, params: { id: staff_member, staff_member: staff_member_params } }
    it { subject }
  end

  describe 'GET #show' do
    before { get :show, params: { id: staff_member } }
    it { subject }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: { id: staff_member } }
    it { subject }
  end
end

shared_examples 'a administrator whose session is time out' do
  let(:administrator) { create(:administrator) }
  let(:staff_member) { create(:staff_member) }
  let(:staff_member_params) { attributes_for(:staff_member) }
  before do
    session[:administrator_id] = administrator.id
    session[:last_access_time] = Staff::Base::TIMEOUT.ago.advance(seconds: -1)
  end
  subject do
    expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    expect(response).to redirect_to admin_login_path
  end

  describe 'GET #index' do
    before { get :index }
    it { subject }
  end

  describe 'GET #new' do
    before { get :new }
    it { subject }
  end

  describe 'POST #create' do
    before { post :create, params: { staff_member: staff_member_params } }
    it { subject }
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: staff_member } }
    it { subject }
  end

  describe 'PATCH #update' do
    before { patch :update, params: { id: staff_member, staff_member: staff_member_params } }
    it { subject }
  end

  describe 'GET #show' do
    before { get :show, params: { id: staff_member } }
    it { subject }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: { id: staff_member } }
    it { subject }
  end
end

shared_examples 'a administrator who is suspended' do
  let(:administrator) { create(:administrator, suspended: true) }
  let(:staff_member) { create(:staff_member) }
  let(:staff_member_params) { attributes_for(:staff_member) }
  before do
    session[:administrator_id] = administrator.id
    session[:last_access_time] = 1.second.ago
  end
  subject do
    expect(flash[:alert]).to eq 'アカウントが無効です'
    expect(response).to redirect_to admin_root_path
  end

  describe 'GET #index' do
    before { get :index }
    it { subject }
  end

  describe 'GET #new' do
    before { get :new }
    it { subject }
  end

  describe 'POST #create' do
    before { post :create, params: { staff_member: staff_member_params } }
    it { subject }
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: staff_member } }
    it { subject }
  end

  describe 'PATCH #update' do
    before { patch :update, params: { id: staff_member, staff_member: staff_member_params } }
    it { subject }
  end

  describe 'GET #show' do
    before { get :show, params: { id: staff_member } }
    it { subject }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: { id: staff_member } }
    it { subject }
  end
end
