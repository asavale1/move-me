class AddUserIdtoSongs < ActiveRecord::Migration
  def change
    add_column :songs, :user_id, :integer
    add_index  :songs, :user_id
  end
end
