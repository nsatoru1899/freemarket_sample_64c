class Card < ApplicationRecord
  belongs_to :user
  validates :card_id, presence: true
  validates :customer_id, presence: true
end