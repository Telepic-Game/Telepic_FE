class Player < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :be_id, presence: true, uniqueness: true

  has_one :stack
  has_many :cards, through: :stack
end
