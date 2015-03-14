class CreateSongsUsers < ActiveRecord::Migration
  def self.up
		create_table :songs_users, :id => false do |t|
			t.references :user
			t.references :song
		end
		add_index :songs_users, [:user_id, :song_id]
		add_index :songs_users, :song_id
	end

  	def self.down
		drop_table :songs_users
	end
end


