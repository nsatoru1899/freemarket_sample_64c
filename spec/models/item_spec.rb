require 'rails_helper'

RSpec.describe Item, type: :model do

  # let(:category){create(:category)}

  describe '#create' do

    it "商品名がなければ登録できない" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品の説明がなければ登録できない" do
      item = build(:item, detail: "")
      item.valid?
      expect(item.errors[:detail]).to include("を入力してください")
    end

    # it "カテゴリーがなければ登録できない" do
    #   item = create(:item)
    #   item = build(:item)
    #   item.valid?
    #   expect(item.errors[:category]).to include("を入力してください")
    #  end

    it "商品の状態がなければ登録できない" do
      item = build(:item, status_id: "")
      item.valid?
      expect(item.errors[:status_id]).to include("を入力してください")
    end

    it "配送料がなければ登録できない" do
      item = build(:item, charge_id: "")
      item.valid?
      expect(item.errors[:charge_id]).to include("を入力してください")
    end

    it "発送元の地域がなければ登録できない" do
      item = build(:item, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "発送までの日数がなければ登録できない" do
      item = build(:item, day_id: "")
      item.valid?
      expect(item.errors[:day_id]).to include("を入力してください")
    end

    it "価格がなければ登録できない" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "brandが無くても保存できる" do
      item = build(:item, brand_id: "")
      expect(item).to be_valid
    end

    it "全て揃っている時保存できる" do
      item = build(:item)
      expect(item).to be_valid
    end

  end
end
