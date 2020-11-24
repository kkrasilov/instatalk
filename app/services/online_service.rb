class OnlineService
  def initialize(current_user)
    @current_user = current_user
  end

  def make_online!
    @current_user.update!(online: true)

    broadcast_appearance
  end

  def make_offline!
    if count_unique_connections.zero?
      @current_user.update!(online: false)

      broadcast_appearance
    end
  end

  private

  def broadcast_appearance
    ActionCable.server.broadcast "appearance_channel", user: UserSerializer.new(@current_user).as_json
  end

  def count_unique_connections
    ActionCable.server.connections.count do |connection|
      connection.current_user.id == @current_user.id
    end
  end
end
