class Room < ApplicationRecord
  before_create :generate_token

  has_many :messaged, dependent: :destroy

  def to_param
    token
  end

  private

  def generate_token
    self.token = SecureRandom.hex(2)
  end
end
