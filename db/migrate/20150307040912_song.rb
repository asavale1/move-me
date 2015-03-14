class Song < ActiveRecord::Migration
  def change
  	create_table :songs do |t|
			t.string "name"
			t.integer "link_id"
			t.integer "artist_id"
			t.integer "album_id"

			t.timestamps
    end
  end
end
