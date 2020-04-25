FactoryBot.define do
  factory :image do
    src {File.open("#{Rails.root}/public/images/img_cliants01.jpg")}
    # item
  end
end