class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    logger.info "Subscribed to AppearanceChannel"
    stream_from "appearance_channel"

    current_user.online = true
    current_user.save!

    broadcast_appearance
  end

  def unsubscribed
    logger.info "Unsubscribed to AppearanceChannel"

    current_user.online = false
    current_user.save!

    broadcast_appearance
  end

  private

  def broadcast_appearance
    ActionCable.server.broadcast "appearance_channel", users: User.online.map(&:nickname)
  end
end
