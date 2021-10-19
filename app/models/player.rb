class Player < ApplicationRecord
  # validates :id, presence: true, uniqueness: true
  validates :email, presence: true
  # , uniqueness: true
  # validates :be_id, presence: true, uniqueness: true
  has_one :waiting_room_player
  has_one :waiting_room, through: :waiting_room_player
  has_one :stack
  has_many :cards, through: :stack
end
