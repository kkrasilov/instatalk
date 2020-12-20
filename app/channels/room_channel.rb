class RoomChannel < ApplicationCable::Channel
  def subscribed
    logger.info "Subscribed to RoomChannel, roomId: #{params[:roomId]}"

    @room = Room.find(params[:roomId])

    stream_from "room_channel_#{@room.id}"

    unless RoomUser.find_by(user_id: current_user, room_id: params[:roomId])
      RoomUser.create!(user_id: current_user.id, room_id: params[:roomId])
      ActionCable.server.broadcast "room_channel_#{@room.id}", user: current_user, subscribed: true
    end

    speak('message' => '* * * joined the room * * *')
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    logger.info "Unsubscribed to RoomChannel"

    ActionCable.server.broadcast "room_channel_#{@room.id}", user: current_user, subscribed: false
    RoomUser.where(user_id: current_user.id).delete_all

    speak('message' => '* * * left the room * * *')
  end

  def speak(data)
    logger.info "RoomChannel, speak: #{data.inspect}"

    MessageService.new(
      body: data['message'], room: @room, user: current_user
    ).perform
  end
end
