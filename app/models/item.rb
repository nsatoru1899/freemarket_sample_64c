class Item < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", optional: true
  accepts_nested_attributes_for :brand
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :images, presence: true, length: { minimum: 1, maximum: 10 , message: "は1枚以上登録してください"}
  validates :name, :detail, :status_id, :charge_id, :prefecture_id, :category_id, :day_id, presence: true
  validates :price, presence: true, numericality: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :charge
  belongs_to_active_hash :status
  belongs_to_active_hash :day
end
