class CreatePlaylistsSongs < ActiveRecord::Migration
	def self.up
		create_table :playlists_songs, :id => false do |t|
			t.references :playlist
			t.references :song
		end
		add_index :playlists_songs, [:playlist_id, :song_id]
		add_index :playlists_songs, :song_id
	end

	def self.down
		drop_table :playlists_users
	end
end

