FactoryBot.define do
  factory :item do

    name             { "ppppppppppppppp" }
    price            { 1000 }
    detail           { "pppppppppp" }
    status_id        { 1 }
    prefecture_id    { 4 }
    day_id           { 1 }
    category      { FactoryBot.create(:category) }
    seller           { FactoryBot.create(:user) }
    brand_id         { 1 }
    # brand
    charge_id        { 1 }
    # after(:build) do |item|
    # # carrierwaveの場合
    # item.seller_id = create(:user).id
    # item.images << build(:image)
    # # item.brand_id = create(:brand).id
    # item.category_id = create(:category).id
    # end
  end
end
