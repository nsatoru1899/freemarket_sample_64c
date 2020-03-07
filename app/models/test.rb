class Test < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :body, presence: true
  validates :image, presence: true
end
