require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "Validations" do
    it { should validate_presence_of :email }
  end
  describe "Relationships" do
    it { should have_one(:stack) }
    it { should have_many(:cards).through(:stack) }
    it { should have_one(:waiting_room).through(:waiting_room_player) }
  end
end
