class CreateAlbumsPlaylists < ActiveRecord::Migration
	def self.up
		create_table :albums_playlists, :id => false do |t|
			t.references :playlist
			t.references :album
		end
		add_index :albums_playlists, [:playlist_id, :album_id]
		add_index :albums_playlists, :album_id
	end

  	def self.down
		drop_table :albums_playlists
	end
end

