class Player < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :be_id, presence: true, uniqueness: true
  # require "pry"; binding.pry
  # validates :password, :format => {:with => /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/, multiline: true, message: "There was a problem registering you. Please try again."}

  has_one :stack
  has_many :cards, through: :stack
end
