class AddSongIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :song_id, :integer
  end
end
