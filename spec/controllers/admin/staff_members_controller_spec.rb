require 'rails_helper'

describe Admin::StaffMembersController, 'before_action' do
  it_behaves_like 'a administrator who does not login'
  it_behaves_like 'a administrator whose session is time out'
  it_behaves_like 'a administrator who is suspended'
end

describe Admin::StaffMembersController, type: :controller do
  let(:administrator) { create(:administrator) }
  before do
    session[:administrator_id] = administrator.id
    session[:last_access_time] = 1.second.ago
  end

  describe 'GET #index' do
    let!(:staff_member1) { create(:staff_member, family_name_kana: 'アイザワ', given_name_kana: 'コウキ') }
    let!(:staff_member2) { create(:staff_member, family_name_kana: 'ヨシダ', given_name_kana: 'シュン') }
    let!(:staff_member3) { create(:staff_member, family_name_kana: 'アイザワ', given_name_kana: 'アキ') }
    before { get :index }
    it 'assigns the requested staff_members orderd by kana to @staff_members' do
      expect(assigns(:staff_members)).to eq [staff_member3, staff_member1, staff_member2]
    end
    it { expect(response).to render_template :index }
  end

  describe 'GET #new' do
    before { get :new }
    it { expect(assigns(:staff_member)).to be_a_kind_of(StaffMember) }
    it { expect(response).to render_template :new }
  end

  describe 'POST #create' do
    let(:staff_member_params) { attributes_for(:staff_member) }
    let(:invalid_staff_member_params) { attributes_for(:staff_member, email: nil) }

    context 'when success' do
      subject { post :create, params: { staff_member: staff_member_params } }
      it 'saves the new staff_member' do
        expect { subject }.to change(StaffMember, :count).by(1)
      end
      context do
        before { subject }
        it { expect(flash[:notice]).to eq '職員アカウントを新規登録しました' }
        it { expect(response).to redirect_to admin_staff_members_path }
      end
    end

    context 'when failure' do
      context 'when invalid parameter' do
        before do
          post :create, params: { staff_member: invalid_staff_member_params }
        end
        it { expect(response).to render_template :new }
        it { expect(flash[:alert]).to eq '職員アカウントの登録に失敗しました' }
      end

      context 'when raise error' do
        it 'raises parameter missing error' do
          expect { post :create }
            .to raise_error(ActionController::ParameterMissing, 'param is missing or the value is empty: staff_member')
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'when success' do
      let(:staff_member) { create(:staff_member) }
      before { get :edit, params: { id: staff_member } }
      it { expect(assigns(:staff_member)).to eq staff_member }
      it { expect(response).to render_template :edit }
    end

    context 'when failure' do
      it 'raises record not found error' do
        expect { get :edit, params: { id: 1 } }
          .to raise_error(ActiveRecord::RecordNotFound, "Couldn't find StaffMember with 'id'=1")
      end
    end
  end

  describe 'PATCH #update' do
    let(:staff_member_params) { attributes_for(:staff_member, email: 'test@test.com') }
    let(:invalid_staff_member_params) { attributes_for(:staff_member, email: nil) }

    context 'when success' do
      let(:staff_member) { create(:staff_member) }
      before do
        patch :update, params: { id: staff_member, staff_member: staff_member_params }
      end
      it 'updates the requested staff_member' do
        staff_member.reload
        expect(staff_member.email).to eq 'test@test.com'
      end
      it { expect(flash[:notice]).to eq '職員アカウントを更新しました' }
      it { expect(response).to redirect_to admin_staff_members_path }
    end

    context 'when failure' do
      context 'when invalid parameter' do
        let(:staff_member) { create(:staff_member) }
        before do
          patch :update, params: { id: staff_member, staff_member: invalid_staff_member_params }
        end
        it { expect(response).to render_template :edit }
        it { expect(flash[:alert]).to eq '職員アカウントの更新に失敗しました' }
      end

      context 'when raise error' do
        it 'raises parameter missing error' do
          create(:staff_member)
          expect { patch :update, params: { id: 1 } }
            .to raise_error(ActionController::ParameterMissing, 'param is missing or the value is empty: staff_member')
        end

        it 'raises record not found error' do
          expect do
            patch :update, params: {
              id: 1,
              staff_member: staff_member_params
            }
          end
            .to raise_error(ActiveRecord::RecordNotFound, "Couldn't find StaffMember with 'id'=1")
        end
      end
    end
  end

  describe 'GET #show' do
    context 'when success' do
      let(:staff_member) { create(:staff_member) }
      before { get :show, params: { id: staff_member } }
      it { expect(response).to redirect_to edit_admin_staff_member_path(staff_member) }
    end

    context 'when failure' do
      it 'raises record not found error' do
        expect { get :show, params: { id: 1 } }
          .to raise_error(ActiveRecord::RecordNotFound, "Couldn't find StaffMember with 'id'=1")
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when success' do
      let!(:staff_member) { create(:staff_member) }
      subject { delete :destroy, params: { id: staff_member } }
      it 'destroys the requested staff_member' do
        expect { subject }.to change(StaffMember, :count).by(-1)
      end
      context do
        before { subject }
        it { expect(response).to redirect_to admin_staff_members_path }
        it { expect(flash[:notice]).to eq '職員アカウントを削除しました' }
      end
    end

    context 'when failure' do
      it 'raises record not found error' do
        expect { delete :destroy, params: { id: 1 } }
          .to raise_error(ActiveRecord::RecordNotFound, "Couldn't find StaffMember with 'id'=1")
      end
    end
  end
end
