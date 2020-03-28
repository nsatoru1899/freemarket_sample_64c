class Item < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
  accepts_nested_attributes_for :brand
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :detail, :status_id, :charge_id, :prefecture_code, :day_id, :category_id, presence: true
  validates :price, presence: true, numericality: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :charge
  belongs_to_active_hash :status
  belongs_to_active_hash :day
end
