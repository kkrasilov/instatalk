class OnlineService
  def initialize(current_user)
    @current_user = current_user
  end

  def make_online!
    @current_user.update!(online: true)

    html = ApplicationController.render(partial: "users/user", locals: { user: @current_user } )

    ActionCable.server.broadcast "appearance_channel", users: @current_user, html: html
  end

  def make_offline!
    if count_unique_connections.zero?
      @current_user.update!(online: false)

      ActionCable.server.broadcast "appearance_channel", users: @current_user
    end
  end

  private

  def count_unique_connections
    ActionCable.server.connections.count do |connection|
      connection.current_user.id == @current_user.id
    end
  end
end
