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
  validates :detail, presence: true
  validates :price, presence: true, numericality: true
  validates :status_id, presence: true
  validates :charge_id, presence: true
  validates :prefecture_code, presence: true
  validates :day_id, presence: true
  validates :category_id, presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :charge
  belongs_to_active_hash :status
  belongs_to_active_hash :day
end
