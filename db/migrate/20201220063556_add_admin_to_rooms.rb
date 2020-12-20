class AddAdminToRooms < ActiveRecord::Migration[5.1]
  def change
    add_reference :rooms, :admin, foreign_key: { to_table: :users }
  end
end
