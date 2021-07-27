require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "Validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :be_id }
  end
end
