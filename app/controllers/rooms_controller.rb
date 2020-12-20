class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :public]

  def index
    @rooms = Room.all
    @room = Room.new
    @users_online = User.online
  end

  def show
  end

  def create
    @room = Room.create!(admin_id: current_user.id)

    redirect_to @room, notice: 'Room was successfully created.'
  end

  def public
    @room.toggle! :public

    redirect_to @room
  end

  private

  def set_room
    @room = Room.find_by(token: params.fetch(:token, params[:id]))
  end
end
