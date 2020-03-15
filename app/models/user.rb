class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :card, dependent: :destroy
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  validates :nickname, presence: true
  validates :familyname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角のみで入力してください" }
  validates :firstname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角のみで入力してください" }
  validates :familyname_kana, presence: true, format: { with: /\A[ぁ-んー－]+\z/, message: "全角カタカナのみで入力してください" }
  validates :firstname_kana, presence: true, format: { with: /\A[ぁ-んー－]+\z/, message: "全角カタカナのみで入力してください" }
end
