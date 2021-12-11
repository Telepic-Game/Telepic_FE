class Game < ApplicationRecord
  # validates :id, presence: true, uniqueness: true
  # has_one :stack, through: :game
  # has_many :cards, through: :stack
  belongs_to :waiting_room
end
