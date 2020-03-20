require 'rails_helper'

RSpec.describe User, type: :model do

  it "ニックネームがなければ登録できない" do
    expect(FactoryBot.build(:user, nickname: "")).to_not be_valid
  end

  it "メールアドレスがなければ登録できない" do
    expect(FactoryBot.build(:user, email: "")).to_not be_valid
  end

  it "メールアドレスが重複していたら登録できない" do
    user1 = FactoryBot.create(:user, nickname: "taro", email: "taro@example.com")
    expect(FactoryBot.build(:user, nickname: "ziro", email: user1.email)).to_not be_valid
  end

  it "パスワードがなければ登録できない" do
    expect(FactoryBot.build(:user, password: "")).to_not be_valid
  end

  it "password_confirmationとpasswordが異なる場合保存できない" do
    expect(FactoryBot.build(:user, password: "password", password_confirmation: "passward")).to_not be_valid
  end

  it "苗字がなければ登録できない" do
    expect(FactoryBot.build(:user, familyname: "")).to_not be_valid
  end

  it "名前がなければ登録できない" do
    expect(FactoryBot.build(:user, firstname: "")).to_not be_valid
  end

  it "かな苗字がなければ保存できない" do
    expect(FactoryBot.build(:user, familyname_kana: "")).to_not be_valid
  end

  it "かな名前がなければ保存できない" do
    expect(FactoryBot.build(:user, firstname_kana: "")).to_not be_valid
  end

  it "かな苗字が全角ひらがなでなければ登録できない" do
    expect(FactoryBot.build(:user, familyname_kana: "test")).to_not be_valid
  end

  it "かな名前が全角ひらがなでなければ登録できない" do
    expect(FactoryBot.build(:user, firstname_kana: "taro")).to_not be_valid
  end

  it "電話番号は数値でなければ登録できない" do
    expect(FactoryBot.build(:user, phonenumber: "abc")).to_not be_valid
  end

end
