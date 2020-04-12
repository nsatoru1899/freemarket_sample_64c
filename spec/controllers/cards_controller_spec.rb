require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  let(:user) { create(:user, email: 'sample@gmail.com') }

  describe 'GET #new' do
    describe 'カード登録済みの場合' do
      before do
        sign_in user
      end
      it "cardに値が入っているとトップページに遷移する" do
        card = create(:card, user: user)
        get :new
        expect(response).to redirect_to root_path
      end

      it "cardに値が入っていないとカード登録フォームに遷移する" do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    describe 'GET #new' do
      before do
        sign_in user
      end
      it 'payjp-tokenが空の場合、newアクションに遷移する' do
        get :new
        expect(response).to render_template :new
      end
    end
  end
end
