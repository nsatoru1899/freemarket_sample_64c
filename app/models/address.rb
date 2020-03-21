class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :postal_code, presence: true, numericality: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :block, presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
