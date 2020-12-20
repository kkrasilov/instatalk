class User < ApplicationRecord
  before_create :generate_nickname

  has_many :rooms, foreign_key: :admin_id
  has_many :room_users, dependent: :destroy

  scope :online, -> { where(online: true) }

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
