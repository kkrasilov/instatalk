class Room < ApplicationRecord
  before_create :generate_token

  belongs_to :admin, class_name: 'User'
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users

  def to_param
    token
  end

  private

  def generate_token
    self.token = SecureRandom.hex(2)
  end
end
