FactoryBot.define do
  factory :image do
    src    { "camera_black.png" }
    # src { File.open("#{Rails.root}/public/images/src/1/camera_black.png") }
    # item
  end
end
