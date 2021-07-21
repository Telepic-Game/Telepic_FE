class User < ApplicationRecord
  validates :email, presence: true
  validates :be_id, presence: true
end
