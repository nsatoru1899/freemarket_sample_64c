require 'rails_helper'

RSpec.describe Address, type: :model do

  it "郵便番号がなければ登録できない" do
    expect(FactoryBot.build(:address, postal_code: "")).to_not be_valid
  end

  it "郵便番号が数値でなければ登録できない" do
    expect(FactoryBot.build(:address, postal_code: "")).to_not be_valid
  end

  it "都道府県がなければ登録できない" do
    expect(FactoryBot.build(:address, prefecture_code: "")).to_not be_valid
  end

  it "市区町村がなければ登録できない" do
    expect(FactoryBot.build(:address, city: "")).to_not be_valid
  end

  it "番地がなければ登録できない" do
    expect(FactoryBot.build(:address, block: "")).to_not be_valid
  end

end
