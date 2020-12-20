class AddPublicToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :public, :boolean, default: false
  end
end
