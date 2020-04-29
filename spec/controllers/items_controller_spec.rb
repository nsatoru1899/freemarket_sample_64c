require "rails_helper"

RSpec.describe ItemsController, type: :controller do

  let(:user) { create(:user) }

  describe "GET #new" do
    it "ログインしていないとログインページに遷移する" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
    it "new.html.hamlに遷移すること" do
      login user
      get :new
      expect(response).to render_template :new
    end
  end
end
