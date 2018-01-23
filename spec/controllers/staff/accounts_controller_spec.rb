require 'rails_helper'

describe Staff::AccountsController, 'before action' do
  it_behaves_like 'a staff_member who does not login'
  it_behaves_like 'a staff_member whose session is time out'
  it_behaves_like 'a staff_member who does not active'
end

describe Staff::AccountsController, type: :controller do
  let(:staff_member) { create(:staff_member) }
  before do
    session[:staff_member_id] = staff_member.id
    session[:last_access_time] = 1.second.ago
  end

  describe 'GET #show' do
    before { get :show }
    it { expect(assigns(:staff_member)).to eq staff_member }
    it { expect(response).to render_template :show }
  end

  describe 'GET #edit' do
    before { get :edit }
    it { expect(assigns(:staff_member)).to eq staff_member }
    it { expect(response).to render_template :edit }
  end

  describe 'PATCH #update' do
    let(:new_email) { 'test@test.com' }
    let(:staff_member_params) { attributes_for(:staff_member, email: new_email) }
    let(:invalid_staff_member_params) { attributes_for(:staff_member, email: nil) }
    context 'when success' do
      before { patch :update, params: { staff_member: staff_member_params } }
      it 'updates staff_member\'s email' do
        staff_member.reload
        expect(staff_member.email).to eq new_email
      end
      it { expect(flash[:notice]).to eq 'アカウント情報を更新しました' }
      it { expect(response).to redirect_to staff_account_path }
    end

    context 'when failure' do
      context 'when invalid parameter' do
        before { patch :update, params: { staff_member: invalid_staff_member_params } }
        it { expect(flash[:alert]).to eq 'アカウント情報の更新に失敗しました' }
        it { expect(response).to render_template :edit }
      end

      context 'when raise error' do
        it 'raises parameter missing error' do
          expect { patch :update }
            .to raise_error(ActionController::ParameterMissing, 'param is missing or the value is empty: staff_member')
        end
      end
    end
  end
end
