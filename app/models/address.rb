class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :postal_code, presence: true, numericality: true
  validates :prefecture_code, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 48 }
  validates :city, presence: true
  validates :block, presence: true
  
end
