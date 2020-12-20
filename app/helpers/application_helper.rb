module ApplicationHelper
  def user_is_admin?(room)
    current_user == room.admin
  end
end
