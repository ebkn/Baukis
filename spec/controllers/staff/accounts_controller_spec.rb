require 'rails_helper'

describe Staff::AccountsController, type: :controller do
  let(:staff_member) { create(:staff_member) }
  before { session[:staff_member_id] = staff_member.id }

  describe 'GET #show' do
    before { get :show }

    it 'assigns the current_staff_member to @staff_member' do
      expect(assigns(:staff_member)).to eq staff_member
    end

    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    before { get :edit }

    it 'assigns the current_staff_member to @staff_member' do
      expect(assigns(:staff_member)).to eq staff_member
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'when success' do
      let(:staff_member_params) { attributes_for(:staff_member, email: 'test@test.com') }

      before do
        patch :update, params: { staff_member: staff_member_params }
      end

      it 'shows the notice flash' do
        expect(flash[:notice]).to eq 'アカウント情報を更新しました'
      end

      it 'redirects to staff_account_path' do
        expect(response).to redirect_to staff_account_path
      end
    end

    context 'when failure' do
      context 'when invalid parameter' do
        let(:invalid_staff_member_params) { attributes_for(:staff_member, email: nil) }

        before do
          pending 'I have not implemented validation'
          patch :update, params: { staff_member: invalid_staff_member_params }
        end

        it 'shows the alert flash' do
          expect(flash[:notice]).to eq 'アカウント情報の更新に失敗しました'
        end

        it 'renders the :edit template' do
          expect(response).to render_template :edit
        end
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
