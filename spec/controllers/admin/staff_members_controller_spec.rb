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
    before { get :index }

    it 'assigns the requested staff_members orderd by kana to @staff_members' do
      staff_member1 = create(:staff_member, family_name_kana: 'アイザワ', given_name_kana: 'コウキ')
      staff_member2 = create(:staff_member, family_name_kana: 'ヨシダ', given_name_kana: 'シュン')
      staff_member3 = create(:staff_member, family_name_kana: 'アイザワ', given_name_kana: 'アキ')

      expect(assigns(:staff_members)).to eq [staff_member3, staff_member1, staff_member2]
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns the new instance to @staff_member' do
      expect(assigns(:staff_member)).to be_a_kind_of(StaffMember)
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:staff_member_params) { attributes_for(:staff_member) }
    let(:invalid_staff_member_params) { attributes_for(:staff_member, email: nil) }

    context 'when success' do
      it 'saves the new staff_member' do
        expect { post :create, params: { staff_member: staff_member_params } }
          .to change(StaffMember, :count).by(1)
      end

      it 'shows notice flash' do
        post :create, params: { staff_member: staff_member_params }
        expect(flash[:notice]).to eq '職員アカウントを新規登録しました'
      end

      it 'redirects to admin_staff_members_path' do
        post :create, params: { staff_member: staff_member_params }
        expect(response).to redirect_to admin_staff_members_path
      end
    end

    context 'when failure' do
      context 'when invalid parameter' do
        before do
          @staff_member = create(:staff_member)
          post :create, params: { staff_member: invalid_staff_member_params }
        end

        it 'renders the :new template' do
          expect(response).to render_template :new
        end

        it 'shows the alert flash' do
          expect(flash[:alert]).to eq '職員アカウントの登録に失敗しました'
        end
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
      before do
        @staff_member = create(:staff_member)
        get :edit, params: { id: @staff_member }
      end

      it 'assigns the requested staff_member to @staff_member' do
        expect(assigns(:staff_member)).to eq @staff_member
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
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
      before do
        @staff_member = create(:staff_member)
        patch :update, params: { id: 1, staff_member: staff_member_params }
      end

      it 'updates the requested staff_member' do
        @staff_member.reload
        expect(@staff_member.email).to eq 'test@test.com'
      end

      it 'show notice flash' do
        expect(flash[:notice]).to eq '職員アカウントを更新しました'
      end

      it 'redirects to admin_staff_members_path' do
        expect(response).to redirect_to admin_staff_members_path
      end
    end

    context 'when failure' do
      context 'when invalid parameter' do
        before do
          @staff_member = create(:staff_member)
          patch :update, params: { id: 1, staff_member: invalid_staff_member_params }
        end

        it 'renders the :new template' do
          expect(response).to render_template :edit
        end

        it 'shows the alert flash' do
          expect(flash[:alert]).to eq '職員アカウントの更新に失敗しました'
        end
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
      it 'redirects to edit_admin_staff_member_path' do
        staff_member = create(:staff_member)
        get :show, params: { id: staff_member }
        expect(response).to redirect_to edit_admin_staff_member_path(staff_member)
      end
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
      before { @staff_member = create(:staff_member) }

      it 'destroys the requested staff_member' do
        expect { delete :destroy, params: { id: @staff_member } }
          .to change(StaffMember, :count).by(-1)
      end

      it 'redirects to admin_staff_members_path' do
        delete :destroy, params: { id: @staff_member }
        expect(response).to redirect_to admin_staff_members_path
      end

      it 'shows notice flash' do
        delete :destroy, params: { id: @staff_member }
        expect(flash[:notice]).to eq '職員アカウントを削除しました'
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
