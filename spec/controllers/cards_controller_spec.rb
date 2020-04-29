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

  describe 'GET #show' do
    describe 'カード登録が無い場合' do
      before do
        sign_in user
      end
      it "@cardに値が入っていない状態でもshow.html.hamlに遷移する" do
        get :show, params: { id: user }
        expect(response).to render_template :show
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

  describe 'DELETE #destroy' do
    describe 'GET #users/new' do
      before do
        @card = create(:card)
      end
      it "未ログインだとログイン画面に遷移する" do
        delete :destroy, params: { id: @card.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe 'redirect_to :show' do
      before do
        sign_in user
        @card = create(:card, user: user)
        customer = double("Payjp::Customer")
        allow(Payjp::Customer).to receive(:retrieve).and_return(@card)
      end
      it "@cardのデータが登録できたらshow.html.hamlに遷移する" do
        delete :destroy, params: { id: @card.id }
        expect(response).to redirect_to card_path
      end
    end
  end
end
