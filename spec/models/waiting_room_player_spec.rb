require 'rails_helper'

RSpec.describe WaitingRoomPlayer, type: :model do
  describe "Validations" do
    it { should validate_presence_of :username }
  end
  describe 'Relationships' do
    it { should belong_to :player }
    it { should belong_to :waiting_room }
  end
end
