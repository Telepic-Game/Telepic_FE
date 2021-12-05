class WaitingRoomPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :waiting_room

  validates :username, presence: true

  after_create_commit { broadcast_prepend_to "waiting_room_players" }
  after_update_commit { broadcast_replace_to "waiting_room_players" }
end
