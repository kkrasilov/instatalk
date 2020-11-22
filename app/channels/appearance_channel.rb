class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    logger.info "Subscribed to AppearanceChannel"

    stream_from "appearance_channel"

    OnlineService.new(current_user).make_online!
  end

  def unsubscribed
    logger.info "Unsubscribed to AppearanceChannel"

    OnlineService.new(current_user).make_offline!
  end
end
