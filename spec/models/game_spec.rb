require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "Relationships" do
    it { belong_to(:waiting_room) }
  end
end
