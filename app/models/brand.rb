class Brand < ApplicationRecord
  # belongs_to :item, optional: true
  has_many :items
  # validates :name, format: { with: /\A[ぁ-んァ-ン一-龥a-zA-Z0-9]+\z/, message: "に半角カナは使用できません" }
end
