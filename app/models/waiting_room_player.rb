class WaitingRoomPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :waiting_room

  validates :username, presence: true
end
