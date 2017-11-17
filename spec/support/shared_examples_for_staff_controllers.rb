shared_examples 'a staff_member who does not login' do
  describe 'GET #show' do
    before { get :show }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to staff_root_path' do
      expect(response).to redirect_to staff_login_path
    end
  end

  describe 'GET #edit' do
    before { get :edit }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to staff_root_path' do
      expect(response).to redirect_to staff_login_path
    end
  end

  describe 'PATCH #update' do
    let(:staff_member_params) { attributes_for(:staff_member, email: 'test@test.com') }

    before do
      patch :update, params: { staff_member: staff_member_params }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end

    it 'redirects to staff_root_path' do
      expect(response).to redirect_to staff_login_path
    end
  end
end

shared_examples 'a staff_member whose session is time out' do
  let(:staff_member) { create(:staff_member) }

  before do
    session[:staff_member_id] = staff_member.id
    session[:last_access_time] = Staff::Base::TIMEOUT.ago.advance(seconds: -1)
  end

  describe 'GET #show' do
    before { get :show }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to staff_root_path' do
      expect(response).to redirect_to staff_login_path
    end
  end

  describe 'GET #edit' do
    before { get :edit }

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to staff_root_path' do
      expect(response).to redirect_to staff_login_path
    end
  end

  describe 'PATCH #update' do
    let(:staff_member_params) { attributes_for(:staff_member, email: 'test@test.com') }

    before do
      patch :update, params: { staff_member: staff_member_params }
    end

    it 'shows alert flash' do
      expect(flash[:alert]).to eq 'セッションがタイムアウトしました'
    end

    it 'redirects to staff_root_path' do
      expect(response).to redirect_to staff_login_path
    end
  end
end

shared_examples 'a staff_member who does not active' do
  context 'when account is suspended' do
    let(:staff_member) { create(:staff_member, suspended: true) }

    before do
      session[:staff_member_id] = staff_member.id
      session[:last_access_time] = 1.second.ago
    end

    describe 'GET #show' do
      before { get :show }

      it 'shows alert flash' do
        expect(flash[:alert]).to eq 'アカウントが無効です'
      end

      it 'redirects to staff_root_path' do
        expect(response).to redirect_to staff_root_path
      end
    end

    describe 'GET #edit' do
      before { get :edit }

      it 'shows alert flash' do
        expect(flash[:alert]).to eq 'アカウントが無効です'
      end

      it 'redirects to staff_root_path' do
        expect(response).to redirect_to staff_root_path
      end
    end

    describe 'PATCH #update' do
      let(:staff_member_params) { attributes_for(:staff_member, email: 'test@test.com') }

      before do
        patch :update, params: { staff_member: staff_member_params }
      end

      it 'shows alert flash' do
        expect(flash[:alert]).to eq 'アカウントが無効です'
      end

      it 'redirects to staff_root_path' do
        expect(response).to redirect_to staff_root_path
      end
    end
  end

  context 'when start_date is after today' do
    let(:staff_member) { create(:staff_member, start_date: Time.zone.tomorrow, end_date: nil) }

    before do
      session[:staff_member_id] = staff_member.id
      session[:last_access_time] = 1.second.ago
    end

    describe 'GET #show' do
      before { get :show }

      it 'shows alert flash' do
        expect(flash[:alert]).to eq 'アカウントが無効です'
      end

      it 'redirects to staff_root_path' do
        expect(response).to redirect_to staff_root_path
      end
    end

    describe 'GET #edit' do
      before { get :edit }

      it 'shows alert flash' do
        expect(flash[:alert]).to eq 'アカウントが無効です'
      end

      it 'redirects to staff_root_path' do
        expect(response).to redirect_to staff_root_path
      end
    end

    describe 'PATCH #update' do
      let(:staff_member_params) { attributes_for(:staff_member, email: 'test@test.com') }

      before do
        patch :update, params: { staff_member: staff_member_params }
      end

      it 'shows alert flash' do
        expect(flash[:alert]).to eq 'アカウントが無効です'
      end

      it 'redirects to staff_root_path' do
        expect(response).to redirect_to staff_root_path
      end
    end
  end

  context 'when end_date is before today' do
    let(:staff_member) do
      staff_member = build(:staff_member, end_date: Time.zone.yesterday)
      staff_member.email_for_index = staff_member.email.downcase
      staff_member.save(validate: false)
      staff_member
    end

    before do
      session[:staff_member_id] = staff_member.id
      session[:last_access_time] = 1.second.ago
    end

    describe 'GET #show' do
      before { get :show }

      it 'shows alert flash' do
        expect(flash[:alert]).to eq 'アカウントが無効です'
      end

      it 'redirects to staff_root_path' do
        expect(response).to redirect_to staff_root_path
      end
    end

    describe 'GET #edit' do
      before { get :edit }

      it 'shows alert flash' do
        expect(flash[:alert]).to eq 'アカウントが無効です'
      end

      it 'redirects to staff_root_path' do
        expect(response).to redirect_to staff_root_path
      end
    end

    describe 'PATCH #update' do
      let(:staff_member_params) { attributes_for(:staff_member, email: 'test@test.com') }

      before do
        patch :update, params: { staff_member: staff_member_params }
      end

      it 'shows alert flash' do
        expect(flash[:alert]).to eq 'アカウントが無効です'
      end

      it 'redirects to staff_root_path' do
        expect(response).to redirect_to staff_root_path
      end
    end
  end
end
