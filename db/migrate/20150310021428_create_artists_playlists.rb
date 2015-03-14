class CreateArtistsPlaylists < ActiveRecord::Migration
  def self.up
    create_table :artists_playlists, :id => false do |t|
			t.references :playlist
			t.references :artist
		end
		add_index :artists_playlists, [:playlist_id, :artist_id]
		add_index :artists_playlists, :artist_id
  end

  def self.down
		drop_table :artists_playlists
	end
end



