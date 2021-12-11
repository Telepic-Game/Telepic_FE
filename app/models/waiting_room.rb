class WaitingRoom < ApplicationRecord
  before_create :generate_room_code

  # validates :room_code, presence: true

  has_many :waiting_room_players
  has_many :players, through: :waiting_room_players
  has_one :game

  private

  def generate_room_code
    self.room_code = SecureRandom.urlsafe_base64(6)
  end
end
